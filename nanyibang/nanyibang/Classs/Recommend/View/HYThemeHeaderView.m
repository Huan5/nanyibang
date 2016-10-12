//
//  HYThemeHeaderView.m
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYThemeHeaderView.h"

#import "HYThemeHeader.h"
#import "collocationModel.h"
#import "discoverModel.h"

#import <UIImageView+WebCache.h>
#import <MJExtension.h>

#import "SZKRoundScrollView.h"
#import "HYThemeHeaderView.h"

@interface HYThemeHeaderView ()
/**头部的View*/
@property(nonatomic,strong)UIView *heardView;
@property (weak, nonatomic) IBOutlet UIView *ScrollImageView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *specialView;
@property (weak, nonatomic) IBOutlet UIView *brandView;
@property (weak, nonatomic) IBOutlet UIView *collocation1View;
@property (weak, nonatomic) IBOutlet UIView *collocation2View;
@property (weak, nonatomic) IBOutlet UIView *dicoverView;
/**轮播器模型数组*/
@property(nonatomic,strong)NSMutableArray *scrollImageArr;
/**各标题数组*/
@property(nonatomic,strong)NSMutableArray *selectArr;
/**特色组模型数组*/
@property(nonatomic,strong)NSMutableArray *specialArr;
/**品牌组模型数组*/
@property(nonatomic,strong)NSMutableArray *brandArr;
/**搭配组的模型数组*/
@property(nonatomic,strong)NSMutableArray *collocationArr;
/**帅吧组的模型数组*/
@property(nonatomic,strong)NSMutableArray *discoverArr;

@end

@implementation HYThemeHeaderView
+(instancetype)ThemeHeaderView{
    HYThemeHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
    header.width = 1881;
    return header;
}
- (void)awakeFromNib{
    //[self setUpData];
}
- (void)setUpData{
    self.themeHeaderArray = [self getItemArrayFromDataWithfileName:@"headerView.txt" arrayWithKey:@"data" modelClass:[HYThemeHeader class]];
    self.brandArr = [self getItemArrayFromDataWithfileName:@"headerCenterView.txt" arrayWithKey:@"data.brand" modelClass:[HYThemeHeader class]];
    self.collocationArr = [self getItemArrayFromDataWithfileName:@"headerCenterView.txt" arrayWithKey:@"data.matchThemes" modelClass:[HYThemeHeader class]];
    self.discoverArr = [self getItemArrayFromDataWithfileName:@"headerCenterView.txt" arrayWithKey:@"data.school" modelClass:[discoverModel class]];
}



#pragma mark - 工具
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
//设置按钮的网络图片
- (void)setImagewithBtn:(UIButton *)btn URLString:(NSString *)urlString action:(SEL)action{
    [btn.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [btn setImage:image forState:UIControlStateNormal];
        btn.showsTouchWhenHighlighted = YES;
        //HYLog(@"%@",image);
    }];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 初始化不同的View
