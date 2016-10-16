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
#import "HYItemModel.h"
#import "HYShopCell.h"

@interface RecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**头部*/
@property(nonatomic,strong)HYThemeHeaderView *headerView;
/**模型数组(shops)*/
@property(nonatomic,strong)NSMutableArray *shopsArr;
/* 下面的流水view*/
@property (nonatomic,weak)UICollectionView *collectView;
@end

@implementation RecommendViewController
//获取相应的数据
- (NSMutableArray *)getItemArrayFromDataWithfileName:(NSString *)name arrayWithKey:(NSString *)key modelClass:(Class)class{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arrString = [key componentsSeparatedByString:@"."];
    NSMutableArray *itemArr = [NSMutableArray array];
    switch (arrString.count) {
        case 1:
            itemArr = [class mj_objectArrayWithKeyValuesArray:dict[key]];
            break;
        case 2:
            itemArr = [class mj_objectArrayWithKeyValuesArray:dict[arrString[0]][arrString[1]]];
            break;
        case 3:
            itemArr = [class mj_objectArrayWithKeyValuesArray:dict[arrString[0]][arrString[1]][arrString[2]]];
            break;
        default:
            break;
    }
    return itemArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    //[self loadNewTheme];
    [self setUpCv];
    
}
static NSString *cellID = @"shopCell";
- (void)setUpCv{
    
    self.shopsArr  = [self getItemArrayFromDataWithfileName:@"jingxuan.txt" arrayWithKey:@"data.itemDetail" modelClass:[HYItemModel  class]];
    
    self.headerView = [HYThemeHeaderView ThemeHeaderView];
    self.headerView.frame = CGRectMake(0, 0, HYScreenW, HYRecommendHeaderHeight);
    [self.headerView setUpData];
    
    //流水布局设置
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init] ;
    [layout setHeaderReferenceSize:CGSizeMake(HYScreenW, HYRecommendHeaderHeight)];
    layout.itemSize = CGSizeMake((HYScreenW-3 * HYMargin)/2,240);
    layout.minimumInteritemSpacing = HYMargin;
    layout.minimumLineSpacing = HYMargin;
    layout.sectionInset = UIEdgeInsetsMake(HYMargin, HYMargin, HYMargin, HYMargin);
    
    
    //首页的collectView
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor clearColor];
    collect.delegate = self;
    collect.dataSource = self;
    [self.view addSubview:collect];
    self.collectView = collect;
    //注册
    [self.collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HYShopCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    
}
#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.shopsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    HYItemModel *shop = self.shopsArr[indexPath.item];
    cell.shop = shop;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [headerView addSubview:self.headerView];
        reusableview = headerView;
        
    }
    
//    if (kind == UICollectionElementKindSectionFooter){
//        
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        
//        reusableview = footerview;
//        
//    }
    
    return reusableview;
}
@end
