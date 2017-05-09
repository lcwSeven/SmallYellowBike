//
//  SYActivityCenterViewCell.h
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYActivityCenterModel.h"

@interface SYActivityCenterViewCell : UITableViewCell

@property (nonatomic ,strong)SYActivityCenterModel * model;


+(SYActivityCenterViewCell*)cellWithTableView:(UITableView*)tableView;

@end
