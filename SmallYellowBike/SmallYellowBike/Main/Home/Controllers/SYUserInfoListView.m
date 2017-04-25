//
//  SYUserInfoListView.m
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYUserInfoListView.h"
#import "SYUserInfoCell.h"
#import "SYUserInfoModel.h"

@interface SYUserInfoListView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic ,strong)NSArray * infoList;

@property (nonatomic ,strong)UITableView * tableView;

@end

@implementation SYUserInfoListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
        [self showAnimation];
    }
    return  self;
}

-(void)setupUI{
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    
    //添加一个轻点手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    tap.delegate = self;
    
    [self addGestureRecognizer:tap];
    
    
    //添加一个轻扫手势
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    swipe.delegate = self;
    
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self addGestureRecognizer:swipe];
    
    
    UITableView * tabelView = [[UITableView alloc]initWithFrame:CGRectMake(-3*self.bounds.size.width/4, 0, 3*self.bounds.size.width/4, self.bounds.size.height) style:UITableViewStylePlain];
    
    [self addSubview:tabelView];
    
    self.tableView = tabelView;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark -设置tableView的头部视图
-(UIView*)setTabHeader{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3*self.bounds.size.width/4, 108)];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * headImageView = [UIImageView new];
    
    headImageView.layer.cornerRadius = 30;
    
    headImageView.layer.masksToBounds = YES;
    
    headImageView.image = [UIImage imageNamed:@"icon_60x60_"];
    
    [headerView addSubview:headImageView];
    
    UILabel * userNameLabel = [UILabel new];
    
    userNameLabel.textColor = SYFontColor;
    
    userNameLabel.font = [UIFont systemFontOfSize:14];
    
    userNameLabel.text = @"Seven";
    
    [headerView addSubview:userNameLabel];
    
    //KeyTification_homePage_13x9_
    UIImageView * keyTificaImageView = [[UIImageView alloc]init];
    
    keyTificaImageView.image = [UIImage imageNamed:@"KeyTification_homePage_13x9_"];
    
    [headerView addSubview:keyTificaImageView];
    
    
    UILabel * keyTificaLabel = [[UILabel alloc]init];
    
    keyTificaLabel.font = [UIFont systemFontOfSize:12];
    
    keyTificaLabel.textColor = SYFontColor;
    
    keyTificaLabel.text = @"已认证";
    
    [headerView addSubview:keyTificaLabel];
    
    
    UIView * lineView = [[UIView alloc]init];
    
    lineView.backgroundColor = SYLineColor;
    
    [headerView addSubview:lineView];
    
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(60);
        
        make.centerY.mas_equalTo(headerView.mas_centerY);
        
        make.left.mas_equalTo(headerView.mas_left).offset(25);
    }];
    
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(headImageView.mas_centerY);
        
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
    }];
    
    
    [keyTificaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(userNameLabel.mas_left);
        
        make.top.mas_equalTo(userNameLabel.mas_bottom).offset(5);
        
        make.width.mas_equalTo(13);
        
        make.height.mas_equalTo(9);
    }];
    
    
    [keyTificaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(keyTificaImageView.mas_centerY);
        
        make.left.mas_equalTo(keyTificaImageView.mas_right).offset(5);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(headerView);
        
        make.bottom.mas_equalTo(headerView.mas_bottom);
        
        make.height.mas_equalTo(1);
    }];

    
    return headerView;
}

#pragma mark -设置Tab底部视图

-(void)setInfoListFooterView{

    

}

#pragma mark -tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYUserInfoModel * model = self.infoList[indexPath.row];
    
    SYUserInfoCell * cell = [SYUserInfoCell cellWithTableView:tableView];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(infoListView:didSelectRowWithIndexPath:)]) {
        
        [self.delegate infoListView:self didSelectRowWithIndexPath:indexPath];
    }

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return  [self setTabHeader];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 108;
}
#pragma mark -显示动画
-(void)showAnimation{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.tableView.frame = CGRectMake(0, 0, 3*self.bounds.size.width/4, self.bounds.size.height);
        
    } completion:nil];
    
}

#pragma mark -取消动画

-(void)tapGesture:(UITapGestureRecognizer*)tap{

    [UIView animateWithDuration:0.25 animations:^{
        
        self.tableView.frame = CGRectMake(- 3*self.bounds.size.width/4, 0, 3*self.bounds.size.width/4, self.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(infoListViewRemoveFromSuperView:)]) {
            
            [self.delegate infoListViewRemoveFromSuperView:self];
        }
        
    }];
    
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if (![self.tableView isDescendantOfView:[touch view]]) {
        
        return NO;
    }
    
    return YES;
}

-(NSArray *)infoList{

    if (!_infoList) {
        
        _infoList = [NSArray array];
        
        NSString * path = [[NSBundle mainBundle]pathForResource:@"SYUserInfoList.plist" ofType:nil];
        
        NSArray * pathArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:pathArr.count];
        
        [pathArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SYUserInfoModel * model = [SYUserInfoModel yy_modelWithDictionary:obj];
            
            [mArr addObject:model];
            
        }];
        
        _infoList = mArr.copy;
    }

    
    return _infoList;
}

@end
