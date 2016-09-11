//
//  ChangeAgeView.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "ChangeAgeView.h"
@interface ChangeAgeView ()
@end
@implementation ChangeAgeView


/**年龄窗口*/
static UIWindow *ageWin;
static UIButton *currnBtn;
+ (void)setUpWindow{
    
    ageWin = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ageWin.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self setUpView];
    
}
+ (void)show{
    [self setUpWindow];
    ageWin.subviews.lastObject.x = -ageWin.subviews.lastObject.width;
    ageWin.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        ageWin.subviews.lastObject.x = 0;
    }];
    
}
+ (void)hide{
    [UIView animateWithDuration:0.4 animations:^{
        ageWin.subviews.lastObject.x = -ageWin.subviews.lastObject.width;
        
    }completion:^(BOOL finished) {
        ageWin.hidden = YES;
    }];
    
}
//初始化changeAgeView 并添加手势和按钮
+ (void)setUpView{
    if (ageWin != nil) {
        
        
        UIView *ageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, HYScreenH)];
        ageView.backgroundColor = [UIColor whiteColor];
        //设置阴影
        ageView.layer.shadowColor = [UIColor blueColor].CGColor;
        ageView.layer.shadowOffset = CGSizeMake(10, 10);
        ageView.layer.shadowRadius = 20.0;
        ageView.layer.shadowOpacity = 0.6;
        
        //添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGest:)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [ageView addGestureRecognizer:pan];
        [ageWin addGestureRecognizer:pan];
        [ageWin addGestureRecognizer:tap];
        
        
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 220,60)];
        mainLabel.text = @"查看各年龄段服装";
        mainLabel.textAlignment = NSTextAlignmentCenter;
        [ageView addSubview:mainLabel];
        
        NSArray *images = @[@"change_age_15-18_28x29_",@"change_age_19-23_23x24_",@"change_age_24-28_30x21_",@"change_age_29-35_24x22_",@"change_age_36-40_23x26_"];
        NSArray *titels = @[@"15-18岁",@"19-23岁",@"24-28岁",@"29-35岁",@"36-40岁"];
        
        CGFloat startbtnY = CGRectGetMaxY(mainLabel.frame);
        CGFloat btnW = 220;
        CGFloat btnH = 60;
        for (NSInteger i = 0; i<titels.count ; i++) {
            UIButton *ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            ageBtn.tag = i;
            [ageBtn addTarget:self action:@selector(changeAgeClick:) forControlEvents:UIControlEventTouchUpInside];
            ageBtn.frame = CGRectMake(0, startbtnY + (i * btnH), btnW, btnH);
            
            [ageBtn setTitle:titels[i] forState:UIControlStateNormal];
            [ageBtn setTitleColor:HYRGBColor(51, 51, 51) hTitleColor:[UIColor whiteColor] image:images[i] hImage:images[i]];
            
            [ageView addSubview:ageBtn];
            
        }
        
        [ageWin addSubview:ageView];
    }
}
//点击了哪个年龄段
+ (void)changeAgeClick:(UIButton *)button{
    
    HYLog(@"点击了%@",button.titleLabel.text);
    currnBtn.selected = NO;
    currnBtn.backgroundColor = [UIColor whiteColor];
    button.selected = YES;
    button.backgroundColor = HYRGBColor(38, 221, 147);
    currnBtn = button;
}
//手势
+ (void)panGest:(UIPanGestureRecognizer *)pan{
    
    CGPoint currnP = [pan velocityInView:ageWin.subviews.lastObject];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        if (ageWin.subviews.lastObject.x > 0 && currnP.x >0) {
            [UIView animateWithDuration:0.2 animations:^{
                ageWin.subviews.lastObject.x += currnP.x * 0.00001;
            }completion:^(BOOL finished) {
                ageWin.subviews.lastObject.x = 0;
            }];
        }else{
            ageWin.subviews.lastObject.x += currnP.x * 0.01;
        }
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (ageWin.subviews.lastObject.x < -ageWin.subviews.lastObject.width / 2) {
            [self hide];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                ageWin.subviews.lastObject.x = 0;
                
            }];
        }
    }
}
@end