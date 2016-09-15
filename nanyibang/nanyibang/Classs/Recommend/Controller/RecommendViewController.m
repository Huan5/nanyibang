//
//  RecommendViewController.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "RecommendViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "HYThemeHeaderView.h"
#import "HYThemeHeader.h"

@interface RecommendViewController ()
/**头部*/
@property(nonatomic,strong)HYThemeHeaderView *headerView;
/**上一次请求参数*/
@property(nonatomic,strong)NSDictionary *params;
/**头部模型数组(上下)*/
@property(nonatomic,strong)NSMutableArray *headerArr;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    //[self loadNewTheme];
    [self setUpCv];
    
}
- (void)setUpCv{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, HYScreenW, HYScreenH)];
    
    self.headerView = [HYThemeHeaderView ThemeHeaderView];
    //self.headerView.themeHeaderArray = self.headerArr;
    self.headerView.frame = CGRectMake(0, 0, HYScreenW, 1881);
    [self.headerView setUpData];
    [scroll addSubview:self.headerView];
    scroll.contentSize = CGSizeMake(0, 1881);
    [self.view addSubview:scroll];
//    UICollectionView *collect = [UICollectionView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>];
}
- (void)loadNewTheme{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"age"] = @24;
    params[@"type"] = @"2,3,4,5,6,7";
    self.params = params;
    //发送请求给服务器，加载段子
    [[AFHTTPSessionManager manager] GET:@"http://api.nanyibang.com/theme" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HYLog(@"%@",responseObject);
        if (self.params != params) return ;
        self.headerArr = [HYThemeHeader mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [responseObject writeToFile:@"/Users/huanying/Desktop/list1.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HYLog(@"失败了!!!");
        if (self.params != params) return ;
        
    }];
}
@end
