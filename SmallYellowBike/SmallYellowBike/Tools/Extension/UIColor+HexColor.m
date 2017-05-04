//
//  UIColor+HexColor.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (instancetype)sy_colorWithHex:(u_int32_t)hex{

    // 0xFFAA99
    int red = (hex & 0xFF0000) >> 16;
    // 0x00FF00
    // => 0x00AA00 => 0x0000AA
    int green = (hex & 0x00FF00) >> 8;
    // 0x1111 1111 AA 1001 1001
    // 0x0000 0000 00 1111 1111
    int blue = hex & 0x0000FF;
    
    return [self colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];

}
@end
