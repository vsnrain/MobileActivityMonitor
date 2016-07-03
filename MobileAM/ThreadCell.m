//
//  ThreadCell.m
//  Activity Monitor
//
//  Created by vsnRain on 28/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import "ThreadCell.h"

@implementation ThreadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
