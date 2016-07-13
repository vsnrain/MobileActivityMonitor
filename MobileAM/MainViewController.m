//
//  ViewController.m
//  Activity Monitor
//
//  Created by vsnRain on 26.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import "MainViewController.h"
#import "NSTask.h"

@interface MainViewController (){
    ProcessListHeaderView *headerView;
    BOOL bottomViewActivated;
    
    NSArray *processList;
    
    NSTimer *updateTimer;
    NSTimer *memTimer;
    
    Engine *eng;
}

@end

@implementation MainViewController

- (void) addToLog:(NSString*)string{
    self.log.text=[NSString stringWithFormat:@"%@\n%@",self.log.text, string];
    [self.log scrollRangeToVisible:NSMakeRange(self.log.text.length, 0)];
}

- (void)viewDidLoad{
    [super viewDidLoad];

    // TOP BAR
    self.topBar.delegate = self;
    self.topBar.topItem.title = @"Activity Monitor";
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 64)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:searchButton, nil];
    
    // TABLE VIEW
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 44, 0);
    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"ProcessListHeader" owner:self options:nil] objectAtIndex:0];
    headerView.sortType = 'P';
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProcessListCell" bundle:nil] forCellReuseIdentifier:@"ProcessListCellID"];
    
    // BOTTOM VIEW
    self.bottomView.hidden = YES;
    bottomViewActivated = NO;
    [self.view addSubview:self.bottomView];
    
    // OTHER
    [self.bottomView addSubview: self.log];
    [self.bottomView addSubview: self.procView];
    [self.bottomView addSubview: self.memView];
    
    self.procView.backgroundColor = [UIColor clearColor];
    self.procView.hidden = NO;
    
    self.memView.backgroundColor = [UIColor clearColor];
    self.memView.frame = CGRectMake(0, 0, 800, 157);
    self.memView.hidden = YES;
    
    self.log.frame = CGRectMake(20, 20, 730, 120);
    self.log.hidden = YES;
    
    // TABLE DATA
    processList = [[NSArray alloc] init];
    
    eng = [[Engine alloc] init];
    Engine.log = self.log;
    
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(refresh) userInfo:nil repeats:NO];
}

- (void)viewWillLayoutSubviews{
    // TABLE VIEW
    
    // BOTTOM VIEW
    
    CGRect frame = self.view.superview.frame;
    
    if (bottomViewActivated){
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.75);
        self.bottomView.frame = CGRectMake(0, frame.size.height*0.75, frame.size.width, frame.size.height*0.25);
        
    }else{
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.bottomView.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height*0.25);
    }
}

