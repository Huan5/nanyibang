//
//  HYShopCell.m
//  nanyibang
//
//  Created by huanying on 16/10/13.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYShopCell.h"
#import "HYItemModel.h"
#import <UIImageView+WebCache.h>


@interface HYShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveLikeBtn;


@end
@implementation HYShopCell
+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)setShop:(HYItemModel *)shop{
    _shop = shop;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:self.shop.pic_url]];
    self.titleLabel.text = self.shop.title;
    self.priceLabel.text = [[NSString alloc]initWithFormat:@"💰%@",self.shop.price];
    [self.saveLikeBtn setTitle:[[NSString alloc]initWithFormat:@"%ld",self.shop.saveCount] forState:UIControlStateNormal];
}

- (IBAction)saveLikeClick {
    HYLog(@"点击了喜欢");
}
@end
