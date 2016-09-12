//
//  ChangeAgeView.h
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAgeView : NSObject
typedef enum {
    ChangeAgeType15 = 0,
    ChangeAgeType19 = 1,
    ChangeAgeType24 = 2,
    ChangeAgeType29 = 3,
    ChangeAgeType36 = 4,
}ChangeAgeType;
+ (void)show;
+ (void)hide;
+ (void)setCurrnBtn:(ChangeAgeType)currnBtn;
@end
