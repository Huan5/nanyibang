//
//  HYNavigationController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYNavigationController.h"

@interface HYNavigationController ()

@end

@implementation HYNavigationController

+(void)initialize{
    //设置全局的导航条属性
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil ];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    titleAttr[NSForegroundColorAttributeName] = HYRGBColor(51, 51, 51);
    
    
    navBar.titleTextAttributes = titleAttr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {//如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //[button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(100, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //[button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //先修改再push
    [super pushViewController:viewController animated:animated];
    
}
- (void) back{
    [self popViewControllerAnimated:YES];
}
@end
