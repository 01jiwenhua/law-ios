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
#import "AXWebViewController.h"

@interface ChemistryVC ()<UIPickerViewDataSource,UIPickerViewDelegate,TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource,SelectedDelegate,UISearchBarDelegate>
@property (nonatomic, strong ) UIView *viKnow;
@property (nonatomic, strong ) UIView *viUnKnow;
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
@property (nonatomic, strong)UISearchBar * search;
@property (nonatomic, strong )UIView *viSelect;
@property (nonatomic, strong )UIPickerView *pickerView;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong ) NSString *code;
@property (nonatomic, strong ) NSMutableArray *arrKeyValue1;
@property (nonatomic, strong ) NSMutableArray *arrKeyValue2;
@property (nonatomic, assign )int row;
@property (nonatomic, assign )int section;
@end

@implementation ChemistryVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    self.arrKeyValue1 = [NSMutableArray array];
    self.arrKeyValue2 = [NSMutableArray array];
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
    self.viSelect = [UIView new];
    self.viSelect.frame = CGRectMake(0, HEIGHT_ - 264, WIDTH_, 200);
    self.viSelect.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *btn = [UIButton new];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.frame = CGRectMake(WIDTH_ - 80, 10, 70, 40);
    [btn addTarget:self action:@selector(finishSelectAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.viSelect addSubview:btn];
    UIButton *btn1= [UIButton new];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(20, 10, 70, 40);
    [btn1 addTarget:self action:@selector(cancleSelectAction) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.viSelect addSubview:btn1];
    
    self.pickerView = [UIPickerView new];
    self.pickerView.frame = CGRectMake(0, btn.bottom + 5 , WIDTH_, 155);
    self.pickerView.dataSource =self;
    self.pickerView.delegate = self;
    [self.viSelect addSubview:self.pickerView];
    self.viSelect.hidden = YES;
    [self.view addSubview:self.viSelect];
}

-(void)cancleSelectAction{
     self.viSelect.hidden = YES;
}

-(void)finishSelectAction{
    self.viSelect.hidden = YES;
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSDictionary *dicIndex = [self.arrData objectAtIndex:row1];
    NSDictionary *dic;
    if ([self.code isEqualToString:@"B_STATUS"]) {
        dic = @{@"status":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_COLOR"]) {
        dic = @{@"color":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_SMELL"]) {
        dic = @{@"smell":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_TASTE"]) {
        dic = @{@"taste":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_SPECIFIC_AIR"]) {
        dic = @{@"specific_air":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_SPECIFIC_WATER"]) {
        dic = @{@"specific_water":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_PH"]) {
        dic = @{@"ph":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_TRANSPARENCY"]) {
        dic = @{@"transparency":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_NERVOUS"]) {
        dic = @{@"nervous":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_EYE"]) {
        dic = @{@"eye":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_EAR"]) {
        dic = @{@"ear":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_MOUTH_THROAT"]) {
        dic = @{@"mouth_throat":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_CARDIOVASCULAR"]) {
        dic = @{@"cardiovascular":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_RESPIRATORY"]) {
        dic = @{@"respiratory":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_GASTRO_URINARY"]) {
        dic = @{@"gastro_urinary":dicIndex[@"name"]};
    }
    if ([self.code isEqualToString:@"B_SKIN"]) {
        dic = @{@"skin":dicIndex[@"name"]};
    }
    [self.dicRequest addEntriesFromDictionary:dic];
    self.cellCurrent.detailTextLabel.text =dic.allValues[0];
    if (self.section == 0) {
        NSDictionary *dickeyvelue = self.arrKeyValue1[self.row];
        self.arrKeyValue1[self.row] =@{dickeyvelue.allKeys[0]:dic.allValues[0]};
    }else{
        NSDictionary *dic = self.arrKeyValue2[self.row];
        self.arrKeyValue2[self.row] =@{dic.allKeys[0]:dic.allValues[0]};
    }
}

-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[NSString stringWithFormat:@"%i",self.currentPage + 1] forKey:@"page"];
    [mdict setValue:@"10" forKey:@"pageSize"];
    [mdict setValue:self.search.text forKey:@"name"];

  
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
        [ws.arrKeyValue1 removeAllObjects];
        [ws.arrKeyValue2 removeAllObjects];
        ws.arrPorCPro = responseObject[@"data"][@"lhList"];
        ws.arrDanHealth = responseObject[@"data"][@"jkwhList"];
        for (NSDictionary *dic in self.arrPorCPro) {
            [ws.arrKeyValue1 addObject:@{dic[@"categoryName"]:@"无"}];
        }
 
        for (NSDictionary *dic in self.arrDanHealth) {
            [ws.arrKeyValue2 addObject:@{dic[@"categoryName"]:@"无"}];
        }
        
        [self setViKonw];
        [self setViUnKonw];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

-(void)setViKonw{
    
    self.search.frame = CGRectMake(15, 10, WIDTH_ - 30, 36);
    self.search.layer.masksToBounds = YES;
    self.search.layer.cornerRadius = 7;
    [self.viKnow addSubview:self.search];
    
    if (!self.tvList) {
        self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, self.search.bottom + 5, WIDTH_, self.viKnow.height - self.search.bottom - 5)];
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
    vc.arrKeyValue1 = self.arrKeyValue1;
    vc.arrKeyValue2 = self.arrKeyValue2;
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
        WS(ws);
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        
        [mdict setValue:dic[@"categoryCode"] forKey:@"code"];
        self.code = dic[@"categoryCode"];
        self.section = (int)indexPath.section;
        self.row = (int)indexPath.row;
        [self POSTurl:GET_UNKNOWPARAMS_DETAILS parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            NSString *st = responseObject[@"data"][@"list"];
            ws.arrData = [self arrayWithJsonString:st];
            [ws.pickerView reloadAllComponents];
            ws.viSelect.hidden = NO;
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }else{
        ChemistryModel *model = _arrKnow[indexPath.row];
        ChemistryDetailVC *vc =[ChemistryDetailVC new];
        vc.ID = model.id;
        vc.name = model.nameCn;
        vc.molecularFormula = model.molecularFormula;
        vc.ename = model.nameEn;
        vc.cas = model.cas;
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

#pragma mark - pickerView数据源协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1; //拨盘数量
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrData.count;
}

#pragma mark - pickerView代理协议方法
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.arrData objectAtIndex:row][@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self selectWithName];
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
@end
