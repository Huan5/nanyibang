//
//  HYThemeHeaderView.h
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYThemeHeader;

@interface HYThemeHeaderView : UIView
/**Theme模型数组*/
@property(nonatomic,strong)NSMutableArray *themeHeaderArray;
+(instancetype)ThemeHeaderView;
- (void)setUpData;
@end
