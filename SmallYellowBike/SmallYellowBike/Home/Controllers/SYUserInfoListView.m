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

@interface SYUserInfoListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)NSArray * infoList;

@property (nonatomic ,strong)UITableView * tableView;

@end

@implementation SYUserInfoListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return  self;
}

-(void)setupUI{
    
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    
    UITableView * tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 3*self.bounds.size.width/4, self.bounds.size.height) style:UITableViewStylePlain];
    
    [self addSubview:tabelView];
    
    self.tableView = tabelView;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark -设置tableView的头部视图
-(void)setTabHeader{
    
    

}

#pragma mark -tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYUserInfoModel * model = self.infoList[indexPath.row];
    
    SYUserInfoCell * cell = [SYUserInfoCell cellWithTableView:tableView];
    
    cell.model = model;
    
    return cell;
}


#pragma mark -显示动画
-(void)showAnimation{
    
    
    
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
