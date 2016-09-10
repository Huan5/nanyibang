//
//  HYTabBarController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//


#import "HYTabBarController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

+ (void)initialize{
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpChildVC:[[UIViewController alloc]init] title:@"首页" image:@"recommend_19x22_" selectedImage:@"recommend_19x22_"];
    
    [self setUpChildVC:[[UIViewController alloc]init] title:@"单品" image:@"singleProduct_26x22_" selectedImage:@"singleProduct-highlight_26x22_"];
    
     [self setUpChildVC:[[UIViewController alloc]init] title:@"搭配" image:@"collocation_22x22_" selectedImage:@"collocation-highlight_22x22_"];
     
     [self setUpChildVC:[[UIViewController alloc]init] title:@"帅吧" image:@"discover_22x22_" selectedImage:@"discover-highlight_22x22_"];
     
     [self setUpChildVC:[[UIViewController alloc]init] title:@"我的" image:@"me_22x22_" selectedImage:@"me-highlight_22x22_"];
    
    
}
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.navigationItem.title = title;
    UINavigationController *nVC = [[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nVC];
    
}
@end
