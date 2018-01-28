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
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查询";
    
    self.searchVi.frame = CGRectMake(0, 0, WIDTH_, 44);
    [self.view addSubview:self.searchVi];
    
    self.tbv.frame = CGRectMake(0, self.searchVi.bottom, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
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
        vi.backgroundColor = [UIColor whiteColor];
        
        self.typeBtn.frame = CGRectMake(13, 10, 100, 25);
        [vi addSubview:self.typeBtn];
        
        self.searchTfd.frame = CGRectMake(self.typeBtn.right + 10, 7, WIDTH_ - self.typeBtn.right - 40, 30);
        [vi addSubview:self.searchTfd];
        
        UIImageView * igv = [UIImageView new];
        igv.image = [UIImage getImageWithColor:[UIColor yellowColor] andSize:CGSizeMake(1, 1)];
        igv.frame = CGRectMake(WIDTH_ - 33, 10, 20, 24);
        [vi addSubview:igv];
        
        _searchVi = vi;
    }
    return _searchVi;
}

-(UIButton *)typeBtn {
    if (!_typeBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"标题" forState:UIControlStateNormal];
        _typeBtn = btn;
    }
    return _typeBtn;
}

-(UITextField *)searchTfd {
    if (!_searchTfd) {
        UITextField * tfd = [UITextField new];
        tfd.placeholder = @"请输入关键字";
        
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
