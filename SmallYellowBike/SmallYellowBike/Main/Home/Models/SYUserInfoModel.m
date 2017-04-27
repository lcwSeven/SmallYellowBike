//
//  SYUserInfoModel.m
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYUserInfoModel.h"

@implementation SYUserInfoModel

+(NSArray*)userInfoList{

    NSString * path = [[NSBundle mainBundle]pathForResource:@"SYUserInfoList.plist" ofType:nil];
    
    NSArray * pathArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:pathArr.count];
    
    [pathArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SYUserInfoModel * model = [SYUserInfoModel yy_modelWithDictionary:obj];
        
        [mArr addObject:model];
        
    }];
    
    return mArr.copy;

}

@end
