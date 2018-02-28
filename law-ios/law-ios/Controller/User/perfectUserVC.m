//
//  perfectUserVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/3.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "perfectUserVC.h"
#import "UserHeadCell.h"
#import "UserPerfectCell.h"
#import "THScrollChooseView.h"
#import "RegisterVC.h"
#import "LXFPhotoHelper.h"
#import "BaseViewModel.h"

@interface perfectUserVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )UIButton *btnFinish;
@property (nonatomic, strong)UITextField * UserName;
@property (nonatomic, strong)UITextField * UserCardNum;
@property (nonatomic, strong)UITextField * Useremail;
@property (nonatomic, strong)UITextField * TfPhone;


@property (nonatomic,strong)THScrollChooseView * scrollChooseView;



@end

@implementation perfectUserVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Document_Type_%@",phone]]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"身份证" forKey:[NSString stringWithFormat:@"Document_Type_%@",phone]];
    }
    if(![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"男" forKey:[NSString stringWithFormat:@"gender_Type_%@",phone]];
    }
    if (self.un) {
        self.UserName.text = self.un;
    }
    if (self.uc) {
        self.UserCardNum.text = self.uc;
    }
    if (self.ue) {
        self.Useremail.text = self.ue;
    }
    if (self.Job) {
        [[NSUserDefaults standardUserDefaults]setObject:@{@"id":self.company_id,@"name":self.Job} forKey:[NSString stringWithFormat:@"companyList%@",phone]];
    }
    if (self.Bm) {
        [[NSUserDefaults standardUserDefaults]setObject:@{@"id":self.department_id,@"name":self.Bm} forKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]];
    }
    if (self.Zw) {
        [[NSUserDefaults standardUserDefaults]setObject:@{@"id":self.job_id,@"name":self.Zw} forKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]];
    }
    if (self.Szd) {
        [[NSUserDefaults standardUserDefaults]setObject:@{@"name":self.Szd} forKey:[NSString stringWithFormat:@"address%@",phone]];
    }
    

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView {
    self.title = @"补充个人信息";
    if (self.un){
        self.title = @"修改个人信息";
    }
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_ - 150) style:UITableViewStyleGrouped];
    if (self.uc) {
        self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_  - 64) style:UITableViewStyleGrouped];
    }
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.view addSubview:self.tvList];
    
    self.btnFinish = [[UIButton alloc]initWithFrame:CGRectMake(10, self.tvList.bottom + 15, WIDTH_ - 20, 50)];
    [self.btnFinish setBackgroundColor:BLUE];
    [self.btnFinish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFinish addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnFinish setTitle:@"完成注册" forState:UIControlStateNormal];
    [self.view addSubview:self.btnFinish];
    
    if (self.un) {
        self.btnRight.hidden = NO;
        [self.btnRight setTitleColor:BLUE forState:UIControlStateNormal];
        [self.btnRight setTitle:@"保存" forState:UIControlStateNormal];
    }
}

-(void)bindModel {
    self.arrData = @[@[@"头像",@"姓名",@"证件类型",@"证件号码",@"性别",@"邮箱"],@[@"工作单位",@"部门",@"职务",@"所在地"]];
    if (self.uc) {
         self.arrData = @[@[@"头像",@"姓名",@"证件类型",@"证件号码",@"性别",@"邮箱",@"电话"],@[@"工作单位",@"部门",@"职务",@"所在地"]];
    }
}

-(void)onRightAction {
    [self finishAction];
}

