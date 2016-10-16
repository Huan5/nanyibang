//
//  HYThemeHeader.m
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYThemeHeader.h"
#import "HYCollocationModel.h"
#import "HYDiscoverModel.h"
#import <MJExtension.h>

@implementation HYThemeHeader

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"HYCollocationModelArr": @"HYCollocationModel",
             @"school":[HYDiscoverModel class]
             };
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"HYCollocationModelArr" : @"matches"
             };
}
@end