//设置帅吧View
- (void)setDiscoverArr:(NSMutableArray *)discoverArr{
    _discoverArr = discoverArr;
    for (int i = 0 ; i<discoverArr.count; i ++) {
        discoverModel *disModel = discoverArr[i];
        UIView *disView = self.dicoverView.subviews[i];
        for (int j = 0; j<4; j++) {
            if (j == 1) {
                UILabel *name = disView.subviews[j];
                name.text = disModel.title;
                continue;
            }
            UIButton *btn = disView.subviews[j];;
            if (j==0) {
                btn.tag = i;
                [self setImagewithBtn:btn URLString:disModel.image action:@selector(dicoverAction:)];
            }
            if (j==2) {
                NSInteger count = disModel.clickCount;
                [btn setTitle:[NSString stringWithFormat:@"%ld人查看",count] forState:UIControlStateNormal];
            }
            if (j==3) {
                btn.tag = i;
                [btn addTarget:self action:@selector(dicoverAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
        }
        
    }
}
//设置搭配View
- (void)setCollocationArr:(NSMutableArray *)collocationArr{
    _collocationArr = collocationArr;
    HYThemeHeader *them1 = collocationArr[0];
    HYThemeHeader *them2 = collocationArr[1];
    
    UILabel *lab1 = self.collocation1View.subviews.lastObject;
    lab1.text = them1.themeDesc;
    UILabel *lab2 = self.collocation2View.subviews.lastObject;
    lab2.text = them2.themeDesc;
    
    for (int i = 0; i<them1.matches.count; i ++) {
        collocationModel *model = them1.matches[i];
        UIButton *btn = self.collocation1View.subviews[i];
        btn.tag = i;
        [self setImagewithBtn:btn URLString:model.big_image action:@selector(collocationAction:)];
    }
    
    for (int i = 0; i<them2.matches.count; i ++) {
        collocationModel *model = them2.matches[i];
        UIButton *btn = self.collocation2View.subviews[i];
        btn.tag = i+them2.matches.count;
        [self setImagewithBtn:btn URLString:model.big_image action:@selector(collocationAction:)];
    }
    
    
}

//设置品牌View
-(void)setBrandArr:(NSMutableArray *)brandArr{
    _brandArr = brandArr;
    
    for (int i = 0; i<brandArr.count; i++) {
        HYThemeHeader *them = brandArr[i];
        UIButton *btn = self.brandView.subviews[i];
        btn.tag = i;
        [self setImagewithBtn:btn URLString:them.brandIcon action:@selector(brandAction:)];
    }
    
}
//分配数据
- (void)setThemeHeaderArray:(NSMutableArray *)themeHeaderArray{
    _themeHeaderArray = themeHeaderArray;
    
    NSMutableArray *scrollIthems = [NSMutableArray array];
    NSMutableArray *selectIthems = [NSMutableArray array];
    NSMutableArray *specialIthems = [NSMutableArray array];
    for (int i = 0; i<themeHeaderArray.count; i++) {
        HYThemeHeader *themeItem = themeHeaderArray[i];
        switch ([themeItem.type intValue]) {
            case 2:
                [scrollIthems addObject:themeHeaderArray[i]];
                break;
            case 3:
                [selectIthems addObject:themeHeaderArray[i]];
                break;
            case 6:
                [specialIthems addObject:themeHeaderArray[i]];
                break;
                
            default:
                break;
        }
    }
    self.scrollImageArr = scrollIthems;
    self.selectArr = selectIthems;
    self.specialArr = specialIthems;
}
//设置轮播器
-(void)setScrollImageArr:(NSMutableArray *)scrollImageArr{
    
    _scrollImageArr = scrollImageArr;
    
    NSMutableArray *images = [NSMutableArray array];
    for (HYThemeHeader *imageItem in scrollImageArr) {
        [images addObject:imageItem.theme_image];
    }
    UIView *scrollView = [SZKRoundScrollView roundScrollViewWithFrame:CGRectMake(0, 0, self.ScrollImageView.width, self.ScrollImageView.height) imageArr:images timerWithTimeInterval:3.0 imageClick:^(NSInteger imageIndex) {
        HYThemeHeader *image = scrollImageArr[imageIndex];
        HYLog(@"%@",image.theme_link);
    }];
    //创建轮播器
    [self.ScrollImageView addSubview:scrollView];
}
//设置头
- (void)setSelectArr:(NSMutableArray *)selectArr{
    _selectArr = selectArr;
    CGFloat w = HYScreenW/selectArr.count;
    CGFloat h = 75;
    CGFloat starty = 0;
    
    for (int i = 0; i<selectArr.count; i++) {
        
        HYThemeHeader *ithem = selectArr[i];
        
        CGFloat endx = w * i;
        HYVerticalButton *btn = [HYVerticalButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSDictionary *attrDic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
        [btn setAttributedTitle:[[NSAttributedString alloc]initWithString:ithem.theme_name attributes:attrDic] forState:UIControlStateNormal];
        [self setImagewithBtn:btn URLString:ithem.theme_image action:@selector(action:)];
        btn.frame = CGRectMake(endx, starty, w, h);
        btn.tag = i;
        
        [self.selectView addSubview:btn];
    }
}
//特色View
- (void)setSpecialArr:(NSMutableArray *)specialArr{
    _specialArr = specialArr;
    for (int i = 0; i<specialArr.count; i ++) {
        HYThemeHeader *item = specialArr[i];
        UIButton *imgBtnView = self.specialView.subviews[i];
        [self setImagewithBtn:imgBtnView URLString:item.theme_image action:@selector(specialAction:)];
    }
    
}


#pragma mark - 各View的点击事件
- (void)dicoverAction:(UIButton *)btn{
    discoverModel *model = self.discoverArr[btn.tag];
    NSString *str = model.link;
    HYLog(@"真帅%@",str);
}
//搭配点击事件
- (void)collocationAction:(UIButton *)btn{
    
    HYLog(@"搭配中");
}
//点击品牌事件
- (void)brandAction:(UIButton *)btn{

}
//点击特色区的图片处理事件
- (void)specialAction:(UIButton *)btn{
    HYThemeHeader *item = self.specialArr[btn.tag];
    HYLog(@"%@",item.theme_link);
}
//点击选择按钮处理事件
- (void)action:(UIButton *)btn{
    HYThemeHeader *item = self.selectArr[btn.tag];
    HYLog(@"%@",item.theme_link);
}
@end
