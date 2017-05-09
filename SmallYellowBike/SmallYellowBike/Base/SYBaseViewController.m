//
//  SYBaseViewController.m
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYBaseViewController.h"

@interface SYBaseViewController ()

@end

@implementation SYBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}



-(void)setNavTitle:(NSString*)title{
    
    [self setNavWithTitle:title withLeftTitle:nil withLeftImage:nil withRightTitle:nil withRightImage:nil];
    
}

-(void)setNavTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle {
    
    [self setNavWithTitle:title withLeftTitle:leftTitle withLeftImage:nil withRightTitle:nil withRightImage:nil];
    
}

-(void)setNavWithTitle:(NSString*)title withLeftImage:(UIImage*)leftImage{
    
    [self setNavWithTitle:title withLeftTitle:nil withLeftImage:leftImage withRightTitle:nil withRightImage:nil];
    
}

-(void)setNavWithTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle withLeftImage:(UIImage*)leftImage {
    
    [self setNavWithTitle:title withLeftTitle:leftTitle withLeftImage:leftImage withRightTitle:nil withRightImage:nil];
}



-(void)setNavWithTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle withLeftImage:(UIImage*)leftImage withRightTitle:(NSString*)rightTitle withRightImage:(UIImage*)rightImage{
    
    self.navigationItem.title = title;
    
    UIButton * leftButton = [[UIButton alloc]init];
    
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    
    [leftButton setTitle:leftTitle forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton sizeToFit];
    
    UIButton * rightButton = [[UIButton alloc]init];
    
    [rightButton setTitle:rightTitle forState:UIControlStateNormal];
    
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton sizeToFit];
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    leftSpacer.width = -10;
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    UIBarButtonItem * rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    rightSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftSpacer, leftBarButtonItem, nil];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightSpacer,rightBarButtonItem,nil];
    
    
}


-(void)leftButtonClick:(UIButton*)leftButton{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton*)rightButton{}
@end
