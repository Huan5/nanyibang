//
//  HYThemeHeader.h
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYThemeHeader : NSObject



/**图片名称*/
@property(nonatomic,strong)NSString *theme_name;
/**图片链接*/
@property(nonatomic,strong)NSString *theme_image;
/**点击链接*/
@property(nonatomic,strong)NSString *theme_link;
/**数据类型*/
@property(nonatomic,strong)NSString *type;
/**品牌图片*/
@property(nonatomic,strong)NSString *brandIcon;
/**搭配主题名字*/
@property(nonatomic,strong)NSString *themeDesc;
///**搭配模型数组*/
//@property(nonatomic,strong)NSMutableArray *collocationModelArr;
/**搭配模型数组*/
@property(nonatomic,strong)NSMutableArray *matches;
@end
