//
//  HYItemModel.h
//  nanyibang
//
//  Created by huanying on 16/10/13.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <Foundation/Foundation.h>
//"_id": 398040,
//"productType": 1,
//"pic_url": "http:\/\/img01.taobaocdn.com\/bao\/uploaded\/i1\/TB1T1KWNXXXXXawXFXXXXXXXXXX_!!0-item_pic.jpg_450x10000q75.jpg",
//"title": "Lilbetter\u7537\u58eb\u957f\u8896T\u6064 \u65b0\u6b3e\u6e10\u53d8\u8272\u7eb9\u7406\u4f53\u886b\u957f\u8896\u6253\u5e95\u886b\u7537\u5851\u8eabT\u6064\u7537",
//"coupon_price": "92.00",
//"price": "109.00",
//"saveCount": 175,
//"isv_code": "0_ios_jingxuan_19"
@interface HYItemModel : NSObject
/* 图片*/
@property (nonatomic,strong)NSString *pic_url;
/* 标题*/
@property (nonatomic,strong)NSString *title;
/* 价格*/
@property (nonatomic,strong)NSString *price;
/* 喜欢数*/
@property (nonatomic,assign)NSInteger saveCount;
@end
