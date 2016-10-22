//
//  Engine.m
//  Activity Monitor
//
//  Created by vsnRain on 27.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//
#import "Engine.h"

@implementation Engine{
    
}

static UITextView *logView;

+ (void) setLog:(UITextView *)log{
    @synchronized(self) {
        logView = log;
    }
}

+ (void) addToLog:(NSString*)string{
    dispatch_sync(dispatch_get_main_queue(), ^{
        logView.text=[NSString stringWithFormat:@"%@\n%@", logView.text, string];
        [logView scrollRangeToVisible:NSMakeRange(logView.text.length, 0)];
    });
}

- (void) getProcs{
    self.proc = [[NSMutableArray alloc] init];
    self.sys = [[NSMutableDictionary alloc] init];
    self.mem = [[NSMutableDictionary alloc] init];
    
    //======================================= GET SYSCTL PROCS ===========================================//
    //kern_return_t	kr;
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t buffersize;
    int err;

    err = sysctl(mib, 4, NULL, &buffersize, NULL, 0);
    if (err != 0){
        NSLog(@"sysctl() (FIRST) failed with error: %s", strerror(errno));
        [Engine addToLog:@"sysctl() (FIRST) failed with error"];
        return;
    }
    
    struct kinfo_proc *procs;
    procs = (struct kinfo_proc *)malloc(buffersize);
    
    err = sysctl(mib, 4, procs, &buffersize, NULL, 0);
    if (err != 0) {
        NSLog(@"sysctl() (SECOND) failed with error: %s", strerror(errno));
        [Engine addToLog:@"sysctl() (SECOND) failed with error"];
        free(procs);
        return;
    }
    
    unsigned long count;
    count = buffersize/sizeof(struct kinfo_proc);
    
    float tot_cpu = 0;
    int tot_thr = 0;
    
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *procInfo;
        
        procInfo = [[Engine taskinfoForPid:procs[i].kp_proc.p_pid] mutableCopy];
        if(!procInfo) procInfo = [[NSMutableDictionary alloc] init];
        
        tot_cpu += [[procInfo objectForKey:@"TOT_CPU"] intValue];
        tot_thr += [[procInfo objectForKey:@"TOT_THR"] intValue];
        
        [procInfo setObject:[NSNumber numberWithInt:procs[i].kp_proc.p_pid] forKey:@"PID"];
        [procInfo setObject:[NSNumber numberWithInt:procs[i].kp_eproc.e_pcred.p_ruid] forKey:@"UID"];
        [procInfo setObject:[NSNumber numberWithInt:procs[i].kp_eproc.e_pcred.p_rgid] forKey:@"GID"];
        [procInfo setObject:[NSString stringWithUTF8String:procs[i].kp_proc.p_comm] forKey:@"COMM"];
        
        [self.proc addObject:procInfo];
    }
    
    [self.sys setObject:[NSNumber numberWithFloat:tot_cpu] forKey:@"SYS_CPU"];
    [self.sys setObject:[NSNumber numberWithInt:tot_thr] forKey:@"TOT_THR"];
    
    return;
}

