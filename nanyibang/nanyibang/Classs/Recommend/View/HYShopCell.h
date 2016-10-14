//
//  HYShopCell.h
//  nanyibang
//
//  Created by huanying on 16/10/13.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYItemModel;

@interface HYShopCell : UICollectionViewCell
/* item模型*/
@property (nonatomic,strong)HYItemModel *shop;
+ (instancetype)cell;
@end
