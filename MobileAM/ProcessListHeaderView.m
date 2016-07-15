//
//  ProcessListHeaderView.m
//  Activity Monitor
//
//  Created by vsnRain on 07/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import "ProcessListHeaderView.h"

@implementation ProcessListHeaderView{
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sortType = 'P';
    }
    return self;
}

- (IBAction)changeSort {

}


- (IBAction)pidSort {
    if (_sortType == 'P') _sortType = 'p';
    else _sortType = 'P';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.pidButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}
- (IBAction)nameSort {
    if (_sortType == 'N') _sortType = 'n';
    else _sortType = 'N';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.nameButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}

- (IBAction)userSort {
    if (_sortType == 'U') _sortType = 'u';
    else _sortType = 'U';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.userButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}

- (IBAction)groupSort {
    if (_sortType == 'G') _sortType = 'g';
    else _sortType = 'G';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.groupButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}

- (IBAction)cpuSort {
    if (_sortType == 'C') _sortType = 'c';
    else _sortType = 'C';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.cpuButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}

- (IBAction)threadsSort {
    if (_sortType == 'T') _sortType = 't';
    else _sortType = 'T';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.threadsButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
}

- (IBAction)memSort {
    if (_sortType == 'M') _sortType = 'm';
    else _sortType = 'M';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.memButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
