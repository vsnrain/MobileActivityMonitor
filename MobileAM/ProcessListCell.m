//
//  ProcessListCell.m
//  Activity Monitor
//
//  Created by vsnRain on 26.11.2012.
//  Copyright (c) 2012 vsnRain. All rights reserved.
//

#import "ProcessListCell.h"

@implementation ProcessListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews{
    if (self.frame.size.width < 400){
        self.usrLabelWidthConstraintDynamic.active = NO;
        self.usrLabelWidthConstraintStatic.active = YES;
    }else{
        self.usrLabelWidthConstraintDynamic.active = YES;
        self.usrLabelWidthConstraintStatic.active = NO;
    }
}

@end
