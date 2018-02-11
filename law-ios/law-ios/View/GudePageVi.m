//
//  GudePageVi.m
//  MallClient
//
//  Created by iOS_Developers_LL on 2017/2/21.
//  Copyright © 2017年 com.zhongche.cn. All rights reserved.
//

#import "GudePageVi.h"

@interface GudePageVi()

@property (nonatomic, strong)UIScrollView * scrollVi;

@property (nonatomic, strong)UIButton * removeBtn;

@end

@implementation GudePageVi
/**
 *  初始化
 *
 */
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self binView];
    }
    return self;
}

-(void)binView
{
    self.scrollVi.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.scrollVi];
}

-(UIScrollView *)scrollVi
{
    if (!_scrollVi) {
        UIScrollView * scr = [UIScrollView new];
        scr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_);
        scr.backgroundColor = [UIColor whiteColor];
        scr.bounces = NO;
        scr.contentSize = CGSizeMake(WIDTH_ * 4,HEIGHT_);
        scr.showsHorizontalScrollIndicator = NO;
        scr.showsVerticalScrollIndicator = NO;
        scr.pagingEnabled = YES;
        CGPoint point = {0,0};
        scr.contentOffset = point;
        
        UIImageView * igv;
        for (int i = 0 ; i < 4; i ++) {
            igv = [[UIImageView alloc]initWithFrame:CGRectMake(i * WIDTH_, 0, WIDTH_, HEIGHT_)];
            igv.image = [UIImage imageNamed:[NSString stringWithFormat:@"GudePageVi_%d",i]];
            [scr addSubview:igv];
        }
        
        self.removeBtn.frame = CGRectMake(WIDTH_ * 4 - 80, 50, 60, 25);
        [scr addSubview:self.removeBtn];
        _scrollVi = scr;
    }
    return _scrollVi;
}

-(UIButton *)removeBtn
{
    if (!_removeBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"首页" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [btn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchDown];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:12];//设置矩形四个圆角半
        _removeBtn = btn;
    }
    return _removeBtn;
}
@end
