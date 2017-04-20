//
//  SYBaseViewController.h
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <UIKit/UIKit.h>


//基控制器
@interface SYBaseViewController : UIViewController

/**
 设置导航栏标题

 @param title 标题
 */
-(void)setNavTitle:(NSString*)title;

/**
 设置导航栏标题和左边文字

 @param title     标题
 @param leftTitle 左边文字
 */
-(void)setNavTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle;


/**
 设置导航栏标题和左边图片

 @param title     标题
 @param leftImage 左边图片
 */
-(void)setNavWithTitle:(NSString*)title withLeftImage:(UIImage*)leftImage;


/**
 设置导航栏标题 左边文字和图片

 @param title     标题
 @param leftTitle 左边文字
 @param leftImage 左边图片
 */
-(void)setNavWithTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle withLeftImage:(UIImage*)leftImage;

/**
  设置导航栏
 @param title      标题
 @param leftTitle  左边标题
 @param leftImage  左边图片
 @param rightTitle 右边标题
 @param rightImage 右边图片
 */
-(void)setNavWithTitle:(NSString*)title withLeftTitle:(NSString*)leftTitle withLeftImage:(UIImage*)leftImage withRightTitle:(NSString*)rightTitle withRightImage:(UIImage*)rightImage;


/**
 左边按钮点击方法

 @param leftButton 左边按钮
 */
-(void)leftButtonClick:(UIButton*)leftButton;



/**
 右边按钮点击方法

 @param rightButton 右边按钮
 */
-(void)rightButtonClick:(UIButton*)rightButton;

@end
