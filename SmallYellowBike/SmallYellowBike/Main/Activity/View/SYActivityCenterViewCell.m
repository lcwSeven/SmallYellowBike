//
//  SYActivityCenterViewCell.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYActivityCenterViewCell.h"

static NSString * cellID = @"SYActivityCenterViewCell";

@interface SYActivityCenterViewCell ()

@property (nonatomic,weak)UIImageView * activityImage;

@end

@implementation SYActivityCenterViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.layer.shouldRasterize = YES;
        
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView * activityImage = [[YYAnimatedImageView alloc]init];
    
    [self.contentView addSubview:activityImage];
    
    self.activityImage = activityImage;
    
    activityImage.layer.cornerRadius = 5;
    
    activityImage.layer.masksToBounds = YES;
    
    [activityImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(self.contentView).offset(5);
        
        make.right.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
}

+(SYActivityCenterViewCell *)cellWithTableView:(UITableView *)tableView{
    
    SYActivityCenterViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SYActivityCenterViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}

-(void)setModel:(SYActivityCenterModel *)model{

    
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
    
//    [self.activityImage yy_setImageWithURL:[NSURL URLWithString:model.imageName] options:YYWebImageOptionShowNetworkActivity];
    
}

@end
