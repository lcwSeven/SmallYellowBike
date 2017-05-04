//
//  SYScanQrcodeViewController.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYScanQrcodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SYScanQrcodeView.h"

@interface SYScanQrcodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,SYScanQrcodeViewDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;


@property (nonatomic ,strong)SYScanQrcodeView * scanQrCodeView;

@end

@implementation SYScanQrcodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.scanQrCodeView];
    
    [self setScanQrCode];
}

-(void)setScanQrCode{

    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
//     7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];

}


#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 0、扫描成功之后的提示音
    
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2、删除预览图层
//    [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];

        SYToast(obj.stringValue);
  
    }
}

-(void)scanQrCodePopToVc:(SYScanQrcodeView *)scanQrCodeView{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.scanQrCodeView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.scanQrCodeView removeTimer];
}

- (void)dealloc {
    
    [self removeScanningView];
}
- (void)removeScanningView {
    
    [self.scanQrCodeView removeTimer];
    
    [self.scanQrCodeView removeFromSuperview];
    
    self.scanQrCodeView = nil;
}


-(SYScanQrcodeView *)scanQrCodeView{

    if (!_scanQrCodeView) {
        
        _scanQrCodeView = [[SYScanQrcodeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        
        _scanQrCodeView.delegate = self;
    }
    
    return _scanQrCodeView;

}
@end
