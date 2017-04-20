//
//  SYHomePageViewController.m
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYHomePageViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SYUserInfoListView.h"

@interface SYHomePageViewController ()<MAMapViewDelegate>
{
    
    BOOL isHiddenStatusBar;

}

@end

@implementation SYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    [self setNav];
    
    [self setMapKit];
    
}

#pragma mark -设置地图
-(void)setMapKit{

    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //关闭指南针
    _mapView.showsCompass= NO;
    
    //不显示比例尺
    _mapView.showsScale= NO;
    
    //显示楼房
    _mapView.showsBuildings = YES;
    
    _mapView.delegate = self;

}

#pragma mark -设置导航栏
-(void)setNav{
    
    UIButton * homePageLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [homePageLeftButton setImage:[UIImage imageNamed:@"leftTopImage_20x20_"] forState:UIControlStateNormal];
    
    [homePageLeftButton setImage:[UIImage imageNamed:@"HomePage_leftBottomImage_Click_20x20_"] forState:UIControlStateHighlighted];
    
    [homePageLeftButton addTarget:self action:@selector(homePageLeftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * homePageRightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [homePageRightButton setImage:[UIImage imageNamed:@"rightTopImage_20x20_"] forState:UIControlStateNormal];
    
    [homePageRightButton setImage:[UIImage imageNamed:@"HomePage_rightTopImage_Click_20x20_"] forState:UIControlStateHighlighted];
    
    [homePageRightButton addTarget:self action:@selector(homePageRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:homePageLeftButton];
    
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ofoLogo_32x17_"]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:homePageRightButton];
    
}

-(void)homePageLeftButtonClick{
    
    isHiddenStatusBar = YES;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
   
    SYUserInfoListView * infoListView = [[SYUserInfoListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    
    
    [self.view addSubview:infoListView];
   
    
    
}

-(BOOL)prefersStatusBarHidden{

    return isHiddenStatusBar;
    
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {

    return UIStatusBarAnimationFade;
}


-(void)homePageRightButtonClick{

    
    
}
@end