+ (NSDictionary *) taskinfoForPid:(int) pid{
    NSMutableDictionary *res = [[NSMutableDictionary alloc] init];
    kern_return_t	kr;
    
    //======================================= GET MACHPORT ===========================================//
    mach_port_t	machport;
    
    kr = task_for_pid(mach_task_self(), pid, &machport);
    if (kr != KERN_SUCCESS) {
        NSLog(@"task_for_pid() failed with error - %s", (char*)mach_error_string(kr));
        [Engine addToLog:[NSString stringWithFormat:@"task_for_pid() failed with error - %s", (char*)mach_error_string(kr)]];
        return nil;
    }
    
    //======================================= GET TASKINFO ===========================================//
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    
    kr = task_info(machport, TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (kr != KERN_SUCCESS) {
        NSLog(@"task_info() failed with error - %s", (char*)mach_error_string(kr));
        [Engine addToLog:[NSString stringWithFormat:@"task_info() failed with error - %s", (char*)mach_error_string(kr)]];
        return nil;
    }else{
        
        [res setObject:[NSNumber numberWithUnsignedLong:info.resident_size] forKey:@"RES_SIZE"];
        [res setObject:[NSNumber numberWithUnsignedLong:info.virtual_size] forKey:@"VIR_SIZE"];
        //[procInfo setObject:[NSNumber numberWithUnsignedInt:info.suspend_count] forKey:@"SUSPEND_COUNT"];
        [res setObject:[NSNumber numberWithUnsignedInt:info.user_time.seconds] forKey:@"USER_SEC"];
        [res setObject:[NSNumber numberWithUnsignedInt:info.user_time.microseconds] forKey:@"USER_MSEC"];
        [res setObject:[NSNumber numberWithUnsignedInt:info.system_time.seconds] forKey:@"SYS_SEC"];
        [res setObject:[NSNumber numberWithUnsignedInt:info.system_time.microseconds] forKey:@"SYS_MSEC"];
    }
    
    //======================================= GET THREADS ===========================================//
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count = 0;
    
    kr = task_threads(machport, &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        //NSLog(@"task_threads() failed with error - %s", (char*)mach_error_string(kr));
        [Engine addToLog:[NSString stringWithFormat:@"task_threads() failed with error - %s", (char*)mach_error_string(kr)]];
        return nil;
    }
    
    [res setObject:[NSNumber numberWithInt:thread_count] forKey:@"THREAD_COUNT"];
    
    
    //======================================= GET THREAD INFO ===========================================//
    float tot_cpu = 0;
    NSMutableArray *threadList = [[NSMutableArray alloc] initWithCapacity:thread_count];
    
    thread_basic_info_t basic_info_th = NULL;
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    for (int i = 0; i < thread_count; i++){
        thread_info_count = THREAD_INFO_MAX;
        
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            [Engine addToLog:[NSString stringWithFormat:@"thread_info() failed with error - %s", (char*)mach_error_string(kr)]];
            //break;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        //if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
        tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        //}
        
        NSMutableDictionary *threadInfo = [[NSMutableDictionary alloc] init];
        
        [threadInfo setObject:[NSNumber numberWithFloat:(basic_info_th->cpu_usage/(float)TH_USAGE_SCALE * 100.0)] forKey:@"CPU"];
        [threadInfo setObject:[NSNumber numberWithInt:basic_info_th->flags] forKey:@"FLAGS"];
        [threadInfo setObject:[NSNumber numberWithInt:basic_info_th->run_state] forKey:@"RUN_STATE"];
        [threadInfo setObject:[NSNumber numberWithInt:basic_info_th->sleep_time] forKey:@"SLEEP_TIME"];
        [threadInfo setObject:[NSNumber numberWithInt:basic_info_th->suspend_count] forKey:@"SUSPEND_COUNT"];
        [threadInfo setObject:[NSNumber numberWithUnsignedInt:basic_info_th->user_time.seconds] forKey:@"USER_SEC"];
        [threadInfo setObject:[NSNumber numberWithUnsignedInt:basic_info_th->user_time.microseconds] forKey:@"USER_MSEC"];
        [threadInfo setObject:[NSNumber numberWithUnsignedInt:basic_info_th->system_time.seconds] forKey:@"SYS_SEC"];
        [threadInfo setObject:[NSNumber numberWithUnsignedInt:basic_info_th->system_time.microseconds] forKey:@"SYS_MSEC"];
        
        [threadList addObject:threadInfo];
    }
    
    vm_deallocate(mach_task_self(), (vm_address_t)thread_list, thread_count * sizeof(thread_t));
    
    [res setObject:[NSNumber numberWithFloat:tot_cpu] forKey:@"TOT_CPU"];
    [res setObject:[NSNumber numberWithFloat:thread_count] forKey:@"TOT_THR"];
    [res setObject:[threadList copy] forKey:@"THREADS"];
    
    return [res copy];
    
    //vm_deallocate(mach_task_self(), basic_info_th, sizeof(thread_basic_info_t));
    //free(machport);
    //free(size);
    //free(&info);
    
    //vm_deallocate(mach_task_self(), machport, sizeof(mach_port_t));
    
    //vm_deallocate(mach_task_self(), size, sizeof(mach_msg_type_number_t));
    //vm_deallocate(mach_task_self(), info, sizeof(struct task_basic_info));
    
    //vm_deallocate(mach_task_self(), thread_list, sizeof(thread_array_t));
    
    //vm_deallocate(mach_task_self(), thinfo, sizeof(thread_info_data_t));
    ////vm_deallocate(mach_task_self(), basic_info_th, sizeof(thread_basic_info_t));
    //vm_deallocate(mach_task_self(), thread_info_count, sizeof(thread_info_count));
    
    //kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    //assert(kr == KERN_SUCCESS);
}

+ (NSString *) pathForPid:(int) pid{
    
    // First ask the system how big a buffer we should allocate
    int mib[3] = {CTL_KERN, KERN_ARGMAX, 0};
    
    size_t argmaxsize = sizeof(size_t);
    size_t size2;
    
    int ret = sysctl(mib, 2, &size2, &argmaxsize, NULL, 0);
    
    if (ret != 0) {
        //NSLog(@"sysctl() (KERN_ARGMAX) failed with error");
        [Engine addToLog:@"sysctl() (KERN_ARGMAX) failed with error"];
        return @"<failed to get path>";
    }
    
    // Then we can get the path information we actually want
    mib[1] = KERN_PROCARGS2;
    mib[2] = pid;
    
    char *procargv = malloc(size2);
    
    ret = sysctl(mib, 3, procargv, &size2, NULL, 0);
    if (ret != 0) {
        //NSLog(@"sysctl() (PROCARGS2) failed with error");
        [Engine addToLog:@"sysctl() (PROCARGS2) failed with error"];
        return @"<failed to get path>";
    }
    
    // procargv is actually a data structure.
    // The path is at procargv + sizeof(int)
    NSString *res = [NSString stringWithUTF8String:procargv + sizeof(int)];
    
    free(procargv);
    
    return res; 
}

-(void) getMem{
    size_t length;
    int mib[6];
    int result;

    int pagesize;
    
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    length = sizeof(pagesize);
    
    if (sysctl(mib, 2, &pagesize, &length, NULL, 0) < 0){
        //NSLog(@"Failed to get page size");
        [Engine addToLog:@"Failed to get page size"];
    }
    
    [self.mem setObject:[NSNumber numberWithInt:pagesize] forKey:@"PAGESIZE"];

    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;

    vm_statistics_data_t vmstat;
    if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS){
        //NSLog(@"Failed to get VM statistics");
        [Engine addToLog:@"Failed to get VM statistics"];
    }

    
    [self.mem setObject:[NSNumber numberWithInt:pagesize] forKey:@"PAGESIZE"];
    [self.mem setObject:[NSNumber numberWithInt:vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count] forKey:@"TOTAL"];
    [self.mem setObject:[NSNumber numberWithInt:vmstat.wire_count] forKey:@"WIRED"];
    [self.mem setObject:[NSNumber numberWithInt:vmstat.active_count] forKey:@"ACTIVE"];
    [self.mem setObject:[NSNumber numberWithInt:vmstat.inactive_count] forKey:@"INACTIVE"];
    [self.mem setObject:[NSNumber numberWithInt:vmstat.free_count] forKey:@"FREE"];

    mib[0] = CTL_HW;
    mib[1] = HW_PHYSMEM;
    length = sizeof(result);
    
    if (sysctl(mib, 2, &result, &length, NULL, 0) < 0){
        //NSLog(@"Failed to get physical memory");
        [Engine addToLog:@"Failed to get physical memory"];
    }
    [self.mem setObject:[NSNumber numberWithInt:result] forKey:@"PHYS_B"];
    
    mib[0] = CTL_HW;
    mib[1] = HW_USERMEM;
    length = sizeof(result);
    if (sysctl(mib, 2, &result, &length, NULL, 0) < 0){
        //NSLog(@"Failed to get physical memory");
        [Engine addToLog:@"Failed to get user memory"];
    }
    [self.mem setObject:[NSNumber numberWithInt:result] forKey:@"USER_B"];
}

@end
