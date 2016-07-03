//
//  HeaderView.h
//  Activity Monitor
//
//  Created by vsnRain on 07/07/13.
//  Copyright (c) 2013 vsnRain. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"

@interface HeaderView : UIView

@property char sortType;
//@property MainViewController *delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *pidButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UIButton *groupButton;
@property (weak, nonatomic) IBOutlet UIButton *cpuButton;
@property (weak, nonatomic) IBOutlet UIButton *threadsButton;
@property (weak, nonatomic) IBOutlet UIButton *memButton;

@end
