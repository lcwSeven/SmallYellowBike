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
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "SYUserInfoListView.h"
#import "SYHomePageLocationModel.h"
#import "SYScanQrcodeViewController.h"

@interface SYHomePageViewController ()<MAMapViewDelegate,SYUserInfoListViewDelegate,AMapSearchDelegate,AMapNaviWalkViewDelegate>
{
    
    BOOL isHiddenStatusBar;
    
    UIButton * _locationButton;
    
    UILabel * _loctionLabel;

}
@property (nonatomic ,strong) AMapLocationManager * locationManger;

@property (nonatomic ,strong) AMapNaviWalkManager * walkManager;

@property (nonatomic ,strong) AMapSearchAPI * search;

@property (nonatomic ,strong) MAMapView *mapView;

@property (nonatomic ,strong) MAUserLocationRepresentation *locationRep;

@property (nonatomic ,strong) NSArray * ofoList;

@end

@implementation SYHomePageViewController


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    for (SYHomePageLocationModel * model in self.ofoList) {
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        
        CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(model.latitude.doubleValue, model.longitude.doubleValue), AMapCoordinateTypeGPS);
        
        
        pointAnnotation.coordinate = amapcoord;
        
        [_mapView addAnnotation:pointAnnotation];
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNav];
    
    [self setMapKit];
    
    [self setUserBike];
    
    [self userPositionToLocation];
    
}


#pragma mark -设置地图
-(void)setMapKit{

    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:mapView];
    
//    mapView.showsUserLocation = YES;
    
    mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    //关闭指南针
    mapView.showsCompass= NO;
    
    //不显示比例尺
    mapView.showsScale= NO;

    //显示楼房
    mapView.showsBuildings = YES;
    
    mapView.delegate = self;
    
    [mapView setZoomLevel:17 animated:YES];

    self.mapView = mapView;

    [self.mapView updateUserLocationRepresentation:self.locationRep];
   
}

//#pragma mark -初始化搜索API


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
    //渐变的layer
    CAGradientLayer *layer = [CAGradientLayer layer];

    layer.colors = [NSArray arrayWithObjects:(id)   [[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor,(id)[UIColor whiteColor].CGColor, nil];

    layer.frame = CGRectMake(0, SCREENH_HEIGHT-250, SCREEN_WIDTH, 250);
    
    [self.view.layer addSublayer:layer];
    
    UIButton * userBikeButton = [[UIButton alloc]init];
    
    [userBikeButton setTitle:@"立即用车" forState:UIControlStateNormal];
    
    [userBikeButton setTitleColor:SYFontYellow forState:UIControlStateNormal];
    
    userBikeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [userBikeButton setBackgroundImage:[UIImage imageNamed:@"HomePage_UseBike_h_100x100_"] forState:UIControlStateNormal];

    [userBikeButton addTarget:self action:@selector(userBike) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [locationButton addTarget:self action:@selector(userPositionToLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:locationButton];
    
    _locationButton = locationButton;
    
    
    UILabel * loctionLabel = [[UILabel alloc]init];
    
    loctionLabel.font = [UIFont systemFontOfSize:14];
    
    loctionLabel.textColor = SYFontColor;
    
    loctionLabel.text = @"定位";
    
    [self.view addSubview:loctionLabel];
    
    _loctionLabel = loctionLabel;
    
    UIButton * reportButton  = [[UIButton alloc]init];
    
    [reportButton setBackgroundImage:[UIImage imageNamed:@"rightBottomImage_60x60_"] forState:UIControlStateNormal];
    
    [self.view addSubview:reportButton];
    
    UILabel * reportLabel = [[UILabel alloc]init];
    
    reportLabel.font = [UIFont systemFontOfSize:14];
    
    reportLabel.textColor = SYFontColor;
    
    reportLabel.text = @"举报";
    
    [self.view addSubview:reportLabel];
    
    
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(60);
        
        make.centerY.mas_equalTo(userBikeButton.mas_centerY);
        
        make.right.mas_equalTo(userBikeButton.mas_left).offset(-40);
    }];
    
    
    [loctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(locationButton.mas_centerX);
        
        make.top.mas_equalTo(locationButton.mas_bottom);
    }];
    
    [reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(60);
        
        make.centerY.mas_equalTo(userBikeButton.mas_centerY);
        
        make.left.mas_equalTo(userBikeButton.mas_right).offset(40);
    }];
    
    [reportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(reportButton.mas_centerX);
        
        make.top.mas_equalTo(reportButton.mas_bottom);
    }];
    
}


