//
//  HomeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "HomeViewController.h"
#import "ChemistryVC.h"

#import "SDCycleScrollView.h"
#import "LawsViewController.h"
#import "SecurityViewController.h"
#import "SearchTypeViewController.h"
#import "perfectUserVC.h"
#import "LoginVC.h"
#import "ChemistySCVC.h"
#import "ListTableViewCell.h"
#import "AXWebViewController.h"
#import "DynamicDetailsViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong)UIView * titleVi;
@property (nonatomic, strong)UISearchBar * search;
@property (nonatomic, strong)UIButton * msgBtn;


@property (nonatomic, strong)UITableView * tbv;
@property (nonatomic, strong)UIView * headerVi;

@property (nonatomic, strong)SDCycleScrollView * cycleScrollView;

@property (nonatomic, strong)UIButton * guifanBtn;
@property (nonatomic,strong)UIButton * lawsBtn;
@property (nonatomic,strong)UIButton * securityBtn;
@property (nonatomic,strong)UIButton * chemicalBtn;
@property (nonatomic,strong)UIButton * fireBtn;
@property (nonatomic,strong)UIButton * moreBtn;

@property (nonatomic, strong)NSMutableArray * dataArr;
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getData];
    UIView * vi = [[UIApplication sharedApplication].delegate.window viewWithTag:11111];
    if (vi) {
        [vi removeFromSuperview];
    }
}


- (void)viewDidLoad {
    self.dataArr = [NSMutableArray new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
        [self.navigationController pushViewController:[LoginVC new] animated:YES];
    }
}

-(void)bindView {
    self.titleVi.frame = CGRectMake(0, 0, WIDTH_, 64);
    [self.view addSubview:self.titleVi];
    
    self.search.frame = CGRectMake(8, 24, WIDTH_ - 72, 36);
    [self.titleVi addSubview:self.search];
    
    self.msgBtn.frame = CGRectMake(self.search.right + 10, 24, 44, 36);
    [self.titleVi addSubview:self.msgBtn];
    
    
    self.tbv.frame = CGRectMake(0, 64, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
    
    self.headerVi = [UIView new];
    self.headerVi.frame = CGRectMake(0, 0, WIDTH_, 469);
    
    [self.headerVi addSubview:self.cycleScrollView];
    
    CGFloat f = (WIDTH_ - 315) / 4;
    self.lawsBtn.frame = CGRectMake(f, self.cycleScrollView.bottom + 20 ,105, 105);
    [self.headerVi addSubview:self.lawsBtn];
    self.guifanBtn.frame = CGRectMake(self.lawsBtn.right + f, self.cycleScrollView.bottom + 20 ,105, 105);
    [self.headerVi addSubview:self.guifanBtn];
    self.securityBtn.frame = CGRectMake(self.guifanBtn                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  .right + f, self.cycleScrollView.bottom + 20,105, 105);
    [self.headerVi addSubview:self.securityBtn];
    
    
    self.chemicalBtn.frame = CGRectMake(f, self.lawsBtn.bottom + 20,105, 105);
    [self.headerVi addSubview:self.chemicalBtn];
    self.fireBtn.frame = CGRectMake(f + self.chemicalBtn.right, self.lawsBtn.bottom + 20,105, 105);
    [self.headerVi addSubview:self.fireBtn];
    self.moreBtn.frame = CGRectMake(f + self.fireBtn.right + 5, self.lawsBtn.bottom + 20 +5,95, 95);
    [self.headerVi addSubview:self.moreBtn];
    
    [self makeButton:self.securityBtn];
    [self makeButton:self.guifanBtn];
    [self makeButton:self.chemicalBtn];
    [self makeButton:self.fireBtn];
    [self makeButton:self.lawsBtn];
    
    UILabel * lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:18.f];
    lab.textColor = RGBColor(94, 94, 94);
    lab.frame = CGRectMake(10, self.moreBtn.bottom + 30, WIDTH_, 18);
    lab.text = @"最近更新记录";
    [self.headerVi addSubview:lab];
    
    UILabel *lbLin1 = [UILabel new];
    lbLin1.frame = CGRectMake(15, lab.bottom + 10, WIDTH_, 0.3);
    lbLin1.backgroundColor = [UIColor grayColor];
    [self.headerVi addSubview:lbLin1];

    
    self.tbv.tableHeaderView = self.headerVi;
}

-(void)bindModel {
    self.cycleScrollView.localizationImageNamesGroup = @[@"banner"];
}

