//
//  ProcessCell.h
//  Activity Monitor
//
//  Created by vsnRain on 26.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *pidLabel;
@property (nonatomic, strong) IBOutlet UILabel *commLabel;
@property (nonatomic, strong) IBOutlet UILabel *userLabel;
@property (nonatomic, strong) IBOutlet UILabel *groupLabel;
@property (nonatomic, strong) IBOutlet UILabel *cpuLabel;
@property (nonatomic, strong) IBOutlet UILabel *thrLabel;
@property (nonatomic, strong) IBOutlet UILabel *memLabel;

@property (nonatomic, strong) UIView *bgView;

@end
