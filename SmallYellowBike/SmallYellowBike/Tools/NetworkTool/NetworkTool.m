//
//  NetworkTool.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/27.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

+(NetworkTool *)shareTool{

    static NetworkTool * instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[NetworkTool alloc]init];
    });
    return instance;
}

@end