-(void)bindAction {
    WS(ws);
    [[self.guifanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SearchTypeViewController * vc = [SearchTypeViewController new];
        vc.title = @"标准规范";
        [ws.navigationController setNavigationBarHidden:NO animated:NO];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    [[self.lawsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SearchTypeViewController * vc = [SearchTypeViewController new];
        vc.title = @"法律法规";
        [ws.navigationController setNavigationBarHidden:NO animated:NO];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    [[self.securityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SearchTypeViewController * vc = [SearchTypeViewController new];
        vc.title = @"政策文件";
        [ws.navigationController setNavigationBarHidden:NO animated:NO];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    [[self.chemicalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[ChemistryVC new] animated:YES];
    }];
    [[self.fireBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws.navigationController setNavigationBarHidden:NO animated:NO];
        [ws.navigationController pushViewController:[NSClassFromString(@"FireSeparationVC") new] animated:YES];
    }];
    [[self.msgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws.navigationController setNavigationBarHidden:NO animated:NO];
        [ws.navigationController pushViewController:[NSClassFromString(@"NewsVC") new] animated:YES];

    }];

}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:[NSClassFromString(@"SEARCHVC") new] animated:YES];

    return NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%li-%li",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.dataArr[indexPath.row]  valueForKey:@"lawName"];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic= self.dataArr[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@/files/%@.%@",BASE_URL,dic[@"filePath"],dic[@"fileFrom"]];
    url = [url stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DynamicDetailsViewController *webVC = [[DynamicDetailsViewController alloc] init];
    webVC.urlStr = url;
    webVC.title = @"详情页";
    [self.navigationController pushViewController:webVC animated:YES];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 11111;
    [btn setFrame:CGRectMake(WIDTH_ - 44, 27, 44, 30)];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].delegate.window addSubview:btn];
    
    if([dic[@"is_favorite"]intValue] == 1){
        //已收藏
        [btn setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
    }
    WS(ws);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:@"flfg" forKey:@"typeCode"];
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
        [mdict setValue:dic[@"id"] forKey:@"lawId"];
        if([btn.imageView.image isEqual:[UIImage imageNamed:@"文章收藏icon_已收藏"]]) {
            [ws POSTurl:CANCEL_FAVORITE parameters:@{@"data":[ws dictionaryToJson:mdict]} success:^(id responseObject) {
                
                [btn setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
                
                [[Toast shareToast]makeText:@"取消收藏成功" aDuration:1];
                
                [SVProgressHUD dismiss];
            } failure:^(id responseObject) {
                [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                [SVProgressHUD dismiss];
            }];
        }else {
            [ws POSTurl:ADD_FAVORITE parameters:@{@"data":[ws dictionaryToJson:mdict]} success:^(id responseObject) {
                [btn setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
                [[Toast shareToast]makeText:@"收藏成功" aDuration:1];
                [SVProgressHUD dismiss];
            } failure:^(id responseObject) {
                [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                [SVProgressHUD dismiss];
            }];
        }
        
    }];
    
}
#pragma mark - 加载数据
-(void)getData {
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] forKey:@"userId"];
    WS(ws);
    [self POSTurl:Get_NewLawList parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"newList"];
        NSArray *arr = [self arrayWithJsonString:st];
        [ws.dataArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            [ws.dataArr addObject:dic];
        }
        [ws.tbv reloadData];
        [ws.tbv.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [ws.tbv.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}


-(UIView *)titleVi {
    if (!_titleVi) {
        UIView * vi = [UIView new];
        vi.backgroundColor = [UIColor whiteColor];
        
        _titleVi = vi;
    }
    return _titleVi;
}

- (UISearchBar *)search {
    if (!_search) {
        _search = [UISearchBar new];
        [_search setBackgroundImage:[UIImage getImageWithColor:[UIColor clearColor] andSize:CGSizeMake(WIDTH_ - 72, 36)]];
        [_search setSearchFieldBackgroundImage:[[UIImage getImageWithColor:RGBColor(238, 238, 238) andSize:CGSizeMake(WIDTH_ - 72, 36)] createRadius:8] forState:UIControlStateNormal];
        _search.placeholder = @"搜索";
        _search.delegate = self;
        //一下代码为修改placeholder字体的颜色和大小
        UITextField * searchField = [_search valueForKey:@"_searchField"];
        [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return _search;
}

-(UIButton *)msgBtn {
    if (!_msgBtn) {
        UIButton * btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"nav_无消息通知"] forState:UIControlStateNormal];

        _msgBtn = btn;
    }
    return _msgBtn;
}
-(UIButton *)guifanBtn {
    if (!_guifanBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"标准规范\n查询" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_btn_icon_标准查询"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundImage:[UIImage imageNamed:@"home-btn"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _guifanBtn = btn;
    }
    return _guifanBtn;
}

-(UIButton *)lawsBtn {
    if (!_lawsBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"法律法规\n查询" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_btn_icon_法律法规查询"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundImage:[UIImage imageNamed:@"home-btn"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        
        _lawsBtn = btn;
    }
    return _lawsBtn;
}

-(UIButton *)securityBtn {
    if (!_securityBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"政策文件\n查询" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_btn_icon_政策查询"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundImage:[UIImage imageNamed:@"home-btn"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        _securityBtn = btn;
    }
    return _securityBtn;
}

-(UIButton *)chemicalBtn {
    if (!_chemicalBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"危化品\n查询" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_btn_icon_危化品查询"] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundImage:[UIImage imageNamed:@"home-btn"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;

        _chemicalBtn = btn;
    }
    return _chemicalBtn;
}

-(UIButton *)fireBtn {
    if (!_fireBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"防火间距\n计算" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"home_btn_icon_防火间距"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        [btn setBackgroundImage:[UIImage imageNamed:@"home-btn"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;

        _fireBtn = btn;
    }
    return _fireBtn;
}
-(UIButton *)moreBtn {
    if (!_moreBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:RGBColor(214, 214, 214) forState:UIControlStateNormal];
        [btn setTitle:@"新功能\n待开发" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setBackgroundImage:[UIImage imageNamed:@"home_btn_disabled"] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        _moreBtn = btn;
    }
    return _moreBtn;
}

-(UITableView *)tbv {
    if (!_tbv) {
        UITableView * tbv = [UITableView new];
        [tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        tbv.delegate = self;
        tbv.dataSource = self;
        tbv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        WS(ws);
        tbv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [ws getData];
        }];
        _tbv = tbv;
    }
    return _tbv;
}

-(SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        SDCycleScrollView * sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_, 170) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _cycleScrollView = sdc;
    }
    return _cycleScrollView;
}

-(void)makeButton:(UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height  + 20,-btn.imageView.frame.size.width, 5,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(- 15.0, 0.0,15.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}

@end
