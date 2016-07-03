//
//  Engine.h
//  Activity Monitor
//
//  Created by vsnRain on 27.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <pwd.h>
#include <grp.h>
#include <stdio.h>
#include <sys/sysctl.h>

#include <mach/mach.h>
#include <mach/task.h>
#include <mach/mach_traps.h>
#include <mach/mach_error.h>

@interface Engine : NSObject

+ (void) setLog:(UITextView *) logView;

+ (void) addToLog:(NSString*) string;

@property (nonatomic, strong) NSMutableDictionary *sys;
@property (nonatomic, strong) NSMutableDictionary *mem;
@property (nonatomic, strong) NSMutableArray *proc;

- (void) getMem;
- (void) getProcs;

+ (NSString *) pathForPid:(int)pid;
+ (NSDictionary *) taskinfoForPid:(int)pid;
@end
