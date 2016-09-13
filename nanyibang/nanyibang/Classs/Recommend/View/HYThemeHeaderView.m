//
//  HYThemeHeaderView.m
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYThemeHeaderView.h"
#import "HYThemeHeader.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>

@interface HYThemeHeaderView ()
/**头部的View*/
@property(nonatomic,strong)UIView *heardView;
@property (weak, nonatomic) IBOutlet UIView *ScrollImageView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *specialView;
@property (weak, nonatomic) IBOutlet UIView *brandView;
/**轮播器模型数组*/
@property(nonatomic,strong)NSMutableArray *scrollImageArr;
/**各标题数组*/
@property(nonatomic,strong)NSMutableArray *selectArr;
/**特色组模型数组*/
@property(nonatomic,strong)NSMutableArray *specialArr;
/**品牌组模型数组*/
@property(nonatomic,strong)NSMutableArray *brandArr;
@end

@implementation HYThemeHeaderView
+(instancetype)ThemeHeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (void)awakeFromNib{
    //[self setUpData];
}
- (void)setUpData{
    self.themeHeaderArray = [self getItemArrayFromDataWithfileName:@"headerView.txt" arrayWithKey:@"data"];
    self.brandArr = [self getItemArrayFromDataWithfileName:@"headerCenterView.txt" arrayWithKey:@"data.brand"];
}
//获取相应的数据
- (NSMutableArray *)getItemArrayFromDataWithfileName:(NSString *)name arrayWithKey:(NSString *)key{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arrString = [key componentsSeparatedByString:@"."];
    NSMutableArray *itemArr = [NSMutableArray array];
    switch (arrString.count) {
        case 1:
            itemArr = [HYThemeHeader mj_objectArrayWithKeyValuesArray:dict[key]];
            break;
        case 2:
            itemArr = [HYThemeHeader mj_objectArrayWithKeyValuesArray:dict[arrString[0]][arrString[1]]];
            break;
            
        default:
            break;
    }
    return itemArr;
}
-(void)setBrandArr:(NSMutableArray *)brandArr{
    _brandArr = brandArr;
    
    for (int i = 0; i<brandArr.count; i++) {
        HYThemeHeader *them = brandArr[i];
        UIButton *btn = self.brandView.subviews[i];
        btn.tag = i;
        [btn.imageView sd_setImageWithURL:[NSURL URLWithString:them.brandIcon] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            HYLog(@"%@",image);
            [btn setImage:image forState:UIControlStateNormal];
        }];
        [btn addTarget:self action:@selector(brandAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
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
-(void)setScrollImageArr:(NSMutableArray *)scrollImageArr{
    
    _scrollImageArr = scrollImageArr;
    
    HYLog(@"---scrollImageArr%@",self.scrollImageArr);
    
    NSMutableArray *images = [NSMutableArray array];
    for (HYThemeHeader *imageItem in scrollImageArr) {
        [images addObject:imageItem.theme_image];
    }
    //创建轮播器
    [self.ScrollImageView addSubview:[[UIView alloc]init]];
}
- (void)setSelectArr:(NSMutableArray *)selectArr{
    _selectArr = selectArr;
    
    
    HYLog(@"---selectArr%@",self.selectArr);
    
    HYLog(@"--%f",HYScreenW);
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
        [btn.imageView sd_setImageWithURL:[NSURL URLWithString:ithem.theme_image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [btn setImage:image forState:UIControlStateNormal];
        }];
        btn.frame = CGRectMake(endx, starty, w, h);
        btn.tag = i;
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectView addSubview:btn];
    }
}
- (void)setSpecialArr:(NSMutableArray *)specialArr{
    _specialArr = specialArr;
    for (int i = 0; i<specialArr.count; i ++) {
        HYThemeHeader *item = specialArr[i];
        UIButton *imgBtnView = self.specialView.subviews[i];
        [imgBtnView addTarget:self action:@selector(specialAction:) forControlEvents:UIControlEventTouchUpInside];
        [imgBtnView.imageView sd_setImageWithURL:[NSURL URLWithString:item.theme_image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [imgBtnView setImage:image forState:UIControlStateNormal];
        }];
    }
    
    HYLog(@"---specialArr%@",self.specialArr);
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
