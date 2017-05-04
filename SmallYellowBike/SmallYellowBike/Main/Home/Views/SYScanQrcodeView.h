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

/** 添加定时器 */
- (void)addTimer;
/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;

@end
