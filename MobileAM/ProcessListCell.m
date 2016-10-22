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

- (void)layoutSubviews{
    
    //int totalWidth = self.frame.size.width;
    //float normWidth = totalWidth/100.0f;
    
    if (self.frame.size.width < 500){
        
        self.pidWidthConstraint.constant = 60;
        //self.comWidthConstraint.constant = normWidth * 40;
        self.usrWidthConstraint.constant = 0;
        self.grpWidthConstraint.constant = 0;
        self.cpuWidthConstraint.constant = 80;
        self.thrWidthConstraint.constant = 0;
        self.memWidthConstraint.constant = 80;
        
    }else{
        self.pidWidthConstraint.constant = 60;
        //self.comWidthConstraint.constant = normWidth * 40;
        self.usrWidthConstraint.constant = 20;
        self.grpWidthConstraint.constant = 20;
        self.cpuWidthConstraint.constant = 80;
        self.thrWidthConstraint.constant = 40;
        self.memWidthConstraint.constant = 80;
    }
}

@end
