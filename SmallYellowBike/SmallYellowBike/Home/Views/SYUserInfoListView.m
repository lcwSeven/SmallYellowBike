//
//  SYUserInfoListView.m
//  smallYellowBike
//
//  Created by 111111 on 2017/4/19.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYUserInfoListView.h"

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
    
    
    
    UITableView * tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 2*self.bounds.size.width/3, self.bounds.size.height) style:UITableViewStylePlain];
    
    [self addSubview:tabelView];
    
    self.tableView = tabelView;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = nil;
    
    return cell;
}

@end
