//
//  SearchViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView * searchVi;
@property (nonatomic,strong)UIButton * typeBtn;
@property (nonatomic,strong)UITextField * searchTfd;

@property (nonatomic,strong)UIView * typeVi;

@property (nonatomic,strong)UITableView * tbv;
@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,assign)int page;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 0;
    self.title = @"查询";
    
    self.searchVi.frame = CGRectMake(0, 0, WIDTH_, 44);
    [self.view addSubview:self.searchVi];
    
    self.tbv.frame = CGRectMake(0, self.searchVi.bottom, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
    
    self.typeVi.frame = CGRectMake(self.typeBtn.left, self.typeBtn.bottom, 80, 90);
    [self.view addSubview:self.typeVi];
}

-(void)bindAction {
    WS(ws);
    [[self.typeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ws.typeVi.hidden = !ws.typeVi.hidden;
    }];
}

-(void)getData {
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.name forKey:@"name"];
    [mdict setValue:@"" forKey:@"level"];
    [mdict setValue:self.typeBtn.titleLabel.text forKey:@"typeName"];
    [mdict setValue:@"1" forKey:@"typeCode"];
    [mdict setValue:@"" forKey:@"issoNo"];
    [mdict setValue:[NSNumber numberWithInt:self.page] forKey:@"page"];
    [mdict setValue:@20 forKey:@"pageSize"];
    [mdict setValue:@"" forKey:@"description"];

    [self POSTurl:GET_LAWLIST parameters:mdict success:^(id responseObject) {
        
    } failure:^(id responseObject) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UIView *)searchVi {
    if (!_searchVi) {
        UIView * vi = [UIView new];
        vi.backgroundColor = RGBColor(245, 245, 245);
        
        self.typeBtn.frame = CGRectMake(13, 10, 80, 25);
        [vi addSubview:self.typeBtn];
        
        self.searchTfd.frame = CGRectMake(self.typeBtn.right + 10, 7, WIDTH_ - self.typeBtn.right - 50, 30);
        [vi addSubview:self.searchTfd];
        
        UIImageView * igv = [UIImageView new];
        igv.image = [UIImage imageNamed:@"ic_search"];
        igv.frame = CGRectMake(WIDTH_ - 33, 10, 20, 20);
        [vi addSubview:igv];
        
        _searchVi = vi;
    }
    return _searchVi;
}

-(UIButton *)typeBtn {
    if (!_typeBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:TEXT forState:UIControlStateNormal];
        [btn setTitle:@"标题" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        //是否设置边框以及是否可见
        [btn.layer setMasksToBounds:YES];
        //设置边框线的宽
        [btn.layer setBorderWidth:1];
        //设置边框线的颜色
        [btn.layer setBorderColor:[LINE CGColor]];
        
        _typeBtn = btn;
    }
    return _typeBtn;
}

-(UIView *)typeVi {
    if (!_typeVi) {
        UIView * vi = [UIView new];
        vi.backgroundColor = RGBColor(245, 245, 245);
        vi.hidden = YES;
        
        
        NSArray * title = @[@"标题",@"内容",@"号令"];
        UIButton * btn;
        UIView * line;
        for(int i= 0 ;i<3 ; i++) {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 30 *i, 80, 30)];
            [btn setTitleColor:TEXT forState:UIControlStateNormal];
            [btn setTitle:title[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
            [vi addSubview:btn];
            
            
            line = [[UIView alloc]initWithFrame:CGRectMake(0, btn.bottom - 1, btn.width, 0.5)];
            line.backgroundColor = LINE;
            [btn addSubview:line];
            
            WS(ws);
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [ws.typeBtn setTitle:btn.titleLabel.text forState:UIControlStateNormal];
                vi.hidden = YES;
            }];
        }
        _typeVi = vi;
    }
    return _typeVi;
}

-(UITextField *)searchTfd {
    if (!_searchTfd) {
        UITextField * tfd = [UITextField new];
        tfd.placeholder = @"请输入关键字";
        tfd.font = [UIFont systemFontOfSize:14.f];
        tfd.layer.borderColor= LINE.CGColor;
        
        tfd.layer.borderWidth= 1.0f;
        _searchTfd = tfd;
    }
    return _searchTfd;
}

-(UITableView *)tbv {
    if (!_tbv) {
        UITableView * tbv = [UITableView new];
        [tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        tbv.delegate = self;
        tbv.dataSource = self;
        tbv.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tbv = tbv;
    }
    return _tbv;
}

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
@end
