//
//  HomeViewController.m
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import "HomeViewController.h"
#import "KOLTableViewCell.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "ShowViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 初始化模型数据
    [self setupDataSource];
}

# pragma mark - datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KOLTableViewCell *cell = [[KOLTableViewCell alloc] init];
    cell.userModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShowViewController *showViewController = [[ShowViewController alloc] init];
    showViewController.userModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:showViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

#pragma mark - 数据源
- (void)setupDataSource {
    NSArray *modelDataArray = @[
                                @{
                                    @"headerIcon":@"header_icon",
                                    @"username":@"Oxford Interview Attempt #12",
                                    @"date":@"11 January 2019,0:03 am",
                                    @"image":@"image1",
                                    @"favorCount":@"100"
                                    },
                                @{
                                    @"headerIcon":@"header_icon",
                                    @"username":@"JP Morgan Attempt #3",
                                    @"date":@"02 January 2019,4:03 am",
                                    @"image":@"image2",
                                    @"favorCount":@"206"
                                    }];
    _dataArray = [UserModel mj_objectArrayWithKeyValuesArray:modelDataArray];
}




@end
