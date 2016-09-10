//
//  MeViewController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    
}
- (void)setUpNav{
    
    self.navigationController.navigationBar.backgroundColor = HYRGBColor(67, 191, 204);
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    attrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = attrDict;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"mine_message_25x25_" hightImage:@"mine_message_25x25_" target:self action:@selector(messageClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"mine_setting_25x25_" hightImage:@"mine_setting_25x25_" target:self action:@selector(settingClick)];
}
- (void)messageClick{
    
}
- (void)settingClick{
    
}
@end
