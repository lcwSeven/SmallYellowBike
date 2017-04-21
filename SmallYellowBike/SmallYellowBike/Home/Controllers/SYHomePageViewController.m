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
#import <AMapLocationKit/AMapLocationKit.h>
#import "SYUserInfoListView.h"

@interface SYHomePageViewController ()<MAMapViewDelegate,SYUserInfoListViewDelegate>
{
    
    BOOL isHiddenStatusBar;

}

@property (nonatomic ,strong)AMapLocationManager * locationManger;


@property (nonatomic ,strong) MAMapView *mapView;

@end

@implementation SYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNav];
    
    [self setMapKit];
    
    [self setUserBike];
    
    [self setLocManage];
    
}

#pragma mark -设置定位
-(void)setLocManage{

    self.locationManger = [[AMapLocationManager alloc]init];
    
    self.locationManger.distanceFilter = 200;
    
    [self.locationManger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [self.locationManger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error){
         
            if (error.code == AMapLocationErrorLocateFailed) return;
        }
        
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        
      
    }];
    
}

#pragma mark -设置地图
-(void)setMapKit{

    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:mapView];
    
    mapView.showsUserLocation = YES;
    
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //关闭指南针
    mapView.showsCompass= NO;
    
    //不显示比例尺
    mapView.showsScale= NO;
    
    //显示楼房
    mapView.showsBuildings = YES;
    
    mapView.delegate = self;
    
    [mapView setZoomLevel:15 animated:YES];


    self.mapView = mapView;
   
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


#pragma mark -设置用车按钮

-(void)setUserBike{
    
    CAGradientLayer *layer = [CAGradientLayer layer];

    layer.colors = [NSArray arrayWithObjects:(id)   [[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor,(id)[UIColor whiteColor].CGColor, nil];

    layer.frame = CGRectMake(0, SCREENH_HEIGHT-250, SCREEN_WIDTH, 250);
    
    [self.view.layer addSublayer:layer];
    
    UIButton * userBikeButton = [[UIButton alloc]init];
    
    [userBikeButton setTitle:@"立即用车" forState:UIControlStateNormal];
    
    [userBikeButton setTitleColor:SYFontYellow forState:UIControlStateNormal];
    
    userBikeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [userBikeButton setBackgroundImage:[UIImage imageNamed:@"HomePage_UseBike_h_100x100_"] forState:UIControlStateNormal];

    [self.view addSubview:userBikeButton];
    
    [userBikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        
        make.size.mas_equalTo(80);
    }];
    
    
    UIButton * locationButton = [[UIButton alloc]init];
    
    [locationButton setBackgroundImage:[UIImage imageNamed:@"leftBottomImage_60x60_"] forState:UIControlStateNormal];
    
    [locationButton setBackgroundImage:[UIImage imageNamed:@"HomePage_rightBottomBackground_60x60_"] forState:UIControlStateSelected];
    
    [locationButton setImage:[UIImage imageNamed:@"leftBottomRefreshImage_21x21_"] forState:UIControlStateSelected];
    
    [self.view addSubview:locationButton];
    
    UIButton * reportButton  = [[UIButton alloc]init];
    
    [reportButton setBackgroundImage:[UIImage imageNamed:@"rightBottomImage_60x60_"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:reportButton];
    
    
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(60);
        
        make.centerY.mas_equalTo(userBikeButton.mas_centerY);
        
        make.right.mas_equalTo(userBikeButton.mas_left).offset(-40);
    }];
    
    [reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(60);
        
        make.centerY.mas_equalTo(userBikeButton.mas_centerY);
        
        make.left.mas_equalTo(userBikeButton.mas_right).offset(40);
    }];
    
}

#pragma mark -点击左边按钮 滑出infoList菜单
-(void)homePageLeftButtonClick{
    
    isHiddenStatusBar = YES;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    SYUserInfoListView * infoListView = [[SYUserInfoListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    
    infoListView.delegate = self;
    
    [self.view addSubview:infoListView];
   
    
}




-(void)homePageRightButtonClick{

    
    
}


#pragma mark -MapView代理方法

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{

    
}

#pragma mark -infoListView 代理方法
-(void)infoListViewRemoveFromSuperView:(SYUserInfoListView *)infoListView{

    [infoListView removeFromSuperview];
    
    isHiddenStatusBar = NO;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

-(void)infoListView:(SYUserInfoListView *)infoListView didSelectRowWithIndexPath:(NSIndexPath *)indexPath{


}

#pragma mark -状态栏的显示隐藏

-(BOOL)prefersStatusBarHidden{
    
    return isHiddenStatusBar;
    
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return UIStatusBarAnimationFade;
}
@end
