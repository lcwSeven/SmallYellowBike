//
//  SYScanQrcodeView.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYScanQrcodeView.h"
#import <AVFoundation/AVFoundation.h>


/** 扫描动画线(冲击波) 的高度 */
//static CGFloat const scanninglineHeight = 12;
/** 扫描内容外部View的alpha值 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;

/** 扫描内容的Y值 */
#define scanContent_Y self.frame.size.height * 0.30
/** 扫描内容的X值 */
#define scanContent_X self.frame.size.width * 0.15



@interface SYScanQrcodeView ()

@property (nonatomic ,strong) AVCaptureDevice * device;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *scanningline;

@end

@implementation SYScanQrcodeView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
        [self setScanQrCodeView];
    }
    return self;
}

#pragma mark -设置界面
-(void)setupUI{
  
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    
    [self addSubview:navView];
    
    //设置标题 左右按钮
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 20, 44)];
    
    [backButton setImage:[UIImage imageNamed:@"whiteBack_10x18_"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:backButton];
    
    UIButton * helpButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 20, 50, 44)];
    
    [helpButton setTitle:@"帮助" forState:UIControlStateNormal];
    
    [helpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    helpButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [navView addSubview:helpButton];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, SCREEN_WIDTH-200, 44)];
    
    titleLabel.text = @"扫码用车";
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    [navView addSubview:titleLabel];

}

#pragma mark -设置扫码界面
-(void)setScanQrCodeView{

    //设置扫码区域
    
    CALayer * scanQrCodeLayer = [[CALayer alloc]init];
    
    CGFloat scanX = scanContent_X;
    
    CGFloat scanY = scanContent_Y;
    
    CGFloat scanW = self.frame.size.width - 2*scanX;
    
    CGFloat scanH = scanW;
    
    scanQrCodeLayer.frame = CGRectMake(scanX, scanY, scanW, scanH);
    
    scanQrCodeLayer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    
    scanQrCodeLayer.borderWidth = 0.7;
    
    scanQrCodeLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:scanQrCodeLayer];
    
    
    UIImage * scanImage = [UIImage imageNamed:@"bg_QRCodeStorke_570x570_"];
    
    UIImageView * scanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scanW, scanW)];
    
    scanImageView.image = scanImage;
    
    [scanQrCodeLayer addSublayer:scanImageView.layer];
    
    // 顶部layer的创建
    CALayer *top_layer = [[CALayer alloc] init];
    
    CGFloat top_layerX = 0;
    
    CGFloat top_layerY = 64;
    
    CGFloat top_layerW = self.frame.size.width;
    
    CGFloat top_layerH = scanContent_Y-64;
    
    top_layer.frame = CGRectMake(top_layerX,top_layerY, top_layerW,top_layerH);
    
    top_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    
    [self.layer addSublayer:top_layer];
    
    // 左侧layer的创建
    CALayer *left_layer = [[CALayer alloc] init];
    
    CGFloat left_layerX = 0;
    
    CGFloat left_layerY = scanContent_Y;
    
    CGFloat left_layerW = scanContent_X;
    
    CGFloat left_layerH = scanH;
    
    left_layer.frame = CGRectMake(left_layerX, left_layerY, left_layerW, left_layerH);
    
    left_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    
    [self.layer addSublayer:left_layer];
    
    // 右侧layer的创建
    CALayer *right_layer = [[CALayer alloc] init];
    
    CGFloat right_layerX = scanContent_X+scanW;
    
    CGFloat right_layerY = scanContent_Y;
    
    CGFloat right_layerW = scanContent_X;
    
    CGFloat right_layerH = scanH;
    
    right_layer.frame = CGRectMake(right_layerX,right_layerY,right_layerW, right_layerH);
    
    right_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    
    [self.layer addSublayer:right_layer];
    
    // 下面layer的创建
    CALayer *bottom_layer = [[CALayer alloc] init];
    
    CGFloat bottom_layerX = 0;
    
    CGFloat bottom_layerY = CGRectGetMaxY(scanQrCodeLayer.frame);
    
    CGFloat bottom_layerW = self.frame.size.width;
    
    CGFloat bottom_layerH = self.frame.size.height - bottom_layerY;
    
    bottom_layer.frame = CGRectMake(bottom_layerX,bottom_layerY,bottom_layerW, bottom_layerH);
    
    bottom_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    
    [self.layer addSublayer:bottom_layer];
    
    
    // 提示Label
    UILabel *promptLabel = [[UILabel alloc] init];
    
    promptLabel.backgroundColor = [UIColor clearColor];
    
    CGFloat promptLabelX = 0;
    
    CGFloat promptLabelY = CGRectGetMaxY(scanQrCodeLayer.frame) + 15;
    
    CGFloat promptLabelW = self.frame.size.width;
    
    CGFloat promptLabelH = 25;
    
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    promptLabel.textAlignment = NSTextAlignmentCenter;
    
    promptLabel.font = [UIFont boldSystemFontOfSize:12.0];
    
    promptLabel.textColor = SYFontYellow;
    
    promptLabel.text = @"对准车牌上的二维码";
    
    [self addSubview:promptLabel];
    
    
    [self setHandleButton];
    

}

