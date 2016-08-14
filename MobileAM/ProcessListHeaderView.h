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
    SORT_PID,
    SORT_COM,
    SORT_USR,
    SORT_GRP,
    SORT_CPU,
    SORT_THR,
    SORT_MEM
} SortType;

@property (nonatomic) SortType sortType;
@property (nonatomic) BOOL sortOrderAscending;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *pidButton;
@property (weak, nonatomic) IBOutlet UIButton *comButton;
@property (weak, nonatomic) IBOutlet UIButton *usrButton;
@property (weak, nonatomic) IBOutlet UIButton *grpButton;
@property (weak, nonatomic) IBOutlet UIButton *cpuButton;
@property (weak, nonatomic) IBOutlet UIButton *thrButton;
@property (weak, nonatomic) IBOutlet UIButton *memButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pidWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usrWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *grpWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cpuWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thrWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memWidthConstraint;

@end
