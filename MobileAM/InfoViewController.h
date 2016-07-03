//
//  InfoViewController.h
//  Activity Monitor
//
//  Created by vsnRain on 15/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Engine.h"
#import "ThreadCell.h"

@interface InfoViewController : UIViewController

@property (strong, nonatomic) NSNumber *pid;
@property (strong, nonatomic) NSString *comm;

@property (weak, nonatomic) IBOutlet UITableView *threadTable;

@property (weak, nonatomic) IBOutlet UIImageView *procImage;

@property (weak, nonatomic) IBOutlet UILabel *procNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pidLabel;
@property (weak, nonatomic) IBOutlet UILabel *launchPathLabel;

@property (weak, nonatomic) IBOutlet UILabel *resSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *virtSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *usrTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sysTimeLabel;


@end
