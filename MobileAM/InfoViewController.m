//
//  InfoViewController.m
//  Activity Monitor
//
//  Created by vsnRain on 15/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController (){
    NSArray *threads;
    NSTimer *updateTimer;
}

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    threads = [[NSArray alloc] init];
    
    self.procNameLabel.text = self.comm;
    self.pidLabel.text = [self.pid stringValue];
    if([self.pid intValue]!=0) self.launchPathLabel.text = [Engine pathForPid:[self.pid intValue]];
    
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

-(void) refresh{
    NSDictionary *task = [Engine taskinfoForPid:[self.pid intValue]];
    
    if (task){
        self.resSizeLabel.text = [NSString stringWithFormat:@"%@ B", [task objectForKey:@"RES_SIZE"]];
        self.virtSizeLabel.text = [NSString stringWithFormat:@"%@ B", [task objectForKey:@"VIR_SIZE"]];
        self.sysTimeLabel.text = [NSString stringWithFormat:@"%@ s %@ ms", [task objectForKey:@"USER_SEC"], [task objectForKey:@"USER_MSEC"]];
        self.usrTimeLabel.text = [NSString stringWithFormat:@"%@ s %@ ms", [task objectForKey:@"SYS_SEC"], [task objectForKey:@"SYS_MSEC"]];
        
        threads = [task objectForKey:@"THREADS"];
        [self.threadTable reloadData];
    }
}

//////////////////////////////////////////////////// TABLEVIEW ///////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [threads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThreadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadCellID"];
    
    if (cell == nil) {
        cell = [[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThreadCellID"];
    }
    
    if (indexPath.row%2==0) cell.contentView.backgroundColor = [UIColor whiteColor];
    else cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.f green:245/255.f blue:249/255.f alpha:1];
    
    cell.thrNumLabel.text = [[NSNumber numberWithInteger:indexPath.row] stringValue];
    cell.cpuLabel.text = [NSString stringWithFormat:@"%.2f",[[[threads objectAtIndex:indexPath.row] objectForKey:@"CPU"] floatValue]];
    cell.runStateLabel.text = [[[threads objectAtIndex:indexPath.row] objectForKey:@"RUN_STATE"] stringValue];
    cell.sleepTimeLabel.text = [[[threads objectAtIndex:indexPath.row] objectForKey:@"SLEEP_TIME"] stringValue];
    cell.suspendCountLabel.text = [[[threads objectAtIndex:indexPath.row] objectForKey:@"SUSPEND_COUNT"] stringValue];
    cell.systemTimeLabel.text = [NSString stringWithFormat:@"%@ s %@ ms", [[threads objectAtIndex:indexPath.row] objectForKey:@"USER_SEC"], [[threads objectAtIndex:indexPath.row] objectForKey:@"USER_MSEC"]];
    cell.userTimeLabel.text = [NSString stringWithFormat:@"%@ s %@ ms", [[threads objectAtIndex:indexPath.row] objectForKey:@"SYS_SEC"], [[threads objectAtIndex:indexPath.row] objectForKey:@"SYS_MSEC"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  34.0;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.superview.bounds = CGRectMake(100, 0, 740, 600);
}

- (void) viewDidAppear:(BOOL)animated{
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) self.view.superview.frame = CGRectMake(14, 212, 740, 600);
    else self.view.superview.frame = CGRectMake(94, 142, 600, 740);
    self.view.superview.bounds = CGRectMake(0, 0, 740, 600);
}

-(void) viewDidDisappear:(BOOL)animated{
    [updateTimer invalidate];
    updateTimer = nil;
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [updateTimer invalidate];
    updateTimer = nil;
    [self setThreadTable:nil];
    [self setResSizeLabel:nil];
    [self setVirtSizeLabel:nil];
    [self setUsrTimeLabel:nil];
    [self setSysTimeLabel:nil];
    [self setProcNameLabel:nil];
    [self setLaunchPathLabel:nil];
    [self setPidLabel:nil];
    [self setProcImage:nil];
    [super viewDidUnload];
}
@end
