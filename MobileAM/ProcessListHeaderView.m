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
        self.sortType = SORT_PID;
        self.sortOrderAscending = YES;
        self.pidButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
    }
    return self;
}

- (IBAction)changeSort:(UIButton *)sender {
    
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    
    SortType newSortType = SORT_PID;
    
    switch (sender.tag) {
        case 1:
            newSortType = SORT_PID;
            break;
            
        case 2:
            newSortType = SORT_COM;
            break;
            
        case 3:
            newSortType = SORT_USR;
            break;
            
        case 4:
            newSortType = SORT_GRP;
            break;
            
        case 5:
            newSortType = SORT_CPU;
            break;
            
        case 6:
            newSortType = SORT_THR;
            break;
        
        case 7:
            newSortType = SORT_MEM;
            break;
            
        default:
            break;
    }
    
    if (self.sortType == newSortType){
        self.sortOrderAscending = !self.sortOrderAscending;
    }else{
        self.sortType = newSortType;
        self.sortOrderAscending = YES;
    }
    
    if (self.sortOrderAscending){
        sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
    }else{
        sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
    }
}

- (void)layoutSubviews{
    if (self.frame.size.width < 500){
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
