//
//  FireSeachListVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "FireSeachListVC.h"
#import "THScrollChooseView.h"
#import "DISTANCEVC.h"

@interface FireModel ()

@end

@interface FireSeachListVC ()

@property (nonatomic, strong)UIScrollView * bgScr;

@property (nonatomic, strong)NSMutableArray * dataArr;

@property (nonatomic,strong)THScrollChooseView * scrollChooseView;

@property (nonatomic, strong)UIButton * queryBtn;
@end
@implementation FireModel
@end

@implementation FireSeachListVC

- (void)viewDidLoad {
    self.dataArr = [NSMutableArray new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.bgScr];
}

-(void)bindAction {
    WS(ws);
    [[self.queryBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        FireModel * model0 = ws.dataArr[0];
        while (model0.model) {
            model0= model0.model;
        }
        FireModel * model1;
        if(ws.dataArr.count == 1) {
             model1 = ws.dataArr[0];
        }else {
             model1 = ws.dataArr[1];
        }
        while (model1.model) {
            model1= model1.model;
        }
        [mdict setValue:model1.dict[@"id"] forKey:@"structureOutId"];
        [mdict setValue:model0.dict[@"id"] forKey:@"deviceInId"];
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [self POSTurl:GET_DISTANCE
           parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
               [SVProgressHUD dismiss];
               NSDictionary * dic = (NSDictionary *)[self arrayWithJsonString:responseObject[@"data"][@"distance"]];
               if (!dic) {
                   [[Toast shareToast]makeText:@"该设施间的间距不存在" aDuration:1];
               }else {
                   DISTANCEVC * vc = [DISTANCEVC new];
                   vc.modelArr = ws.dataArr;
                   [ws.navigationController pushViewController:vc animated:YES];
               }
           } failure:^(id responseObject) {
               [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
               [SVProgressHUD dismiss];
           }];
    }];
}

-(void)getData {
    WS(ws);
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.title forKey:@"name"];
    [mdict setValue:self.standard forKey:@"standard"];
    if([self.title isEqualToString:@"站内平面布置"]){
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self POSTurl:GET_ARCHITECTURE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            [ws.dataArr removeAllObjects];
            NSString *st = responseObject[@"data"][@"architecture"];
            NSArray *arr = [self arrayWithJsonString:st];
            FireModel * model;
            for (id obj in arr) {
                model = [FireModel new];
                model.dict = [obj mutableCopy];
                [model.dict setValue:[NSString stringWithFormat:@"%@ A",[obj valueForKey:@"name"]] forKey:@"name"];
                [ws.dataArr addObject:model];
                
                model = [FireModel new];
                model.dict = [obj mutableCopy];
                [model.dict setValue:[NSString stringWithFormat:@"%@ B",[obj valueForKey:@"name"]] forKey:@"name"];
                [ws.dataArr addObject:model];
            }
            [ws refreshVi];
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }else{
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
            [ws refreshVi];
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)refreshVi {
    for (UIView * vi in self.bgScr.subviews) {
        if (vi.tag == 111)
            [vi removeFromSuperview];
    }
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, -20, WIDTH_, 0)];
    UIImageView * igv;
    UIView * line;
    UILabel * lab;
    UIButton * superBtn;
    for (FireModel * modelFather in self.dataArr) {
        
        superBtn = btn;
        btn = [[UIButton alloc]initWithFrame:CGRectMake(0,btn.bottom + 20, WIDTH_, 54)];
        [btn setBackgroundColor:LINE];
        [btn setTitleColor:RGBColor(71, 71, 71) forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@" %@",modelFather.dict[@"name"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [btn setImage:[UIImage getImageWithColor:RGBColor(114, 170, 245) andSize:CGSizeMake(4, 18)] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.bgScr addSubview:btn];
        
        igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 30, 20, 7, 13)];
        igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
        igv.tag = 1567;
        [btn addSubview:igv];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(0, 53, WIDTH_, 0.5)];
        line.backgroundColor = LINE;
        [btn addSubview:line];
        
        WS(ws);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

            if (ws.scrollChooseView) {
                [ws.scrollChooseView removeFromSuperview];
                ws.scrollChooseView = nil;
            }
            NSMutableDictionary * mdict = [NSMutableDictionary new];
            [mdict setValue:modelFather.dict[@"code"] forKey:@"parentCode"];
            [mdict setValue:self.standard forKey:@"standard"];
            if (!modelFather.dict[@"code"]) {
                [mdict setValue:self.title forKey:@"name"];
            }
            [SVProgressHUD showWithStatus:@"加载中..."];

            [self POSTurl:GET_ARCHITECTURE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
                [SVProgressHUD dismiss];
                NSString *st = responseObject[@"data"][@"architecture"];
                NSArray *arr = [self arrayWithJsonString:st];
                if (arr.count <= 0) {
                    return ;
                }
                FireModel * model;
                NSMutableArray * namearr = [NSMutableArray new];
                NSMutableArray * modelarr = [NSMutableArray new];
                for (id obj in arr) {
                    model = [FireModel new];
                    model.dict = obj;
                    [modelarr addObject:model];
                    [namearr addObject:[NSString stringWithFormat:@"%@",obj[@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:namearr withDefaultDesc:namearr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    modelFather.model = modelarr[selectedValue];
                    [ws refreshVi];
                }];
                [ws.scrollChooseView showView];

            } failure:^(id responseObject) {
                [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                [SVProgressHUD dismiss];
            }];
        }];
        [self.bgScr addSubview:btn];
        [self makeButton:btn];
        btn.tag = 111;

        FireModel * subModel = modelFather.model;
        int i = 1;
        NSString * str = @"";
        while (subModel) {
            lab = [UILabel new];
            lab.textColor = RGBColor(71, 71, 71);
            lab.font = [UIFont systemFontOfSize:17.f];
            lab.textAlignment = NSTextAlignmentRight;
            float width = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}].width;
            
            
            lab.frame = CGRectMake(width + 10, 19, WIDTH_ - width - 40, 19);
            lab.text = [NSString stringWithFormat:@"%@",subModel.dict[@"name"]];
            [btn addSubview:lab];
            superBtn = btn;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0,btn.bottom, WIDTH_, 54)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:RGBColor(168, 168, 168) forState:UIControlStateNormal];