//完成注册
- (void)finishAction{
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:phone forKey:@"loginName"];
    [mdict setValue:@1 forKey:@"nickName"];
    [mdict setValue:self.UserName.text forKey:@"realName"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]] valueForKey:@"id"] forKey:@"departmentId"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]]valueForKey:@"id"] forKey:@"regionId"];
    [mdict setValue:self.Useremail.text forKey:@"email"];
    [mdict setValue:self.UserCardNum.text forKey:@"idNo"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]] valueForKey:@"id"] forKey:@"jobId"];
    [mdict setValue:phone forKey:@"phone"];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]] isEqualToString:@"男"]) {
        [mdict setValue:@1 forKey:@"sex"];
    }else {
        [mdict setValue:@0 forKey:@"sex"];
    }
    [mdict setValue:@1 forKey:@"userType"];
    [mdict setValue:@1 forKey:@"licenseType"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]] valueForKey:@"name"] forKey:@"commpanyName"];
    if ([self judgeIdentityStringValid:self.UserCardNum.text]) {
        [self POSTurl:REGIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                if (self.un) {
                    [[Toast shareToast]makeText:@"保存成功" aDuration:1];
                }
                
                [self onBackAction];
            }else{
                [[Toast shareToast]makeText:@"信息不完整" aDuration:1];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }else{
        [[Toast shareToast]makeText:@"身份证号不正确" aDuration:1];
        [SVProgressHUD dismiss];
    }
    
    
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.arrData.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.arrData[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Celled";
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserHeadCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"imgurl"]&&self.un) {
                cell.ivHead.layer.masksToBounds = YES;
                cell.ivHead.layer.cornerRadius = 22;
                NSString *urlString = [[NSUserDefaults standardUserDefaults] valueForKey:@"imgurl"];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
                UIImage *image = [UIImage imageWithData:data]; // 取得图片
                cell.ivHead.image = image;
            }
            return cell;
            
            
        }
        if (indexPath.row ==1||indexPath.row ==3||indexPath.row ==5) {
            UserPerfectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserPerfectCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row ==1) {
                if (self.UserName) {
                    cell.tfMessage.text = self.UserName.text;
                }else{
                    cell.tfMessage.text = self.un?self.un:@"";
                }
                self.UserName = cell.tfMessage;

            }
            if (indexPath.row ==3) {
                if (self.UserCardNum) {
                    cell.tfMessage.text = self.UserCardNum.text;
                }else{
                    cell.tfMessage.text = self.uc?self.uc:@"";
                }
                self.UserCardNum = cell.tfMessage;

            }
            if (indexPath.row ==5) {
                if (self.Useremail) {
                    cell.tfMessage.text = self.Useremail.text;
                }else{
                    cell.tfMessage.text = self.ue?self.ue:@"";
                }
                self.Useremail = cell.tfMessage;
                
            }
            
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.text = @"请选择";
            if (indexPath.section == 0 && indexPath.row == 2) {
                if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Document_Type_%@",phone]]) {
                    cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Document_Type_%@",phone]];
                }
            }
            if (indexPath.section == 0 && indexPath.row == 4) {
                if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]]) {
                    cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]];
}
            }
            if (indexPath.section == 0 &&indexPath.row == 6) {
                cell.detailTextLabel.text = self.phone?self.phone:@"请选择";
            }
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = @"请选择";
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]] valueForKey:@"name"]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]] valueForKey:@"name"];
        }
    }
    
    return cell;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.scrollChooseView) {
        [self.scrollChooseView removeFromSuperview];
        self.scrollChooseView = nil;
    }
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    WS(ws);
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        if (self.un) {
            // 创建UIAlertController
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"相册");
                [self getSourceWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"相机");
                [self getSourceWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            // 弹出
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        NSArray * arr = @[@"身份证"];
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:arr[selectedValue] forKey:[NSString stringWithFormat:@"Document_Type_%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        NSArray * arr = @[@"男",@"女"];
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:arr[selectedValue] forKey:[NSString stringWithFormat:@"gender_Type_%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {

        [SVProgressHUD showWithStatus:@"加载中..."];
        [self POSTurl:GET_COMPANY_LIST parameters:@{@"data":[self dictionaryToJson:@{}]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * companyList = [ws arrayWithJsonString:responseObject[@"data"][@"companyList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in companyList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:companyList[selectedValue] forKey:[NSString stringWithFormat:@"companyList%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]];
        if (!dict) {
            [[Toast shareToast]makeText:@"请选择工作单位" aDuration:2];
            return ;
        }
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:dict[@"id"] forKey:@"companyId"];
        [self POSTurl:GET_DEPARTMENT_LIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * departmentList = [ws arrayWithJsonString:responseObject[@"data"][@"departmentList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in departmentList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:departmentList[selectedValue] forKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [self POSTurl:GET_JOB_LIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * jobList = [ws arrayWithJsonString:responseObject[@"data"][@"jobList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in jobList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:jobList[selectedValue] forKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {

        NSArray * addressList = @[@{@"name":@"北京市东城区",
                                @"id":@"1"
                                }];
        NSMutableArray * arr = [NSMutableArray new];
        for (id obj in addressList) {
            [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
        }
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:addressList[selectedValue] forKey:[NSString stringWithFormat:@"address%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
    }
    
    if (indexPath.section == 0&&indexPath.row == 6) {
        RegisterVC *vc= [RegisterVC new];
        vc.st = @"修改手机号";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2 ;
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)getSourceWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    LXFPhotoConfig *config = [[LXFPhotoConfig alloc] init];
    config.navBarTintColor = [UIColor blackColor];
    config.navBarBgColor = [UIColor whiteColor];
    config.navBarTitleColor = BLUE;
    
    [[LXFPhotoHelper creatWithSourceType:sourceType config:config] getSourceWithSelectImageBlock:^(id data) {
        if ([data isKindOfClass:[UIImage class]]) { // 图片
//            [self.imageView setImage:(UIImage *)data];
            UIImage *img = (UIImage *)data;
            UIGraphicsBeginImageContext(CGSizeMake(300.0, img.size.height * 300.0 / img.size.width));
            [img drawInRect:CGRectMake(0, 0,300.0, img.size.height * 300.0/img.size.width)];
            UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [self uploadImg:scaledImage];
            
        } else {
            NSLog(@"所选内容非图片对象");
        }
    }];
}
-(void)uploadImg:(UIImage *)avatar{
  
    
    [self CommentPicWithDic:@{@"data":[self dictionaryToJson:@{@"userId":[[NSUserDefaults standardUserDefaults] valueForKey:@"login"]}]} withImages:@{@"avatar":avatar} success:^(NSDictionary *info) {
        NSString *st = info[@"data"][@"avatar"];
        NSDictionary *dic = [self arrayWithJsonString:st];
        NSString *imgurl = dic[@"path"];
        imgurl=[imgurl stringByReplacingOccurrencesOfString:@"\\"withString:@"/"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",BASE_URL,imgurl] forKey:@"imgurl"];
        [self.tvList reloadData];
        [[Toast shareToast]makeText:@"上传成功" aDuration:1];
    } faile:^(NSError *info) {
        
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
    }];
  
}

- (void)CommentPicWithDic:(NSDictionary *)dic//上传图片时可能有的附加条件如userid;
               withImages:(NSDictionary *)imageDic//存图片的字典
                  success:(void (^)(NSDictionary *))success
                    faile:(void (^)(NSError *))faile
{
    NSString *urlStr = Upload_Img;
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [Manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        for (id key in imageDic) {
            UIImage *image = [imageDic objectForKey:key];
            //FileData:图片压缩后的data类型
            //name: 后台规定的key
            //fileName:自己给文件起名
            //mimeType :图片类型
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
        }
    }success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        success(responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        faile(error);
    }];
}

- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

@end
