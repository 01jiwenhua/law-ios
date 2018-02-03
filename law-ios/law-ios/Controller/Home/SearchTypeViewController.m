//
//  SearchTypeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SearchTypeViewController.h"
#import "ZWMSegmentController.h"
#import "ListViewController.h"

@interface SearchTypeViewController ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation SearchTypeViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindAction {
    
}


-(void)getData {
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    NSString * typeCode;
    if([self.title isEqualToString:@"标准规范"])
        typeCode = @"bzgf";
    if([self.title isEqualToString:@"法律法规"])
        typeCode = @"flfg";
    if([self.title isEqualToString:@"政策文件"])
        typeCode = @"zcwj";
    [mdict setValue:typeCode forKey:@"typeCode"];

    WS(ws);
    [self POSTurl:GET_LEVELLIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if (responseObject[@"data"][@"levelList"]) {
            
            NSMutableArray * arr  = [NSMutableArray new];
            NSMutableArray * array = [NSMutableArray new];
            NSArray * dataArr = [ws arrayWithJsonString:responseObject[@"data"][@"levelList"]];
            ListViewController * listVC;
            for (id obj in dataArr) {

                [arr addObject:[NSString stringWithFormat:@"%@",obj[@"name"]]];
                listVC = [ListViewController new];
                listVC.level = [NSString stringWithFormat:@"%@",obj[@"code"]];
                listVC.typeCode = typeCode;
                [array addObject:listVC];
            }
            ws.segmentVC = [[ZWMSegmentController alloc] initWithFrame:ws.view.bounds titles:arr];
            ws.segmentVC.segmentView.showSeparateLine = YES;
            ws.segmentVC.segmentView.segmentTintColor = RGBColor(65,162, 240);
            ws.segmentVC.viewControllers = [array copy];
            if (array.count==1) {
                ws.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
            } else {
                ws.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
            }
            [ws addSegmentController:ws.segmentVC];
            [ws.segmentVC  setSelectedAtIndex:0];

        }
        
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

@end
