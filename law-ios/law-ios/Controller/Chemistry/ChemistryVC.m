//
//  ChemistryVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ChemistryVC.h"
#import "TypeButtonView.h"
#import "ConditionChooseVC.h"
#import "ChemistryModel.h"
#import "ChemistySelectData.h"
#import "ChemistryDetailVC.h"

@interface ChemistryVC ()<TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource,SelectedDelegate>
@property (nonatomic, strong ) UIView *viKnow;
@property (nonatomic, strong ) UIView *viUnKnow;
@property (nonatomic, strong ) UITextField *tfName;
@property (nonatomic, strong ) UIButton *btnSelect;
@property (nonatomic, strong ) UITableView *tvList;
@property (nonatomic, strong ) UITableView *tvListUnKnow;
@property (nonatomic, strong ) NSArray *arrPorCPro;
@property (nonatomic, strong ) NSArray *arrDanHealth;
@property (nonatomic, strong ) NSMutableArray *arrKnow;
@property (nonatomic, strong ) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter * refreshFooter;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong )NSMutableDictionary *dicRequest;
@property (nonatomic, strong )UITableViewCell *cellCurrent;
@end

@implementation ChemistryVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindModel {
    self.arrPorCPro = [NSArray new];
    self.arrDanHealth = [NSArray new];
    self.arrKnow = [NSMutableArray array];
    self.dicRequest = [NSMutableDictionary dictionary];
}

-(void)bindView{
    self.title = @"已知物质查询";
    TypeButtonView  *typeBtnView = [[TypeButtonView  alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    [typeBtnView setTypeButtonTitles:@[@"已知物质查询",@"未知物质查询"] withDownLableHeight:2 andDeleagte:self];
    [typeBtnView setTypeButtonNormalColor:RGBColor(153, 153, 153) andSelectColor:RGBColor(50, 154, 240)];
    typeBtnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:typeBtnView];
    
    self.viUnKnow = [UIView new];
    self.viUnKnow.frame = CGRectMake(0, typeBtnView.bottom, WIDTH_, HEIGHT_ - typeBtnView.bottom);
    self.viUnKnow.hidden = YES;
    self.viUnKnow.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.viUnKnow];
   
    self.viKnow = [UIView new];
    self.viKnow.frame = CGRectMake(0, typeBtnView.bottom, WIDTH_, HEIGHT_ - typeBtnView.bottom);
    [self.view addSubview:self.viKnow];
    [self setViKonw];
//    [self setViUnKonw];
    
}

-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[NSString stringWithFormat:@"%i",self.currentPage + 1] forKey:@"page"];
    [mdict setValue:@"10" forKey:@"pageSize"];
    [mdict setValue:self.tfName.text forKey:@"name"];

  
    [self POSTurl:GET_KNOWNLIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"chemicalsList"];
        NSArray *arr = [self arrayWithJsonString:st];
        if (ws.currentPage == 0) {
            [ws.arrKnow removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            ChemistryModel *model = [ChemistryModel yy_modelWithJSON:dic];
            [ws.arrKnow addObject:model];
        }
        [ws.tvList reloadData];
        [ws.tvList.mj_header endRefreshing];
        [ws.tvList.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
    
    [self POSTurl:GET_UNKNOWPARAMS parameters:@{} success:^(id responseObject) {
        ws.arrPorCPro = responseObject[@"data"][@"lhList"];
        ws.arrDanHealth = responseObject[@"data"][@"jkwhList"];
        [self setViKonw];
        [self setViUnKonw];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

-(void)setViKonw{
    if (!self.tfName) {
         self.tfName = [UITextField new];
    }
    self.tfName.frame = CGRectMake(10, 10, WIDTH_ - 60, 30);
    self.tfName.placeholder = @" 请输入危化品名称进行搜索";
    self.tfName.layer.borderWidth = 0.5;
    self.tfName.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.viKnow addSubview:self.tfName];
    
    if (!self.btnSelect) {
        self.btnSelect = [UIButton new];
    }
    self.btnSelect.frame = CGRectMake(self.tfName.right + 5, 10, 30, 30);
    [self.btnSelect setImage:[UIImage imageNamed:@"ic_search"] forState:UIControlStateNormal];
    [self.btnSelect addTarget:self action:@selector(selectWithName) forControlEvents:UIControlEventTouchUpInside];
    [self.viKnow addSubview:self.btnSelect];
    
    if (!self.tvList) {
        self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, self.tfName.bottom + 5, WIDTH_, self.viKnow.height - self.tfName.bottom - 5)];
    }
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.mj_header = self.refreshHeader;
    self.tvList.mj_footer = self.refreshFooter;
    [self.viKnow addSubview:self.tvList];
}

-(void)selectWithName{
    self.currentPage = 0;
    [self getData];
    [self.tfName resignFirstResponder];
}

-(void)setViUnKonw{
    if (!self.tvListUnKnow) {
        self.tvListUnKnow = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_, HEIGHT_ - 200)style:UITableViewStyleGrouped];
    }
    self.tvListUnKnow.delegate = self;
    self.tvListUnKnow.dataSource = self;
    [self.viUnKnow addSubview:self.tvListUnKnow];
   
    UIButton *btnSelectData = [UIButton new];
    btnSelectData.frame = CGRectMake(20, self.tvListUnKnow.bottom + 20, WIDTH_ - 40, 40);
    [btnSelectData setBackgroundColor:BLUE];
    [btnSelectData setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSelectData addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [btnSelectData setTitle:@"查询" forState:UIControlStateNormal];
    [self.viUnKnow addSubview:btnSelectData];
}


