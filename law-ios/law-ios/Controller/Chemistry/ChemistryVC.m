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

@interface ChemistryVC ()<TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource,SelectedDelegate>
@property (nonatomic, strong ) UIView *viKnow;
@property (nonatomic, strong ) UIView *viUnKnow;
@property (nonatomic, strong ) UITextField *tfName;
@property (nonatomic, strong ) UIButton *btnSelect;
@property (nonatomic, strong ) UITableView *tvList;
@property (nonatomic, strong ) NSArray *arrPorCPro;
@property (nonatomic, strong ) NSArray *arrDanHealth;
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
    self.arrPorCPro = @[@"状态",@"颜色",@"气味",@"味道",@"比重(水=1)",@"比重(空气=1)",@"PH值",@"透明度"];
    self.arrDanHealth = @[@"味道",@"神经系统",@"眼",@"耳",@"嘴/喉咙",@"心血管",@"呼吸系统",@"胃/泌尿系统",@"皮肤"];
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
    [self setViUnKonw];
    
}

-(void)bindAction {
    WS(ws);
    [[self.btnSelect rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [ws.navigationController pushViewController:[ChemistryVC new] animated:YES];
    }];
}


-(void)setViKonw{
    self.tfName = [UITextField new];
    self.tfName.frame = CGRectMake(10, 10, WIDTH_ - 60, 30);
    self.tfName.placeholder = @" 请输入危化品名称进行搜索";
    self.tfName.layer.borderWidth = 0.5;
    self.tfName.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.viKnow addSubview:self.tfName];
    
    self.btnSelect = [UIButton new];
    self.btnSelect.frame = CGRectMake(self.tfName.right, 10, WIDTH_ - self.tfName.right, 30);
    [self.viKnow addSubview:self.btnSelect];
    
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, self.tfName.bottom + 5, WIDTH_, self.viKnow.height - self.tfName.bottom - 5)];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.viKnow addSubview:self.tvList];
}

-(void)setViUnKonw{
    UILabel *lb1 = [UILabel new];
    lb1.frame = CGRectMake(10, 0, 200, 30);
    lb1.text  = @"理化特征";
    lb1.textColor = [UIColor darkGrayColor];
    [self.viUnKnow addSubview:lb1];
    CGFloat y = lb1.bottom +5;
    CGFloat x = 0;
    for (NSString *st in _arrPorCPro) {
        UIButton *btn = [UIButton new];
        [btn setTitle:st forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y,WIDTH_/3 - 2, WIDTH_/8);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viUnKnow addSubview:btn];
        x = ([_arrPorCPro indexOfObject:st]+1)%3 *WIDTH_/3;
        if (([_arrPorCPro indexOfObject:st]+1)%3 == 0) {
            y = btn.bottom + 2;
        }
        
        if ([_arrPorCPro indexOfObject:st]+1 == _arrPorCPro.count) {
            y = btn.bottom + 2;
        }
    }
    
    UILabel *lb2 = [UILabel new];
    lb2.frame = CGRectMake(10, y, 200, 30);
    lb2.text  = @"健康危害";
    lb2.textColor = [UIColor darkGrayColor];
    [self.viUnKnow addSubview:lb2];
    y = lb2.bottom + 5;
    x= 0;
    
    for (NSString *st in _arrDanHealth) {
        UIButton *btn = [UIButton new];
        [btn setTitle:st forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y,WIDTH_/3 - 2, WIDTH_/8);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viUnKnow addSubview:btn];
        x = ([_arrDanHealth indexOfObject:st]+1)%3 *WIDTH_/3;
        if (([_arrDanHealth indexOfObject:st]+1)%3 == 0) {
            y = btn.bottom + 2;
        }
    }
    
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

-(void)chooseAction:(UIButton *)btn {
    ConditionChooseVC *vc = [ConditionChooseVC new];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"sss";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)select:(NSString *)st{
    
}
@end
