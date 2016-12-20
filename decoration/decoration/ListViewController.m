//
//  ListViewController.m
//  decoration
//
//  Created by 林 建军 on 08/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "ListViewController.h"
#import "RecordTableViewCell.h"
#import "UPDao+City.h"
#import "DataModel.h"
#import "UPDao+Phone.h"
#import "DataModel.h"
#import "UIColor+XTExtension.h"
#import "TKAlertCenter.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *datas;

@property(nonatomic,strong) UIView *background;

@property(nonatomic,strong) UIActivityIndicatorView *indicator;


@property(nonatomic,strong)IBOutlet UITableView *tableView;



@property(nonatomic,strong) UITextField *phoneText;

@property(nonatomic,strong) UITextField *rephoneText;


@property(nonatomic,strong) UIView *settingView;

@property(nonatomic,strong) UIView *abackgroundView;
@end

@implementation ListViewController


-(void)saveAction{
    
    if([_phoneText.text length] == 0){
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"手机号码不能为空"];
        return;
    }
    
    
    if([_rephoneText.text length] == 0){
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"确认手机号码不能为空"];
        return;
    }
    
    if([_phoneText.text length] != 11){
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确的手机号码"];
        return;
    }
    
    if([_rephoneText.text length] != 11){
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"确认手机号码输入不正确"];
        return;
    }
    
    
    if(![_rephoneText.text  isEqualToString:_phoneText.text]){
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"两次输入手机号码不同"];
        return;
    }
    
    
    
    
    
    _abackgroundView.hidden = YES;
    _settingView.hidden = YES;
    [_phoneText resignFirstResponder];
    [_rephoneText resignFirstResponder];
    Phone *phone = [[Phone alloc] init];
    
    phone.phoneName = _phoneText.text;
    phone.type = @"2";
    
    [[UPDao sharedInstance] adeletePhone];
    
    [[UPDao sharedInstance] createPhone:phone];
   
    
}


-(void)ahideDateChoose{
    _abackgroundView.hidden = YES;
    _settingView.hidden = YES;
    [_phoneText resignFirstResponder];
    [_rephoneText resignFirstResponder];
    _phoneText.text = @"";
    _rephoneText.text = @"";
    
}


- (void)resettingPhone {
    
    _abackgroundView.hidden = NO;
    _settingView.hidden = NO;
    
    NSArray *phones = [[UPDao sharedInstance] getaPhones];
    
    if ([phones count] > 0) {
        
        Phone *phone = [phones objectAtIndex:0];
        
        _phoneText.text = phone.phoneName;
        
        _rephoneText.text = phone.phoneName;
    }
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
     _datas  = [[[UPDao alloc] init] getCitys:@""];
    _background = [[UIView alloc] initWithFrame:self.view.frame];
    _background.hidden = YES;
    _background.alpha = 0.5;
    _background.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_background];
    
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40) / 2, (self.view.frame.size.height - 40) / 2, 40, 40)];
    
    _indicator.backgroundColor = [UIColor colorWithString:@"#14A2EB"];
    _indicator.hidden = YES;
    
    [self.view addSubview:_indicator];
    // Do any additional setup after loading the view.
    
    
    
    _abackgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _abackgroundView.backgroundColor = [UIColor blackColor];
    _abackgroundView.alpha = 0.4;
     _abackgroundView.hidden = YES;
    
     [self.view addSubview:_abackgroundView];
    
    _settingView = [[UIView alloc] initWithFrame:CGRectMake( (ScreenWidth - 300) / 2,  (ScreenHight - 200) / 2 - 50, 300, 200)];
    _settingView.backgroundColor = [UIColor whiteColor];
    
    _settingView.layer.cornerRadius = 2.5;
    _settingView.hidden = YES;
    
    [self.view addSubview:_settingView];
    
    _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(12, 40, 276, 40)];
    
    _phoneText.placeholder = @"输入手机号码";
    
    [_settingView addSubview:_phoneText];
    
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    _rephoneText = [[UITextField alloc] initWithFrame:CGRectMake(12, 80, 276, 40)];
    
    _rephoneText.placeholder = @"重输手机号码";
    
    _rephoneText.keyboardType = UIKeyboardTypeNumberPad;
    
    [_settingView addSubview:_rephoneText];
    
    UIView *aline = [[UIView alloc] initWithFrame:CGRectMake(12, 81, 276, 1)];
    
    aline.backgroundColor = [UIColor colorWithString:@"#dedede"];
    [_settingView addSubview:aline];
    
    
    UIView *bline = [[UIView alloc] initWithFrame:CGRectMake(12, 121, 276, 1)];
    
    bline.backgroundColor = [UIColor colorWithString:@"#dedede"];
    
    [_settingView addSubview:bline];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 200, 30)];
    
    titleLabel.text = @"发送手机号码";
    
    [_settingView addSubview:titleLabel];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancelBtn.frame = CGRectMake(24, 130, 100, 44);
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    cancelBtn.backgroundColor = [UIColor colorWithString:@"#dedede"];
    
    cancelBtn.layer.cornerRadius = 2.5;
    [cancelBtn addTarget:self action:@selector(ahideDateChoose) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_settingView addSubview:cancelBtn];
    
    
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    sureBtn.frame = CGRectMake(168, 130, 100, 44);
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    sureBtn.backgroundColor = [UIColor colorWithString:@"#dedede"];
    
    sureBtn.layer.cornerRadius = 2.5;
    
    [sureBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_settingView addSubview:sureBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [ self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}




// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [_datas count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idewhy=@"RecordTableViewCell";
    
    RecordTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:idewhy];
    if (!cell) {
        cell=[[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idewhy];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row) + 1];
    City *city = [_datas objectAtIndex:indexPath.row];
    
    NSString *date = city.name;
   
    
     cell.dateLabel.text =  [date substringToIndex:([date length] - 4)];
    
     cell.groupLabel.text = city.groupName;
    
    return cell;
    
}

