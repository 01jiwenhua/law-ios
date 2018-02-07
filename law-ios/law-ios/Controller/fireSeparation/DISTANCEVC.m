//
//  DISTANCEVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/8.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "DISTANCEVC.h"
#import "FireSeachListVC.h"

@interface DISTANCEVC ()

@property (nonatomic, strong)id dic;

@property (nonatomic, strong)UIScrollView * bgScr;
@end

@implementation DISTANCEVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查询结果";
    
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.bgScr];
}

-(void)getData {
    WS(ws);
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    FireModel * model0 = self.modelArr[0];
    while (model0.model) {
        model0= model0.model;
    }
    FireModel * model1 = self.modelArr[1];
    while (model1.model) {
        model1= model1.model;
    }
    [mdict setValue:model1.dict[@"id"] forKey:@"structureOutId"];
    [mdict setValue:model0.dict[@"id"] forKey:@"deviceInId"];
    [mdict setValue:@52 forKey:@"structureOutId"];
    [mdict setValue:@33 forKey:@"deviceInId"];
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [self POSTurl:GET_DISTANCE
       parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
           ws.dic = responseObject;
           [ws reloadVi];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

-(void)reloadVi {
    FireModel * model0 = self.modelArr[0];
    NSMutableString * str0 = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@",model0.dict[@"name"]]];
    while (model0.model) {
        model0= model0.model;
        [str0 appendString:[NSString stringWithFormat:@">>%@",model0.dict[@"name"]]];
    }
    FireModel * model1 = self.modelArr[1];
    NSMutableString * str1 = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@",model0.dict[@"name"]]];
    while (model1.model) {
        model1= model1.model;
        [str1 appendString:[NSString stringWithFormat:@">>%@",model1.dict[@"name"]]];
    }
    
    
    UILabel * lab = [UILabel new];
    lab.frame = CGRectMake(20, 20, WIDTH_ - 40, 18);
    lab.font = [UIFont systemFontOfSize:18.0];
    lab.textColor = RGBColor(71, 71, 71);
    lab.text = @"查询条件";
    [self.view addSubview:lab];
    
    UILabel * lab1 = [UILabel new];
    lab1.frame = CGRectMake(20, lab.bottom + 12, WIDTH_ - 40, 18);
    lab1.font = [UIFont systemFontOfSize:18.0];
    lab1.textColor = RGBColor(71, 71, 71);
    lab1.text = [NSString stringWithFormat:@"站内设施:%@",model0.dict[@"name"]];
    [self.view addSubview:lab1];
    
    UILabel * lab2 = [UILabel new];
    lab2.frame = CGRectMake(20, lab1.bottom + 12, WIDTH_ - 40, 18);
    lab2.font = [UIFont systemFontOfSize:16.0];
    lab2.textColor = RGBColor(168, 168, 168);
    lab2.text = str0;
    [self.view addSubview:lab2];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 113, WIDTH_ - 40, 0.5)];
    line.backgroundColor = LINE;
    [self.view addSubview:line];
    
    UILabel * lab3 = [UILabel new];
    lab3.frame = CGRectMake(20, line.bottom + 18, WIDTH_ - 40, 18);
    lab3.font = [UIFont systemFontOfSize:18.0];
    lab3.textColor = RGBColor(71, 71, 71);
    lab3.text = [NSString stringWithFormat:@"站外建（构）筑物:%@",model1.dict[@"name"]];
    [self.view addSubview:lab3];
    
    UILabel * lab4 = [UILabel new];
    lab4.frame = CGRectMake(20, lab3.bottom + 12, WIDTH_ - 40, 18);
    lab4.font = [UIFont systemFontOfSize:16.0];
    lab4.textColor = RGBColor(168, 168, 168);
    lab4.text = str1;
    [self.view addSubview:lab4];
    
    
    UIView * vi = [UIView new];
    vi.backgroundColor = [UIColor whiteColor];
    vi.frame = CGRectMake(10, 198, WIDTH_ - 20, 100);
    [self.view addSubview:vi];
    
    
    UILabel * lab5 = [UILabel new];
    lab5.frame = CGRectMake(0, 16, WIDTH_ - 40, 18);
    lab5.font = [UIFont systemFontOfSize:18.0];
    lab5.textColor = RGBColor(71, 71, 71);
    lab5.textAlignment = NSTextAlignmentCenter;
    lab5.text = @"查询结果";
    [vi addSubview:lab5];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WIDTH_ - 40, 0.5)];
    line1.backgroundColor = LINE;
    [vi addSubview:line1];
    
    UILabel * lab6 = [UILabel new];
    lab6.frame = CGRectMake(10, 84, 90, 16);
    lab6.font = [UIFont systemFontOfSize:16.0];
    lab6.textColor = RGBColor(103, 103, 103);
    lab6.text = [NSString stringWithFormat:@"安全距离："];
    [vi addSubview:lab6];

    UILabel * lab7 = [UILabel new];
    lab7.frame = CGRectMake(10, 118, 90, 16);
    lab7.font = [UIFont systemFontOfSize:16.0];
    lab7.textColor = RGBColor(103, 103, 103);
    lab7.text = [NSString stringWithFormat:@"查询标准："];
    [vi addSubview:lab7];
    
    UILabel * lab8 = [UILabel new];
    lab8.frame = CGRectMake(10, 152, 90, 16);
    lab8.font = [UIFont systemFontOfSize:16.0];
    lab8.textColor = RGBColor(103, 103, 103);
    lab8.text = [NSString stringWithFormat:@"相关说明："];
    [vi addSubview:lab8];
    
    
    NSDictionary * dic = (NSDictionary *)[self arrayWithJsonString:self.dic[@"data"][@"distance"]];
    
    
    UILabel * lab9 = [UILabel new];
    lab9.frame = CGRectMake(90, 72, WIDTH_ - 120, 30);
    lab9.font = [UIFont systemFontOfSize:30.0];
    lab9.textColor = RGBColor(250, 58, 58);
    lab9.text = [NSString stringWithFormat:@"%@m",dic[@"distance"]];
    [vi addSubview:lab9];
    
    UILabel * lab10 = [UILabel new];
    lab10.frame = CGRectMake(90, 118, WIDTH_ - 120, 16);
    lab10.font = [UIFont systemFontOfSize:16];
    lab10.textColor = RGBColor(71, 71, 71);
    lab10.text = dic[@"instruction"];
    [vi addSubview:lab10];
    
    UILabel * lab11 = [UILabel new];
    lab11.frame = CGRectMake(90, 152, WIDTH_ - 120, 16);
    lab11.font = [UIFont systemFontOfSize:16];
    lab11.textColor = RGBColor(71, 71, 71);
    lab11.text = dic[@"standard"];
    lab11.numberOfLines = 0;
    [vi addSubview:lab11];
    
    vi.height = lab11.bottom + 20;
    
    self.bgScr.contentSize = CGSizeMake(WIDTH_,MAX( vi.bottom + 20, HEIGHT_));
}

-(UIScrollView *)bgScr {
    if (!_bgScr) {
        UIScrollView * scr = [UIScrollView new];
        scr.backgroundColor = RGBColor(245, 245, 245);

        _bgScr = scr;
    }
    return _bgScr;
}
@end
