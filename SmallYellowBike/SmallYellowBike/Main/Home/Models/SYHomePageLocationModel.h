//
//  SYHomePageLocationModel.h
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYHomePageLocationModel : NSObject

//经度
@property (nonatomic ,copy) NSNumber * longitude;

//纬度
@property (nonatomic ,copy) NSNumber * latitude;





+(NSArray*)locationArr;


@end
