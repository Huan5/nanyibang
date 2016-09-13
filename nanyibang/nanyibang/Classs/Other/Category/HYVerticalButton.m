//
//  HYVerticalButton.m
//  趣味信息分享
//
//  Created by Huanying on 16/4/22.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "HYVerticalButton.h"

@implementation HYVerticalButton
-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [self setup];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //调整图片
    
    self.imageView.x = self.width/2 - 20;
    self.imageView.y = HYMargin;
    self.imageView.width = 40;
    self.imageView.height = 40;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + HYMargin;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y - HYMargin;
}

@end
