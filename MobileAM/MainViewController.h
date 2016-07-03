//
//  ViewController.h
//  Activity Monitor
//
//  Created by vsnRain on 26.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessListCell.h"
#import "Engine.h"
#import "ProcessListHeaderView.h"
#import "InfoViewController.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *topBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ProcessListHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *bottomControl;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UITextView *log;
@property (strong, nonatomic) IBOutlet UIView *cpuView;
@property (strong, nonatomic) IBOutlet UIView *memView;

@property (weak, nonatomic) IBOutlet UILabel *procLabel;
@property (weak, nonatomic) IBOutlet UILabel *thrLabel;
@property (weak, nonatomic) IBOutlet UILabel *cpuLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPages;
@property (weak, nonatomic) IBOutlet UILabel *wiredPages;
@property (weak, nonatomic) IBOutlet UILabel *activePages;
@property (weak, nonatomic) IBOutlet UILabel *inactivePages;
@property (weak, nonatomic) IBOutlet UILabel *freePages;

@property (weak, nonatomic) IBOutlet UILabel *totalBytes;
@property (weak, nonatomic) IBOutlet UILabel *wiredBytes;
@property (weak, nonatomic) IBOutlet UILabel *activeBytes;
@property (weak, nonatomic) IBOutlet UILabel *inactiveBytes;
@property (weak, nonatomic) IBOutlet UILabel *freeBytes;

@property (weak, nonatomic) IBOutlet UILabel *wiredPrc;
@property (weak, nonatomic) IBOutlet UILabel *activePrc;
@property (weak, nonatomic) IBOutlet UILabel *inactivePrc;
@property (weak, nonatomic) IBOutlet UILabel *freePrc;

@property (weak, nonatomic) IBOutlet UILabel *pagesize;
@property (weak, nonatomic) IBOutlet UILabel *physical;
@property (weak, nonatomic) IBOutlet UILabel *user;

-(void) refresh;

@end
