//
//  discoverModel.h
//  nanyibang
//
//  Created by Huanying on 16/9/15.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface discoverModel : NSObject
/**名字*/
@property(nonatomic,strong)NSString *title;
/**链接*/
@property(nonatomic,strong)NSString *link;
/**图片*/
@property(nonatomic,strong)NSString *image;
/**查看数*/
@property(nonatomic,assign)NSInteger clickCount;
@end