//            [btn setTitle:[NSString stringWithFormat:@" %@",subModel.dict[@"name"]] forState:UIControlStateNormal];
            switch (i) {
                case 1:
                    str = @"一级选项";
                    break;
                case 2:
                    str = @"二级选项";
                    break;
                case 3:
                    str = @"三级选项";
                    break;
                case 4:
                    str = @"四级选项";
                    break;
                case 5:
                    str = @"五级选项";
                    break;
                default:
                    break;
            }
            
            
            [btn setTitle:str forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.bgScr addSubview:btn];
            
            if ([subModel.dict[@"level"]intValue]<6) {
                if (subModel.model) {
                    igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 30, 20, 7, 13)];
                    igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
                    igv.tag = 1567;
                    [btn addSubview:igv];
                    lab.textColor = BLUE;

                }else {
                    NSMutableDictionary * mdict = [NSMutableDictionary new];
                    [mdict setValue:subModel.dict[@"code"] forKey:@"parentCode"];
                    [mdict setValue:self.standard forKey:@"standard"];
                    [self POSTurl:GET_ARCHITECTURE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
                        NSString *st = responseObject[@"data"][@"architecture"];
                        NSArray *arr = [self arrayWithJsonString:st];
                        if (arr.count <= 0) {
                            btn.height = 0;
                            btn.hidden = YES;
                            [[superBtn viewWithTag:1567] removeFromSuperview];
                            return ;
                        }
                        UIImageView * igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 30, 20, 7, 13)];
                        igv.tag = 1567;
                        igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
                        [btn addSubview:igv];
                        lab.textColor = BLUE;

                    } failure:^(id responseObject) {
                        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                    }];
                }

            }else {
                btn.height = 0;
                btn.hidden = YES;
                [[superBtn viewWithTag:1567] removeFromSuperview];
            }
            
            line = [[UIView alloc]initWithFrame:CGRectMake(0, 53, WIDTH_, 0.5)];
            line.backgroundColor = LINE;
            [btn addSubview:line];
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                if (ws.scrollChooseView) {
                    [ws.scrollChooseView removeFromSuperview];
                    ws.scrollChooseView = nil;
                }
                NSMutableDictionary * mdict = [NSMutableDictionary new];
                [mdict setValue:subModel.dict[@"code"] forKey:@"parentCode"];
                [mdict setValue:self.standard forKey:@"standard"];
                [SVProgressHUD showWithStatus:@"加载中..."];

                [self POSTurl:GET_ARCHITECTURE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
                    [SVProgressHUD dismiss];

                    NSString *st = responseObject[@"data"][@"architecture"];
                    NSArray *arr = [self arrayWithJsonString:st];
                    if (arr.count <= 0) {
                        return ;
                    }
                    FireModel * model;
                    NSMutableArray * namearr = [NSMutableArray new];
                    NSMutableArray * modelarr = [NSMutableArray new];
                    for (id obj in arr) {
                        model = [FireModel new];
                        model.dict = obj;
                        [modelarr addObject:model];
                        [namearr addObject:[NSString stringWithFormat:@"%@",obj[@"name"]]];
                    }
                    ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:namearr withDefaultDesc:namearr[0]];
                    [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                        subModel.model = modelarr[selectedValue];
                        [ws refreshVi];
                    }];
                    [ws.scrollChooseView showView];

                } failure:^(id responseObject) {
                    [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                    [SVProgressHUD dismiss];
                }];
                
            }];
            [self.bgScr addSubview:btn];
            [self makeButton:btn];
            btn.tag = 111;
            subModel = subModel.model;
            i ++;
        }
    }
    
    self.queryBtn.frame = CGRectMake(20, MAX(btn.bottom + 50, HEIGHT_ - 180), WIDTH_ - 40, 54);
    [self.bgScr addSubview:self.queryBtn];

    self.bgScr.contentSize = CGSizeMake(self.bgScr.width,MAX(self.queryBtn.bottom + 100, HEIGHT_));
}

-(UIScrollView *)bgScr {
    if (!_bgScr) {
        UIScrollView * scr = [UIScrollView new];
        scr.backgroundColor = RGBColor(245, 245, 245);
        _bgScr = scr;
    }
    return _bgScr;
}

-(UIButton *)queryBtn {
    if (!_queryBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitle:@"查询" forState:UIControlStateNormal];
        btn.backgroundColor = RGBColor(90, 156, 245);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        _queryBtn = btn;
    }
    return _queryBtn;
}
-(void)makeButton:(UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 13, 0,0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,13, 0,0)];//图片距离右边框距离减少图片的宽度，其它不边
}
@end
