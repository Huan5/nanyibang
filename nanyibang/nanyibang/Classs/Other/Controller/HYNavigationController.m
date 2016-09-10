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
    
    
    if (viewController.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
