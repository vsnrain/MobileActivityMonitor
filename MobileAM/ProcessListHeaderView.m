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
        self.sortType = SORT_PID_A;
        self.pidButton.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
    }
    return self;
}

- (IBAction)changeSort:(UIButton *)sender {
    
    for (UIButton *b in self.buttons){
        b.backgroundColor = [UIColor clearColor];
    }
    
    switch (sender.tag) {
        case 1:
            if (self.sortType== SORT_PID_A) {
                self.sortType= SORT_PID_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_PID_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        case 2:
            if (self.sortType== SORT_COM_A) {
                self.sortType= SORT_COM_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_COM_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        case 3:
            if (self.sortType== SORT_USR_A) {
                self.sortType= SORT_USR_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_USR_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        case 4:
            if (self.sortType== SORT_GRP_A) {
                self.sortType= SORT_GRP_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_GRP_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        case 5:
            if (self.sortType== SORT_CPU_A) {
                self.sortType= SORT_CPU_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_CPU_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        case 6:
            if (self.sortType== SORT_THR_A) {
                self.sortType= SORT_THR_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_THR_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
        
        case 7:
            if (self.sortType== SORT_MEM_A) {
                self.sortType= SORT_MEM_D;
                sender.backgroundColor = [UIColor colorWithRed:220/255.f green:80/255.f blue:80/255.f alpha:1];
            }else{
                self.sortType= SORT_MEM_A;
                sender.backgroundColor = [UIColor colorWithRed:20/255.f green:125/255.f blue:250/255.f alpha:1];
            }
            break;
            
        default:
            break;
    }
}

-(void) layoutSubviews{
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
