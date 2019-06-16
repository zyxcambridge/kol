//
//  ShowViewController.m
//  KOLDemo
//
//  Created by Kelvin on 2019/6/16.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import "ShowViewController.h"
#import "Constants.h"
#import "AnalyseViewController.h"

@interface ShowViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT + 120);
    scrollView.scrollEnabled = YES;
    _scrollView = scrollView;
    
    UIImageView *imageIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    [scrollView addSubview:imageIv];
    imageIv.image = [UIImage imageNamed:self.userModel.image];
    imageIv.contentMode =  UIViewContentModeScaleAspectFill;
    
    // 姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, imageIv.bottom + MARGIN, 300, 20)];
    [scrollView addSubview:nameLabel];
    //        nameLabel.backgroundColor = [UIColor orangeColor];
    nameLabel.textColor = UIColorFromRGB(0x1b1b1b);
    nameLabel.font = MyFont(16);
    nameLabel.text = self.userModel.username;
    
    // 日期
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, nameLabel.bottom + 3, nameLabel.width, 14)];
    [scrollView addSubview:dateLabel];
    //        dateLabel.backgroundColor = [UIColor blueColor];
    dateLabel.textColor = UIColorFromRGB(0x989898);
    dateLabel.font = MyFont(11);
    dateLabel.text = self.userModel.date;
    
    // 点赞
    UIImageView *favorView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH - 100, imageIv.bottom + 30, 15, 15)];
    //        favorView.backgroundColor = [UIColor magentaColor];
    favorView.image = [UIImage imageNamed:@"favor_inactive_icon"];
    [scrollView addSubview:favorView];
    
    // favor
    UILabel *favorLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 80, imageIv.bottom + 32, 100, 14)];
    [scrollView addSubview:favorLabel];
    //        favorLabel.backgroundColor = [UIColor whiteColor];
    favorLabel.textColor = UIColorFromRGB(0x7A8FA6);
    favorLabel.font = MyFont(12);
    favorLabel.text = @"Favorite";
    
    UIImageView *commentsIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 370, WIDTH, 255)];
    [scrollView addSubview:commentsIv];
    commentsIv.image = [UIImage imageNamed:@"comments_icon"];
    commentsIv.contentMode =  UIViewContentModeScaleAspectFit;
    
    // 分析按钮
    UIButton *analyzeBtn = [[UIButton alloc] initWithFrame:CGRectMake(scrollView.width * 0.5 - 80, commentsIv.bottom + MARGIN, 160, 30)];
    [scrollView addSubview:analyzeBtn];
    [analyzeBtn setBackgroundImage:[UIImage imageNamed:@"analyze_bg"] forState:UIControlStateNormal];
    [analyzeBtn setTitle:@"Analyse Expression" forState:UIControlStateNormal];
    analyzeBtn.titleLabel.font = MyFont(16);
    analyzeBtn.layer.cornerRadius = 4;
    analyzeBtn.layer.masksToBounds = YES;
    [analyzeBtn addTarget:self action:@selector(analyseBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)analyseBtnClick {
    AnalyseViewController *analyseViewController = [[AnalyseViewController alloc] init];
    analyseViewController.userModel = self.userModel;
    [self.navigationController pushViewController:analyseViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
