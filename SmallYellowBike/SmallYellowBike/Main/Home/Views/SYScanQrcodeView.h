//
//  SYScanQrcodeView.h
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYScanQrcodeView;

@protocol SYScanQrcodeViewDelegate <NSObject>

-(void)scanQrCodePopToVc:(SYScanQrcodeView*)scanQrCodeView;

@end

//扫描二维码的layer图层
@interface SYScanQrcodeView : UIView

@property (nonatomic ,weak)id<SYScanQrcodeViewDelegate> delegate;

@end