-(void)didClickTypeButtonAction:(UIButton*)button withIndex:(NSInteger)index{
    
    if (index == 0) {
        self.viKnow.hidden = NO;
        self.viUnKnow.hidden = YES;
        self.title = @"已知物质查询";
    }else{
        self.viKnow.hidden = YES;
        self.viUnKnow.hidden = NO;
        self.title = @"未知物质查询";
    }
}



-(void)selectAction{
    ChemistySelectData *vc = [ChemistySelectData new];
    vc.dic = self.dicRequest;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:self.tvListUnKnow]) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tvListUnKnow]) {
        if (section == 0) {
            return self.arrPorCPro.count;
        }else {
            return self.arrDanHealth.count;
        }
    }
    return self.arrKnow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"%li-%li",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([tableView isEqual:self.tvListUnKnow]) {
        cell.textLabel.textColor = [UIColor lightGrayColor];
        if (indexPath.section == 0) {
            cell.textLabel.text = self.arrPorCPro[indexPath.row][@"categoryName"];
        }else{
            cell.textLabel.text = self.arrDanHealth[indexPath.row][@"categoryName"];
        }
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ChemistryModel *model = _arrKnow[indexPath.row];
    cell.textLabel.text = model.nameCn;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.cellCurrent = cell;
    if ([tableView isEqual:self.tvListUnKnow]) {
        ConditionChooseVC *vc = [ConditionChooseVC new];
        vc.delegate = self;
        NSDictionary *dic;
        if (indexPath.section == 0) {
            dic= _arrPorCPro[indexPath.row];
        }else{
            dic= _arrDanHealth[indexPath.row];
        }
        vc.code = dic[@"categoryCode"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChemistryModel *model = _arrKnow[indexPath.row];
        ChemistryDetailVC *vc =[ChemistryDetailVC new];
        vc.ID = model.id;
        vc.name = model.nameCn;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.tvListUnKnow]) {
        return 60 ;
    }
    return 4;
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.tvListUnKnow]) {
        UILabel *lb = [UILabel new];
        lb.text = @"  理化特征";
        if (section == 1) {
            lb.text = @"  健康危害";
        }
        lb.backgroundColor = [UIColor whiteColor];
        return lb;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)select:(NSDictionary *)dic{
    [self.dicRequest addEntriesFromDictionary:dic];
    self.cellCurrent.detailTextLabel.text =dic.allValues[0];
}


-(MJRefreshNormalHeader *)refreshHeader {
    if (!_refreshHeader) {
        WS(ws);
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            ws.currentPage = 0;
            [self getData];
        }];
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _refreshHeader;
}

-(MJRefreshBackNormalFooter *)refreshFooter {
    if (!_refreshFooter){
        WS(ws);
        _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            ws.currentPage ++;
            [self getData];
        }];
    }
    return _refreshFooter;
}

@end
