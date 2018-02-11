//
//  ListViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "AXWebViewController.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)UITableView * tbv;
@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,assign)int page;

@property (nonatomic, strong)UISearchBar * search;

@end

@implementation ListViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 0;
    [self getData];
    UIView * vi = [[UIApplication sharedApplication].delegate.window viewWithTag:11111];
    if (vi) {
        [vi removeFromSuperview];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 0;
    UIView * line1 = [UIView new];
    line1.backgroundColor = RGBColor(233, 233, 233);
    line1.frame = CGRectMake(0, 0, WIDTH_, 0.5);
    [self.view addSubview:line1];
    UIView * line2 = [UIView new];
    line2.backgroundColor = RGBColor(233, 233, 233);
    line2.frame = CGRectMake(0, 55, WIDTH_, 0.5);
    [self.view addSubview:line2];
    
    
    self.search.frame = CGRectMake(20, 10, WIDTH_ - 40, 36);
    [self.view addSubview:self.search];
    
    self.tbv.frame = CGRectMake(0,56, WIDTH_, HEIGHT_ - 108 - 56);
    [self.view addSubview:self.tbv];
    
    WS(ws);
    self.tbv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        ws.page = 0;
        [ws getData];
    }];
    
    self.tbv.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ws.page ++;
        [ws getData];
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchStr = searchBar.text;
    self.page = 0;
    [self getData];
}
-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    
    [mdict setValue:self.typeCode forKey:@"typeCode"];
    [mdict setValue:self.level forKey:@"level"];
    [mdict setValue:[NSNumber numberWithInt:self.page + 1] forKey:@"page"];
    [mdict setValue:@10 forKey:@"pageSize"];
    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    if (self.searchStr.length > 0) {
        [mdict setValue:self.searchStr forKey:@"description"];
        [mdict setValue:self.searchStr forKey:@"name"];
    }
    
    
    [self POSTurl:GET_LAWLIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"lawList"];
        NSArray *arr = [self arrayWithJsonString:st];
        if (ws.page == 0) {
            [ws.dataArr removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            [ws.dataArr addObject:dic];
        }
        [ws.tbv reloadData];
        [ws.tbv.mj_header endRefreshing];
        [ws.tbv.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [ws.tbv.mj_header endRefreshing];
        [ws.tbv.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    
    NSMutableAttributedString * mStr0 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"lawName"]]];
    NSRange range0 = [mStr0.string rangeOfString:self.searchStr];
    if (range0.length > 0) {
        [mStr0 addAttribute:NSForegroundColorAttributeName value:RGBColor(114, 177, 245) range:range0];

    }
    cell.TitlrLab.attributedText = mStr0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.mLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"issueNo"]];
    cell.timeNewLab.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[self.dataArr[indexPath.row]  valueForKey:@"publishTime"] doubleValue]/ 1000]];
    
    cell.DLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"description"]];
    
    
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"description"]]];
    NSRange range = [mStr.string rangeOfString:self.searchStr];
    if (range.length > 0) {
        [mStr addAttribute:NSForegroundColorAttributeName value:RGBColor(114, 177, 245) range:range];
        
    }
    cell.DLab.attributedText = mStr;
    if(mStr.length <=0) {
        cell.DLab.text = @"暂无摘要";

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic= self.dataArr[indexPath.row];
    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:[NSString stringWithFormat:@"%@/files/%@.%@",BASE_URL,dic[@"filePath"],dic[@"fileFrom"]]];
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
        [mdict setValue:ws.typeCode forKey:@"typeCode"];
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
        [mdict setValue:dic[@"id"] forKey:@"lawId"];
        if([dic[@"is_favorite"]intValue] == 1) {
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

-(UITableView *)tbv {
    if (!_tbv) {
        UITableView * tbv = [UITableView new];
        [tbv registerClass:[ListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ListTableViewCell class])];
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

-(NSString *)searchStr {
    if (_searchStr && _searchStr.length > 0) {
        return [NSString stringWithFormat:@"%@",_searchStr];

    }
    return @"";
}
@end
