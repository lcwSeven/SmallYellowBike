//
//  SYUserInfoCell.h
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYUserInfoModel.h"

@interface SYUserInfoCell : UITableViewCell

@property (nonatomic ,strong)SYUserInfoModel * model;

+(SYUserInfoCell*)cellWithTableView:(UITableView*)tableView;

@end
