//
//  SYUserInfoListView.h
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYUserInfoListView;

@protocol SYUserInfoListViewDelegate <NSObject>

//点击阴影部分 显示导航栏和状态栏
-(void)infoListViewRemoveFromSuperView:(SYUserInfoListView*)infoListView;

//点击cell跳转到不同的控制器
-(void)infoListView:(SYUserInfoListView*)infoListView didSelectRowWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface SYUserInfoListView : UIView

@property (nonatomic ,weak)id<SYUserInfoListViewDelegate> delegate;

@end
