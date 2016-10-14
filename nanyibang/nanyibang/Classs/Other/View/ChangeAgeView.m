//
//  ChangeAgeView.m
//  nanyibang
//
//  Created by Huanying on 16/9/10.
//  Copyright © 2016年 huanying. All rights reserved.
//

#import "ChangeAgeView.h"
@implementation ChangeAgeView


/**年龄窗口*/
static UIWindow *ageWin;
static UIButton *currnBtn;
static ChangeAgeType currnBtnNumb;
+ (void)setUpWindow{
    if (ageWin == nil) {
        ageWin = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        ageWin.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    [self setUpView];
    
}
+ (void)show{
    [self setUpWindow];
    ageWin.subviews.lastObject.x = -ageWin.subviews.lastObject.width;
    currnBtn.selected = YES;
    currnBtn.backgroundColor = HYRGBColor(38, 221, 147);
    ageWin.hidden = NO;
    
    //HYLog(@"%f",ageWin.layer.position.x);
//    CASpringAnimation *anm = [CASpringAnimation animationWithKeyPath:@"zPosition.x"];
//    ageWin.subviews.lastObject.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    anm.removedOnCompletion = NO;
//    anm.fillMode = kCAFillModeBoth;
//    anm.fromValue = @(-110);
//    anm.toValue = @110;
//    anm.mass = 1;
//    anm.damping = 0.1;
//    anm.stiffness = 10;
//    anm.initialVelocity = 15;
//    [ageWin.subviews.lastObject.layer addAnimation:anm forKey:@"弹簧"];
//    [UIView animateWithDuration:0.5 animations:^{
//        ageWin.subviews.lastObject.x = 0;
//    }];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ageWin.subviews.lastObject.x = 0;
    } completion:^(BOOL finished) {
        
    }];
    
}
+ (void)hide{
    [UIView animateWithDuration:0.4 animations:^{
        ageWin.subviews.lastObject.x = -ageWin.subviews.lastObject.width;
        
    }completion:^(BOOL finished) {
        ageWin.hidden = YES;
    }];
    
}
//设置当前默认的按钮,不设默认为2;
+ (void)setCurrnBtn:(ChangeAgeType)currnBtn{
    currnBtnNumb = currnBtn;
}
//初始化changeAgeView 并添加手势和按钮
+ (void)setUpView{
    if (ageWin.subviews.lastObject == nil ) {
        
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
            if (i == (currnBtnNumb==0 ? 2:currnBtnNumb)) {
                    currnBtn = ageBtn;
                }
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
//手势处理
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
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                ageWin.subviews.lastObject.x = 0;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
@end