- (IBAction)sendData:(id)sender {
    
    
   NSMutableArray *aphones =  [ [[UPDao alloc] init] getaPhones ];
    
    if([aphones count] ==0){
        [self resettingPhone];
        return;
    }
    
    
    
    NSMutableDictionary *ms = [NSMutableDictionary dictionary];
    NSMutableArray *ds = [NSMutableArray array];
    
    if([_datas count] < 1){
        
          [[TKAlertCenter defaultCenter] postAlertWithMessage:@"暂时没有上传的数据"];
        return;
    }
    
    for (City *city in _datas) {
         NSMutableDictionary *data = [NSMutableDictionary dictionary];
         [data setObject:city.groupName forKey:@"tag"];
       
        
         [data setObject:[city.name substringToIndex: [city.name length] - 4 ] forKey:@"date"];
        [ds addObject:data];
        
    }
    
    
      [ms setObject:ds forKey:@"contents"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSDate *date = [NSDate date];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    
      [ms setObject:currentDateStr forKey:@"comdate"];
    
      Phone *phone =   [[[ [UPDao alloc] init] getPhones ] objectAtIndex:0];
    
      [ms setObject:phone.phoneName forKey:@"recivephone"];
    
      [ms setObject:@"13880744842" forKey:@"phone"];
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ms options:NSJSONWritingPrettyPrinted error:&parseError];
    
  NSString *as   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self showLoading];
    [[[DataModel alloc] init] add:@{@"data":as} success:^(id operation) {
        [self hideLoading];
          [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传成功！"];
     
        
    } failure:^(NSError *error) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败！"];

         [self hideLoading];
    }];
    
    
}

-(void)showLoading{
    _indicator.hidden = NO;
    _background.hidden = NO;
    [_indicator startAnimating];


}

-(void)hideLoading{
    _indicator.hidden = YES;
    _background.hidden = YES;


}
- (IBAction)deleteAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除确认?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
       
        
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _datas = [NSMutableArray array];
         [_tableView reloadData];
        [[[UPDao alloc] init] deleteAllCity];
        
        
       
         [[TKAlertCenter defaultCenter] postAlertWithMessage:@"删除成功！"];

        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    }
- (IBAction)searchAll:(id)sender {
    
     _datas  = [[[UPDao alloc] init] getCitys:@""];
    
    [_tableView reloadData];
}
- (IBAction)searchOneMonth:(id)sender {
    
     [_tableView reloadData];
}
- (IBAction)searchOneWeek:(id)sender {
    
     [_tableView reloadData];
}
- (IBAction)searchNow:(id)sender {
    
     [_tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
