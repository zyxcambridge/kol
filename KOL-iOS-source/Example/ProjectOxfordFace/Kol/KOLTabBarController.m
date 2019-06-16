//
//  KOLTabBarController.m
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import "KOLTabBarController.h"
#import "MCTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "UploadViewController.h"

@interface KOLTabBarController ()

@end

@implementation KOLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    //选中时的颜色
        self.mcTabbar.tintColor = [UIColor colorWithRed:60.0/255.0 green:189.0/255.0 blue:238/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
//    self.mcTabbar.centerImage = [UIImage imageNamed:@"upload_icon"];
//    self.mcTabbar.centerSelectedImage = [UIImage imageNamed:@"upload_icon"];
//    // 可设置宽高
//    //    self.mcTabbar.centerWidth = 40;
//    //    self.mcTabbar.centerHeight = 40;
//    [self addChildViewControllers];
    
    // home
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"Home" andImageName:@"home_unselect_icon" andSelectImageName:@"home_select_icon"];
    // upload
    self.mcTabbar.centerImage = [UIImage imageNamed:@"upload_icon"];
    self.mcTabbar.centerSelectedImage = [UIImage imageNamed:@"upload_icon"];
    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"" andImageName:@"" andSelectImageName:@""];
    // me
    [self addChildrenViewController:[[UploadViewController alloc] init] andTitle:@"Me" andImageName:@"me_unselect_icon" andSelectImageName:@"me_select_icon"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImageName:(NSString*)selectImageName{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 选中的颜色由tabbar的tintColor决定
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectImageName];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
