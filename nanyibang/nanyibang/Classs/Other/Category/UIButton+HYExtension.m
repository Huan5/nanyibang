//
//  UIButton+HYExtension.m
//  nanyibang
//
//  Created by Huanying on 16/9/11.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "UIButton+HYExtension.h"

@implementation UIButton (HYExtension)
- (void)setTitleColor:(UIColor *)color hTitleColor:(UIColor *)hColor image:(NSString *)imagestr hImage:(NSString *)hImage{
    [self setImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    [self setTitleColor:hColor forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:hImage] forState:UIControlStateSelected];
    
    
}
@end