//设置按钮
-(void)setHandleButton{
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-100, SCREEN_WIDTH, 100)];
    
    bottomView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    
    [self addSubview:bottomView];
    
    UIButton * handleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-22.5, 15, 45, 45)];
    
    handleButton.layer.cornerRadius = 22.5;
    
    handleButton.layer.masksToBounds = YES;
    
    [handleButton setImage:[UIImage imageNamed:@"inputBlikeNo_90x91_"] forState:UIControlStateNormal];
    
    [bottomView addSubview:handleButton];
    
    UILabel * handleLabel = [[UILabel alloc]init];
    
    handleLabel.text = @"手动输入车牌";
    
    handleLabel.font = [UIFont systemFontOfSize:12];
    
    handleLabel.textColor = [UIColor whiteColor];
    
    handleLabel.textAlignment = NSTextAlignmentCenter;
    
    [bottomView addSubview:handleLabel];
    
    
    UIButton * lightButton = [[UIButton alloc]initWithFrame:CGRectMake(3*SCREEN_WIDTH/4-22.5, 15, 45, 45)];
    
    [lightButton addTarget:self action:@selector(lightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    lightButton.layer.cornerRadius = 22.5;
    
    lightButton.layer.masksToBounds = YES;
    
    [lightButton setImage:[UIImage imageNamed:@"btn_unenableTorch_w_45x45_"] forState:UIControlStateNormal];
    
    [lightButton setImage:[UIImage imageNamed:@"btn_enableTorch_w_45x45_"] forState:UIControlStateSelected];
    
    [bottomView addSubview:lightButton];
    
    UILabel * lightLabel = [[UILabel alloc]init];
    
    lightLabel.text = @"手电筒";
    
    lightLabel.textColor = [UIColor whiteColor];
    
    lightLabel.font = [UIFont systemFontOfSize:12];
    
    lightLabel.textAlignment = NSTextAlignmentCenter;
    
    [bottomView addSubview:lightLabel];
    
    [handleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(handleButton.mas_centerX);
        
        make.top.mas_equalTo(handleButton.mas_bottom).offset(15);
    }];
    
    
    [lightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(lightButton.mas_centerX);
        
        make.top.mas_equalTo(lightButton.mas_bottom).offset(15);
    }];
    
   
}

//返回上一个页面
-(void)backButtonClick{

    if ([self.delegate respondsToSelector:@selector(scanQrCodePopToVc:)]) {
        
        [self.delegate scanQrCodePopToVc:self];
    }

}

//关闭或打开手电筒
-(void)lightButton:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    
    [self turnOnLight:btn.selected];
    
}


- (void)turnOnLight:(BOOL)on {
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        
        [_device lockForConfiguration:nil];
        
        if (on) {
            
            [_device setTorchMode:AVCaptureTorchModeOn];
            
        } else {
            
            [_device setTorchMode: AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }
}

- (UIImageView *)scanningline {
    
    if (!_scanningline) {
        
        _scanningline = [[UIImageView alloc] init];
        
        _scanningline.image = [UIImage imageNamed:@"bg_QRCodeLine_571x569_"];
        
        _scanningline.frame = CGRectMake(scanContent_X , scanContent_Y, self.frame.size.width - 2*scanContent_X ,1);
    }
    return _scanningline;
}

#pragma mark - - - 添加定时器
- (void)addTimer {
    
    [self.layer addSublayer:self.scanningline.layer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark - - - 移除定时器
- (void)removeTimer {
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    [self.scanningline removeFromSuperview];
    
    self.scanningline = nil;
}

#pragma mark - - - 执行定时器方法
- (void)timeAction {
    
    __block CGRect frame = _scanningline.frame;
    
        if (_scanningline.frame.size.height >= self.frame.size.width-2*scanContent_X){
    
        frame.size.height = 1;
        
        _scanningline.frame = frame;
    }else{
        
        [UIView animateWithDuration:0.1 animations:^{
            
            frame.size.height += 5;
            
            _scanningline.frame = frame;
            
        } completion:nil];
    
    }
    
    
    
   
}

@end
