//
//  SYHomePageLocationModel.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYHomePageLocationModel.h"

@implementation SYHomePageLocationModel

+(NSArray *)locationArr{

    NSString * path = [[NSBundle mainBundle]pathForResource:@"HomePageLocation.plist" ofType:nil];
    
    NSArray * pathArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:pathArr.count];
    
    [pathArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SYHomePageLocationModel * model = [SYHomePageLocationModel yy_modelWithDictionary:obj];
        
        [mArr addObject:model];
    }];
    
    return mArr.copy;

}

@end
