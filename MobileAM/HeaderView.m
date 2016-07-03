//
//  HeaderView.m
//  Activity Monitor
//
//  Created by vsnRain on 07/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView{
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
- (IBAction)pidSort {
    if (_sortType == 'P') _sortType = 'p';
    else _sortType = 'P';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.pidButton.backgroundColor = [UIColor blueColor];
}
- (IBAction)nameSort {
    if (_sortType == 'N') _sortType = 'n';
    else _sortType = 'N';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.nameButton.backgroundColor = [UIColor blueColor];
}

- (IBAction)userSort {
    if (_sortType == 'U') _sortType = 'u';
    else _sortType = 'U';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.userButton.backgroundColor = [UIColor blueColor];
}

- (IBAction)groupSort {
    if (_sortType == 'G') _sortType = 'g';
    else _sortType = 'G';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.groupButton.backgroundColor = [UIColor blueColor];
}

- (IBAction)cpuSort {
    if (_sortType == 'C') _sortType = 'c';
    else _sortType = 'C';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.cpuButton.backgroundColor = [UIColor blueColor];
}

- (IBAction)threadsSort {
    if (_sortType == 'T') _sortType = 't';
    else _sortType = 'T';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.threadsButton.backgroundColor = [UIColor blueColor];
}

- (IBAction)memSort {
    if (_sortType == 'M') _sortType = 'm';
    else _sortType = 'M';
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    self.memButton.backgroundColor = [UIColor blueColor];
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
