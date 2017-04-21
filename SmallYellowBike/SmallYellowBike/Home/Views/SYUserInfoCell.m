//
//  SYUserInfoCell.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYUserInfoCell.h"

@interface SYUserInfoCell ()

@property (nonatomic ,weak) UIImageView * iconImage;

@property (nonatomic ,weak) UILabel * infoNameLabel;

@end

static NSString * cellID = @"SYUserInfoCellID";

@implementation SYUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView * iconImage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:iconImage];
    
    self.iconImage = iconImage;
    
    UILabel * infoNameLabel = [[UILabel alloc]init];
    
    infoNameLabel.font = [UIFont systemFontOfSize:14];
    
    infoNameLabel.textColor = SYFontColor;
    
    [self.contentView addSubview:infoNameLabel];
    
    self.infoNameLabel = infoNameLabel;
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(20);
        
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
        make.left.mas_equalTo(self.contentView.mas_left).offset(25);
    }];
    
    
    [infoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(iconImage.mas_centerY);
        
        make.left.mas_equalTo(iconImage.mas_right).offset(15);
    }];
    
}

-(void)setModel:(SYUserInfoModel *)model{

    _model = model;
    
    self.iconImage.image = [UIImage imageNamed:model.iconImageName];
    
    self.infoNameLabel.text = model.infoName;
    
}

+(SYUserInfoCell *)cellWithTableView:(UITableView *)tableView{
    
    SYUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SYUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;

}

@end
