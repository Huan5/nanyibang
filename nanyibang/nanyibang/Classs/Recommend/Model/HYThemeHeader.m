//
//  HYThemeHeader.m
//  nanyibang
//
//  Created by Huanying on 16/9/12.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYThemeHeader.h"
#import "collocationModel.h"
#import "discoverModel.h"
#import <MJExtension.h>

@implementation HYThemeHeader

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"matches": @"collocationModel",
             @"school":[discoverModel class]
             };
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             //@"collocationModelArr" : @"matches"
             };
}
@end
