//
//  DiscoverViewController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpvC];
}
- (void)setUpNav{
    UIButton *contributeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contributeBtn setTitle:@"投稿" forState:UIControlStateNormal];
    [contributeBtn setTitleColor:HYRGBColor(0, 180, 200) forState:UIControlStateNormal];
    [contributeBtn setTitleColor:HYRGBColor(180, 180, 180) forState:UIControlStateHighlighted];
    contributeBtn.size = CGSizeMake(40, 30);
    [contributeBtn addTarget:self action:@selector(contributeClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:contributeBtn];
}
- (void)contributeClick{
    
    HYLog(@"投稿");
    
}
- (void)setUpvC{
    self.view.backgroundColor = HYRGBColor(240, 240, 240);
}
@end
