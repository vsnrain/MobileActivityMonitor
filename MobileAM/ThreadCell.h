//
//  ThreadCell.h
//  Activity Monitor
//
//  Created by vsnRain on 28/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *thrNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cpuLabel;
@property (weak, nonatomic) IBOutlet UILabel *runStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *suspendCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *systemTimeLabel;

@end