-(void)setOfoPicture{
    

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

//使用自行车 跳转扫描二维码界面
-(void)userBike{
    
    SYScanQrcodeViewController * ctl = [[SYScanQrcodeViewController alloc]init];
    
    [self.navigationController pushViewController:ctl animated:YES];

}

#pragma mark -点击按钮用户定位
-(void)userPositionToLocation{
    
    _locationButton.selected = YES;
    
    _loctionLabel.text = @"刷新";
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    
    animation.duration  = 0.8;
    
    animation.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = MAXFLOAT;
    
    [_locationButton.layer addAnimation:animation forKey:@"locationRound"];
    
    [self.locationManger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error){
            
            if (error.code == AMapLocationErrorLocateFailed) return;
        }
        
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        
        //longitude 经度  latitude纬度   ---116.474153 --- 40.012254
        
        [self.mapView setZoomLevel:17 animated:YES];
        
        [_locationButton.layer removeAnimationForKey:@"locationRound"];
        
        _locationButton.selected = YES;
        
        _loctionLabel.text = @"刷新";
        
    }];

}

#pragma mark -MapView代理方法

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{

    _locationButton.selected = NO;
    
    _loctionLabel.text = @"定位";
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"HomePage_nearbyBike_50x50_"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{

    //获取这个view的坐标
    
    CLLocationCoordinate2D clickLocation = view.annotation.coordinate;
    
    AMapNaviPoint * startPoint = [AMapNaviPoint locationWithLatitude:mapView.userLocation.coordinate.latitude longitude:mapView.userLocation.coordinate.longitude];
    
    AMapNaviPoint * endPoint = [AMapNaviPoint locationWithLatitude:clickLocation.latitude longitude:clickLocation.longitude];
    

    [self.walkManager calculateWalkRouteWithStartPoints:@[startPoint] endPoints:@[endPoint]];
    
    
}
- (void)showNaviRoutes{
  
        [self.mapView removeOverlays:self.mapView.overlays];
    
        int count = (int)self.walkManager.naviRoute.routeCoordinates.count;
    
        //添加路径Polyline
        CLLocationCoordinate2D coords[count];
        
        for (int i = 0; i < count; i++){
            
            AMapNaviPoint *coordinate = [self.walkManager.naviRoute.routeCoordinates objectAtIndex:i];
            
            coords[i].latitude = [coordinate latitude];
            
            coords[i].longitude = [coordinate longitude];
        }
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        
        [self.mapView addOverlay:polyline];
    
    
}

- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager{

    //显示路径或开启导航
    
    [self showNaviRoutes];
}



- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 16.f;
        
        [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:@"HomePage_path_16x16_"]];
        
        return polylineRenderer;
    }
    
    return nil;
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

#pragma mark -懒加载

-(AMapLocationManager *)locationManger{

    if (!_locationManger) {
        
        _locationManger = [[AMapLocationManager alloc]init];
        
        _locationManger.distanceFilter = 200;
        
        [_locationManger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        
    }
    
    return _locationManger;
}

-(MAUserLocationRepresentation *)locationRep{
    
    if (!_locationRep) {
        
        _locationRep = [[MAUserLocationRepresentation  alloc]init];
        
        _locationRep.showsHeadingIndicator = YES;
        
        _locationRep.showsAccuracyRing = NO;
    }

    return _locationRep;
}

-(AMapSearchAPI *)search{

    if (!_search) {
        
        _search = [[AMapSearchAPI alloc]init];
        
        _search.delegate = self;
    }
    
    return _search;

}

-(AMapNaviWalkManager *)walkManager{

    if (!_walkManager) {
        
        _walkManager = [[AMapNaviWalkManager alloc]init];
        
        _walkManager.delegate = self;
    }
    
    return _walkManager;
}

-(NSArray *)ofoList{
    
    if (!_ofoList) {
        
        _ofoList = [SYHomePageLocationModel locationArr];
    }
    
    return _ofoList;

}



@end
