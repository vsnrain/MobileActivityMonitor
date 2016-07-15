//
//  HeaderView.h
//  Activity Monitor
//
//  Created by vsnRain on 07/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"

@interface ProcessListHeaderView : UIView

typedef enum {
    SORT_PID_A, SORT_PID_D,
    SORT_COM_A, SORT_COM_D,
    SORT_USR_A, SORT_USR_D,
    SORT_GRP_A, SORT_GRP_D,
    SORT_CPU_A, SORT_CPU_D,
    SORT_THR_A, SORT_THR_D,
    SORT_MEM_A, SORT_MEM_D
} SortType;

@property (nonatomic) SortType sortType;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *pidButton;
@property (weak, nonatomic) IBOutlet UIButton *comButton;
@property (weak, nonatomic) IBOutlet UIButton *usrButton;
@property (weak, nonatomic) IBOutlet UIButton *grpButton;
@property (weak, nonatomic) IBOutlet UIButton *cpuButton;
@property (weak, nonatomic) IBOutlet UIButton *thrButton;
@property (weak, nonatomic) IBOutlet UIButton *memButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usrLabelWidthConstraintStatic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usrLabelWidthConstraintDynamic;

@end
