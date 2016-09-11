//
//  HYViewController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYViewController.h"

@implementation HYViewController
- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"change_age_entry_18x15_" hightImage:@"change_age_entry_18x15_" target:self action:@selector(change_age_Action)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"aitao_search_input_icon_15x15_" hightImage:@"aitao_search_input_icon_15x15_" target:self action:@selector(searchClick)];
    UIBarButtonItem *cartItem =[UIBarButtonItem itemWithImage:@"cart_entry_23x20_" hightImage:@"cart_entry_23x20_" target:self action:@selector(cartClick)];
    self.navigationItem.rightBarButtonItems = @[cartItem,searchItem];
    
    
}
- (void)searchClick{
    HYLog(@"搜索");
}
-(void)cartClick{
    HYLog(@"购物车");
}
- (void)change_age_Action{
    [ChangeAgeView show];
}
@end
