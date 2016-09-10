//
//  HYTabBarController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//


#import "HYTabBarController.h"
#import "HYNavigationController.h"

#import "CollocationViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "RecommendViewController.h"
#import "SingleProductViewController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

+ (void)initialize{
    
    //设置全局的UITabBarItem
    UITabBarItem *taItem = [UITabBarItem appearance];
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrDict[NSForegroundColorAttributeName] = HYRGBColor(51, 51, 51);
    
    NSMutableDictionary *selectedAttrDict = [NSMutableDictionary dictionary];
    selectedAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectedAttrDict[NSForegroundColorAttributeName] = HYRGBColor(0, 180, 200);
    
    [taItem setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    [taItem setTitleTextAttributes:selectedAttrDict forState:UIControlStateSelected];
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpChildVC:[[RecommendViewController alloc]init] title:@"首页" image:@"recommend_19x22_" selectedImage:@"recommend_19x22_"];
    
    [self setUpChildVC:[[SingleProductViewController alloc]init] title:@"单品" image:@"singleProduct_26x22_" selectedImage:@"singleProduct-highlight_26x22_"];
    
     [self setUpChildVC:[[CollocationViewController alloc]init] title:@"搭配" image:@"collocation_22x22_" selectedImage:@"collocation-highlight_22x22_"];
     
     [self setUpChildVC:[[DiscoverViewController alloc]init] title:@"帅吧" image:@"discover_22x22_" selectedImage:@"discover-highlight_22x22_"];
     
     [self setUpChildVC:[[MeViewController alloc]init] title:@"我的" image:@"me_22x22_" selectedImage:@"me-highlight_22x22_"];
    
    
}
//初始化子控制器
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.navigationItem.title = title;
    
    UINavigationController *nVC = [vc isKindOfClass:[MeViewController class]] ? [[UINavigationController alloc]initWithRootViewController:vc] : [[HYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nVC];
    
}
@end
