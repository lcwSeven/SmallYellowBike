//
//  Gloab.h
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/20.
//  Copyright © 2017年 才文. All rights reserved.
//

#ifndef Gloab_h
#define Gloab_h

#import "UIColor+HexColor.h"
#import <Toast/UIView+Toast.h>
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YYWebImage/YYWebImage.h>


//获取屏幕的宽 高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

//4.设置RGB颜色/设置RGBA颜色
#define SYRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//黄色小字体颜色
#define SYFontColor SYRGBColor(102, 89, 51)
//黄色大字体颜色
#define SYFontYellow SYRGBColor(226, 201, 0)
// 线颜色
#define SYLineColor SYRGBColor(0xcd,0xcd,0xcd)

// 设置打印Log
#ifdef DEBUG
#define SYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define SYLog(...)
#endif


#define kWindow [UIApplication sharedApplication].keyWindow

//设置加载提示框（第三方框架：Toast）
#define SYToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});\


// 判断是否为 iPhone 5S/5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f


#endif /* Gloab_h */
