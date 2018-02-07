//
//  FireSeachListVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "FireSeachListVC.h"

@interface FireModel ()

@property (nonatomic, strong)NSDictionary * dict;
@property (nonatomic, strong)FireModel * model;
@end

@interface FireSeachListVC ()

@property (nonatomic, strong)UIScrollView * bgScr;

@property (nonatomic, strong)NSMutableArray * dataArr;
@end
@implementation FireModel
@end

@implementation FireSeachListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray new];
    
    
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.bgScr];
}

-(void)getData {
    WS(ws);
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.title forKey:@"name"];
    [mdict setValue:self.standard forKey:@"standard"];

    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [self POSTurl:GET_ARCHITECTURE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        [ws.dataArr removeAllObjects];
        NSString *st = responseObject[@"data"][@"architecture"];
        NSArray *arr = [self arrayWithJsonString:st];
        FireModel * model;
        for (id obj in arr) {
            model = [FireModel new];
            model.dict = obj;
            [ws.dataArr addObject:model];
        }
        [ws reloadVi];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

-(void)reloadVi {
    for (UIView * vi in self.bgScr.subviews) {
        if (vi.tag == 111)
            [vi removeFromSuperview];
    }
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, -20, WIDTH_, 0)];
    UIImageView * igv;
    UIView * line;
    UILabel * lab;
    for (FireModel * model in self.dataArr) {
        btn = [[UIButton alloc]initWithFrame:CGRectMake(0,btn.bottom + 20, WIDTH_, 54)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:RGBColor(71, 71, 71) forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@" %@",model.dict[@"name"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [btn setImage:[UIImage getImageWithColor:RGBColor(114, 170, 245) andSize:CGSizeMake(4, 18)] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.bgScr addSubview:btn];
        
        igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 30, 20, 7, 13)];
        igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
        [btn addSubview:igv];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(0, 53, WIDTH_, 0.5)];
        line.backgroundColor = LINE;
        [btn addSubview:line];
        
        WS(ws);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        
        }];
        [self.bgScr addSubview:btn];
        [self makeButton:btn];

        FireModel * subModel = model.model;
        while (subModel) {
            subModel = subModel.model;
            lab = [UILabel new];
            lab.textColor = RGBColor(71, 71, 71);
            lab.font = [UIFont systemFontOfSize:17.f];
            lab.textAlignment = NSTextAlignmentRight;
            lab.frame = CGRectMake(100, 19, WIDTH_ - 140, 19);
            [btn addSubview:lab];
            
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0,btn.bottom, WIDTH_, 54)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:RGBColor(168, 168, 168) forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@" %@",model.dict[@"name"]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.bgScr addSubview:btn];
            
            igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 30, 20, 7, 13)];
            igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
            [btn addSubview:igv];
            
            line = [[UIView alloc]initWithFrame:CGRectMake(0, 53, WIDTH_, 0.5)];
            line.backgroundColor = LINE;
            [btn addSubview:line];
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                
            }];
            [self.bgScr addSubview:btn];
            [self makeButton:btn];
        }
    }
    
}

-(UIScrollView *)bgScr {
    if (!_bgScr) {
        UIScrollView * scr = [UIScrollView new];
        scr.backgroundColor = RGBColor(245, 245, 245);
        _bgScr = scr;
    }
    return _bgScr;
}


-(void)makeButton:(UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 13, 0,0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,13, 0,0)];//图片距离右边框距离减少图片的宽度，其它不边
}
@end