- (UIBarPosition) positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (BOOL) prefersStatusBarHidden {
    return NO;
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////// BUTTONS ///////////////////////////////////////////////////////////////

- (IBAction) bottomButtonPressed:(UIButton *)sender {
    if (sender.selected){
        
        sender.selected = NO;
        bottomViewActivated = NO;
        
        self.bottomView.hidden = YES;
        
        
        //self.view.frame = CGRectMake(0, 0, self.view.superview.bounds.size.width, self.view.superview.bounds.size.height);
        
        //self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height*0.25);
        
    }else{
        
        sender.selected = YES;
        bottomViewActivated = YES;
        
        //self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.75);
        
        //self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height*0.75, self.view.bounds.size.width, self.view.bounds.size.height*0.25);
        
        self.bottomView.hidden = NO;
    }
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([self.tableView indexPathForSelectedRow].row>=processList.count) [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No process selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];;
    
    int pid = [[[processList objectAtIndex:[self.tableView indexPathForSelectedRow].row] objectForKey:@"PID"] intValue];
    
    BOOL flag = NO;
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            if(kill(pid, 1)!=0) flag = YES;
            break;
        case 2:
            if(kill(pid, 2)!=0) flag = YES;
            break;
        case 3:
            if(kill(pid, 9)!=0) flag = YES;
            break;
        case 4:
            if(kill(pid, 15)!=0) flag = YES;
            break;
            
        default:
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unrecognised signal" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            break;
    }
    
    if (flag) {
        NSString *error = [NSString stringWithFormat:@"Failed to kill process with pid: %d", pid];
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
- (IBAction) buttonInfo {
    if([self.tableView indexPathForSelectedRow].row>=processList.count){
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No process selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else{
        [self performSegueWithIdentifier:@"INFO_SEGUE" sender:self];
    }
}

- (IBAction) buttonKill {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kill" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"HUP", @"SIGINT", @"KILL", @"TERM", nil];
    [alert show];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////// TABLEVIEW ///////////////////////////////////////////////////////////////


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProcessListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessListCellID"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ProcessListCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if(indexPath.row%2==0) cell.contentView.backgroundColor = [UIColor whiteColor];
    else cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.f green:245/255.f blue:249/255.f alpha:1];
    
    cell.pidLabel.text = @"12425";
    cell.commLabel.text = @"test";
    
    /*
    cell.pidLabel.text = [[[processList objectAtIndex:indexPath.row] objectForKey:@"PID"] stringValue];
    cell.commLabel.text = [[processList objectAtIndex:indexPath.row] objectForKey:@"COMM"];
     
    int tmpn;
    NSString *tmps;
     
    tmpn = [[[processList objectAtIndex:indexPath.row] objectForKey:@"UID"] intValue];
    tmps = [NSString stringWithUTF8String:user_from_uid(tmpn, NULL)];
    cell.userLabel.text = [NSString stringWithFormat:@"%@ (%d)", tmps, tmpn];
     
    tmpn = [[[processList objectAtIndex:indexPath.row] objectForKey:@"GID"] intValue];
    tmps = [NSString stringWithUTF8String:group_from_gid(tmpn, NULL)];
    cell.groupLabel.text = [NSString stringWithFormat:@"%@ (%d)", tmps, tmpn];
     
    cell.cpuLabel.text = [NSString stringWithFormat:@"%.2f", [[[processList objectAtIndex:indexPath.row] objectForKey:@"TOT_CPU"] floatValue]];
    [[[processList objectAtIndex:indexPath.row] objectForKey:@"TOT_CPU"] stringValue];
    cell.thrLabel.text = [[[processList objectAtIndex:indexPath.row] objectForKey:@"THREAD_COUNT"] stringValue];
    cell.memLabel.text = [NSString stringWithFormat:@"%.3f MB  ", [[[processList objectAtIndex:indexPath.row] objectForKey:@"RES_SIZE"] intValue]/(float)1048576 ];
    */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  34.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return headerView;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  34.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
    //return processList.count;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////// PPOCESS LIST ////////////////////////////////////////////////////////////

- (void) refresh{
    dispatch_queue_t refreshQueue = dispatch_queue_create("Data Refresh", NULL);
    dispatch_async(refreshQueue, ^{
        
        [eng getProcs];
        
        processList = eng.proc;
        
        NSArray *sortedArray;
        sortedArray = [processList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            if (headerView.sortType == 'P') return [[a objectForKey:@"PID"] compare:[b objectForKey:@"PID"]];
            else if (headerView.sortType == 'p') return [[b objectForKey:@"PID"] compare:[a objectForKey:@"PID"]];
            
            if (headerView.sortType == 'N') return [[[a objectForKey:@"COMM"] lowercaseString] compare:[[b objectForKey:@"COMM"] lowercaseString]];
            else if (headerView.sortType == 'n') return [[[b objectForKey:@"COMM"] lowercaseString] compare:[[a objectForKey:@"COMM"]lowercaseString]];
            
            if (headerView.sortType == 'U') return [[a objectForKey:@"UID"] compare:[b objectForKey:@"UID"]];
            else if (headerView.sortType == 'u') return [[b objectForKey:@"UID"] compare:[a objectForKey:@"UID"]];
            
            if (headerView.sortType == 'G') return [[a objectForKey:@"GID"] compare:[b objectForKey:@"GID"]];
            else if (headerView.sortType == 'g') return [[b objectForKey:@"GID"] compare:[a objectForKey:@"GID"]];
            
            if (headerView.sortType == 'C') return [[a objectForKey:@"TOT_CPU"] compare:[b objectForKey:@"TOT_CPU"]];
            else if (headerView.sortType == 'c') return [[b objectForKey:@"TOT_CPU"] compare:[a objectForKey:@"TOT_CPU"]];
            
            if (headerView.sortType == 'T') return [[a objectForKey:@"THREAD_COUNT"] compare:[b objectForKey:@"THREAD_COUNT"]];
            else if (headerView.sortType == 't') return [[b objectForKey:@"THREAD_COUNT"] compare:[a objectForKey:@"THREAD_COUNT"]];
            
            if (headerView.sortType == 'M') return [[a objectForKey:@"RES_SIZE"] compare:[b objectForKey:@"RES_SIZE"]];
            else if (headerView.sortType == 'm') return [[b objectForKey:@"RES_SIZE"] compare:[a objectForKey:@"RES_SIZE"]];
            
            return [a compare:b];
        }];
        processList = sortedArray;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSIndexPath *index = [self.tableView indexPathForSelectedRow];
            [self.tableView reloadData];
            
            [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:nil];
            
            self.cpuLabel.text = [[eng.sys objectForKey:@"SYS_CPU"] stringValue];
            self.procLabel.text = [[NSNumber numberWithInt:processList.count] stringValue];
            self.thrLabel.text = [[eng.sys objectForKey:@"TOT_THR"] stringValue];
            
            NSLog(@"Data reloaded");
            updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:NO];
        });
    });
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) getMem{
    [eng getMem];
    
    //=========== MEMORY ===============//
    self.pagesize.text = [NSString stringWithFormat:@"%@ B", [eng.mem objectForKey:@"PAGESIZE"]];
    self.physical.text = [NSString stringWithFormat:@"%@ B", [[eng.mem objectForKey:@"PHYS_B"] stringValue]];
    self.user.text = [NSString stringWithFormat:@"%@ B", [[eng.mem objectForKey:@"USER_B"] stringValue]];
    
    self.totalPages.text = [NSString stringWithFormat:@"%d pages", [[eng.mem objectForKey:@"TOTAL"] intValue]];
    self.wiredPages.text = [NSString stringWithFormat:@"%d pages", [[eng.mem objectForKey:@"WIRED"] intValue]];
    self.activePages.text = [NSString stringWithFormat:@"%d pages", [[eng.mem objectForKey:@"ACTIVE"] intValue]];
    self.inactivePages.text = [NSString stringWithFormat:@"%d pages", [[eng.mem objectForKey:@"INACTIVE"] intValue]];
    self.freePages.text = [NSString stringWithFormat:@"%d pages", [[eng.mem objectForKey:@"FREE"] intValue]];
    
    int pagesize = [[eng.mem objectForKey:@"PAGESIZE"] intValue];
    
    self.totalBytes.text = [NSString stringWithFormat:@"%d B", [[eng.mem objectForKey:@"TOTAL"] intValue]*pagesize];
    self.wiredBytes.text = [NSString stringWithFormat:@"%d B", [[eng.mem objectForKey:@"WIRED"] intValue]*pagesize];
    self.activeBytes.text = [NSString stringWithFormat:@"%d B", [[eng.mem objectForKey:@"ACTIVE"] intValue]*pagesize];
    self.inactiveBytes.text = [NSString stringWithFormat:@"%d B", [[eng.mem objectForKey:@"INACTIVE"] intValue]*pagesize];
    self.freeBytes.text = [NSString stringWithFormat:@"%d B", [[eng.mem objectForKey:@"FREE"] intValue]*pagesize];
    
    float total = [[eng.mem objectForKey:@"TOTAL"] intValue];
    
    self.wiredPrc.text = [NSString stringWithFormat:@"%.2f %%", ([[eng.mem objectForKey:@"WIRED"] intValue]/total)*100];
    self.activePrc.text = [NSString stringWithFormat:@"%.2f %%", ([[eng.mem objectForKey:@"ACTIVE"] intValue]/total)*100];
    self.inactivePrc.text = [NSString stringWithFormat:@"%.2f %%", ([[eng.mem objectForKey:@"INACTIVE"] intValue]/total)*100];
    self.freePrc.text = [NSString stringWithFormat:@"%.2f %%", ([[eng.mem objectForKey:@"FREE"] intValue]/total)*100];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@end
