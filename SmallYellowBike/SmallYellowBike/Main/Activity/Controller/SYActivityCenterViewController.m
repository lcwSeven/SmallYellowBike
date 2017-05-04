//
//  SYActivityCenterViewController.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYActivityCenterViewController.h"

@interface SYActivityCenterViewController ()

@end

@implementation SYActivityCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   [self setNavWithTitle:@"活动中心" withLeftTitle:@"返回" withLeftImage:[UIImage imageNamed:@"backIndicator_30x18_"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

@end
