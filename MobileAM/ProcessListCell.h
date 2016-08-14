//
//  ProcessListCell.h
//  Activity Monitor
//
//  Created by vsnRain on 26.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessListCell : UITableViewCell

@property (strong, nonatomic) NSString *usrLabelShort;
@property (strong, nonatomic) NSString *usrLabelLong;
@property (strong, nonatomic) NSString *grpLabelShort;
@property (strong, nonatomic) NSString *grpLabelLong;

@property (nonatomic, strong) IBOutlet UILabel *pidLabel;
@property (nonatomic, strong) IBOutlet UILabel *comLabel;
@property (nonatomic, strong) IBOutlet UILabel *usrLabel;
@property (nonatomic, strong) IBOutlet UILabel *grpLabel;
@property (nonatomic, strong) IBOutlet UILabel *cpuLabel;
@property (nonatomic, strong) IBOutlet UILabel *thrLabel;
@property (nonatomic, strong) IBOutlet UILabel *memLabel;

@property (nonatomic, strong) IBOutlet UIImageView *procIcon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pidWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usrWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *grpWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cpuWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thrWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memWidthConstraint;

@end
