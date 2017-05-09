//
//  SYActivityCenterViewController.m
//  SmallYellowBike
//
//  Created by 111111 on 2017/4/21.
//  Copyright © 2017年 才文. All rights reserved.
//

#import "SYActivityCenterViewController.h"
#import "SYActivityCenterViewCell.h"
#import "SYActivityCenterModel.h"

@interface SYActivityCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView * tableView;

@end

@implementation SYActivityCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavWithTitle:@"活动中心" withLeftImage:[UIImage imageNamed:@"backIndicator_30x18_"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
}

-(void)setupUI{

    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYActivityCenterModel * model = [SYActivityCenterModel new];
    
    model.imageName = @"http://img3.duitang.com/uploads/item/201311/18/20131118201009_nFLNJ.gif";
    
    SYActivityCenterViewCell * cell = [SYActivityCenterViewCell cellWithTableView:tableView];
    
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}

@end
