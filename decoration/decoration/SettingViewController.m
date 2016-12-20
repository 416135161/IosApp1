//
//  SettingViewController.m
//  decoration
//
//  Created by 林 建军 on 07/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "SettingViewController.h"
#import "SSCheckBoxView.h"
#import "DaoDefines.h"
#import "Precompile.h"
#import "UPDao+UserTime.h"
#import "ListViewController.h"
#import "UIColor+XTExtension.h"
#import "UPDao+Phone.h"
#import "TKAlertCenter.h"
@interface SettingViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)IBOutlet UIView *firstView;
@property(nonatomic,strong)IBOutlet UIView *twoView;
@property(nonatomic,strong)IBOutlet UIView *threeView;
@property(nonatomic,strong)IBOutlet UIView *fourView;
@property(nonatomic,strong)IBOutlet UIView *fiveView;


@property(nonatomic,strong)IBOutlet UIButton *oneBtn;
@property(nonatomic,strong)IBOutlet UIButton *twoBtn;
@property(nonatomic,strong)IBOutlet UIButton *threeBtn;
@property(nonatomic,strong)IBOutlet UIButton *fourBtn;
@property(nonatomic,strong)IBOutlet UIButton *fiveBtn;

@property(nonatomic,strong) UIView *backgroundView;

@property(nonatomic,strong) UIPickerView *datePicker;

@property(nonatomic,strong) NSMutableArray *proTitleList;

@property(nonatomic,strong) NSMutableArray *proTimeList;


@property(nonatomic,strong) NSString *mlabel;

@property(nonatomic,strong) NSString *slabel;


@property(nonatomic,strong) UIButton *currentBtn;

@property(nonatomic,strong) UITextField *phoneText;

@property(nonatomic,strong) UITextField *rephoneText;


@property(nonatomic,strong) UIView *settingView;

@property(nonatomic,strong) UIView *abackgroundView;


@property(nonatomic,strong)IBOutlet UIButton *sendBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTimteBtn];
    [self initCheckBox];
    _backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    
    _abackgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    
    _abackgroundView.backgroundColor = [UIColor blackColor];
    _abackgroundView.alpha = 0.4;
    _sendBtn.hidden = YES;
    
    _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,  ScreenHight - 216, ScreenWidth,  216)];
    
    _datePicker.showsSelectionIndicator=YES;
    _datePicker.dataSource = self;
    _datePicker.delegate = self;
    _datePicker.hidden = YES;
    _backgroundView.hidden = YES;
      _abackgroundView.hidden = YES;
    
    _proTimeList = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < 60; i++) {
        if(i < 10){
            [_proTimeList addObject:[NSString stringWithFormat:@"0%ld",(long)i]];
        
        }else{
           [_proTimeList addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        
        }
        
    }
       _proTitleList = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < 24; i++) {
        if(i < 10){
            [_proTitleList addObject:[NSString stringWithFormat:@"0%ld",(long)i]];
            
        }else{
            [_proTitleList addObject:[NSString stringWithFormat:@"%ld",(long)i]];
            
        }
        
    }
    
    
    
    _datePicker.backgroundColor = [UIColor whiteColor];
    
    _backgroundView.userInteractionEnabled = YES;
      _abackgroundView.userInteractionEnabled = YES;
    
   // _backgroundView.hidden = YES;
   // _datePicker.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDateChoose)];
    _backgroundView.userInteractionEnabled = YES;
    [_backgroundView addGestureRecognizer:tap];
    
    [self.view addSubview:_backgroundView];
    
   // UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ahideDateChoose)];
   // _abackgroundView.userInteractionEnabled = YES;
   // [_abackgroundView addGestureRecognizer:atap];
    
    [self.view addSubview:_abackgroundView];
    
    [self.view addSubview:_datePicker];
    
    NSArray *ds =   [[UPDao sharedInstance] getCitysa:@""];
    
    if ([ds count] != 5) {
         [[UPDao sharedInstance] deleteAllCitya];
        
        UserTime *a = [[UserTime alloc] init];
        
        a.ID = @"99901";
        a.name = @"08:30";
        a.isOn = @"off";
        
        [[UPDao sharedInstance] createCitys:a];
        
        
        
        
        UserTime *b= [[UserTime alloc] init];
        
        b.ID = @"99902";
        b.name = @"13:00";
        b.isOn = @"off";
        
        [[UPDao sharedInstance] createCitys:b];
        
        
        
        
        UserTime *c= [[UserTime alloc] init];
        
        c.ID = @"99903";
        c.name = @"18:45";
        c.isOn = @"off";
        
        [[UPDao sharedInstance] createCitys:c];
        
        
        
        UserTime *d= [[UserTime alloc] init];
        
        d.ID = @"99904";
        d.name = @"18:45";
        d.isOn = @"off";
        
        [[UPDao sharedInstance] createCitys:d];

        
        
        UserTime *e= [[UserTime alloc] init];
        
        e.ID = @"99905";
        e.name = @"08:00";
        e.isOn = @"off";
        
        [[UPDao sharedInstance] createCitys:e];
    }
    
  
    
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
    
    titleLabel.text = @"汇报手机号码";
    
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
    
    NSArray *phones = [[UPDao sharedInstance] getPhones];
    
    if ([phones count] >0) {
        _sendBtn.hidden = NO;
    }
    
    
}


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
    phone.type = @"1";
    
    [[UPDao sharedInstance] deletePhone];
    
    [[UPDao sharedInstance] createPhone:phone];
     _sendBtn.hidden = NO;
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    NSArray *newds =   [[UPDao sharedInstance] getCitysa:@""];
    
    for (UserTime *user in newds) {
        UIButton *btn = (UIButton *)[self.view viewWithTag: [user.ID integerValue]];
        [btn setTitle:user.name forState:UIControlStateNormal];
        NSInteger index = [user.ID integerValue];
        
        
        if(![user.isOn isEqualToString:@"off"]){
            
            switch (index) {
                case 99901:{
                    _oneBtn.selected = YES;
                    
                    //10001,周日，周末，每天
                    if([user.isOn isEqualToString:@"周日"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 10001];
                        abtn.selected = YES;
                    
                    }else if([user.isOn isEqualToString:@"周末"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 10002];
                        abtn.selected = YES;
                    }else if([user.isOn isEqualToString:@"每天"]){
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 10003];
                        abtn.selected = YES;
                        
                    }
                    
                }
                    
                    break;
                    
                case 99902:{
                    _twoBtn.selected = YES;
                    
                    if([user.isOn isEqualToString:@"周日"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 20001];
                        abtn.selected = YES;
                        
                    }else if([user.isOn isEqualToString:@"周末"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 20002];
                        abtn.selected = YES;
                    }else if([user.isOn isEqualToString:@"每天"]){
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 20003];
                        abtn.selected = YES;
                        
                    }

                    
                }
                    
                    break;
                    
                case 99903:{
                    _threeBtn.selected = YES;
                    
                    if([user.isOn isEqualToString:@"周日"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 30001];
                        abtn.selected = YES;
                        
                    }else if([user.isOn isEqualToString:@"周末"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 30002];
                        abtn.selected = YES;
                    }else if([user.isOn isEqualToString:@"每天"]){
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 30003];
                        abtn.selected = YES;
                        
                    }

                    
                }
                    
                    break;
                case 99904:{
                    _fourBtn.selected = YES;
                    
                    if([user.isOn isEqualToString:@"周日"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 40001];
                        abtn.selected = YES;
                        
                    }else if([user.isOn isEqualToString:@"周末"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 40002];
                        abtn.selected = YES;
                    }else if([user.isOn isEqualToString:@"每天"]){
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 40003];
                        abtn.selected = YES;
                        
                    }

                    
                }
                    
                    break;
                case 99905:{
                    _fiveBtn.selected = YES;
                    
                    if([user.isOn isEqualToString:@"周日"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 50001];
                        abtn.selected = YES;
                        
                    }else if([user.isOn isEqualToString:@"周末"]){
                        
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 50002];
                        abtn.selected = YES;
                    }else if([user.isOn isEqualToString:@"每天"]){
                        UIButton *abtn = (UIButton *)[self.view viewWithTag: 50003];
                        abtn.selected = YES;
                        
                    }

                    
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
        
    }
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0){
     return [_proTitleList count];
    }
    else
    return [_proTimeList count];
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return ScreenWidth / 2;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *proNameStr = [_proTitleList objectAtIndex:row];
       // NSLog(@"nameStr=%@",_proNameStr);
        _mlabel = proNameStr;
    } else {
       NSString  *proTimeStr = [_proTimeList objectAtIndex:row];
       // NSLog(@"_proTimeStr=%@",_proTimeStr);
        _slabel = proTimeStr;
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{  if (component == 0) {
        return [_proTitleList objectAtIndex:row];
    } else {
        return [_proTimeList objectAtIndex:row];
        
    }
}


-(void)hideDateChoose{
    _backgroundView.hidden = YES;
    _datePicker.hidden = YES;
    [_currentBtn setTitle:[NSString stringWithFormat:@"%@:%@",_mlabel,_slabel] forState:UIControlStateNormal];
    
    UserTime *userTime = [[UPDao sharedInstance] getUserTime:[NSString stringWithFormat:@"%ld",_currentBtn.tag ]];
    
    userTime.name = [NSString stringWithFormat:@"%@:%@",_mlabel,_slabel];
    
    
    NSArray *ds = [[UPDao sharedInstance] getCitysa:@""];
    
    for ( UserTime *user in ds) {
        
        if(![user.isOn isEqualToString:@"off"]){
        
            [self cancelLocalNotificationWithKey:user.name];
        }
    }
    
    
    [[UPDao sharedInstance] updateUserTime:userTime];
    
    
    
    NSArray *newds = [[UPDao sharedInstance] getCitysa:@""];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];

    
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *strDate =[formatter1 stringFromDate:[NSDate date]];
    
    strDate = [strDate substringToIndex:10];
   
    
    for ( UserTime *newuser in newds) {
        
        if(![newuser.isOn isEqualToString:@"off"]){
           NSString *newdatea=  [NSString stringWithFormat:@"%@ %@:00",strDate,newuser.name];
            
            NSDate *g = [formatter1 dateFromString:newdatea];
            
            [self registerLocalNotification:[g timeIntervalSinceNow] notificationWithKey:newuser.name];
        }
    }

}


// 设置本地通知
-(void)registerLocalNotification:(NSInteger)alertTime notificationWithKey:(NSString *)key{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    
    
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
   // notification.repeatCalendar
    
    // 通知内容
    notification.alertBody =  @"该扫描签到了，谢谢合作";
   // notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = @"6.caf";
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"该扫描签到了，谢谢合作" forKey:key];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;  
            }  
        }  
    }  
}



-(void)ahideDateChoose{
    _abackgroundView.hidden = YES;
    _settingView.hidden = YES;
    [_phoneText resignFirstResponder];
    [_rephoneText resignFirstResponder];
    _phoneText.text = @"";
    _rephoneText.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initCheckBox{
   

}

-(void)statusChang:(SSCheckBoxView *)v{



}

-(void)initTimteBtn{
    
    for(NSInteger i = 99901;i< 99906;i++){
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.userInteractionEnabled = YES;
        [btn addTarget:self action:@selector(timeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
-(void)timeBtnAction:(id)btn{
    
    UIButton *button = (UIButton *) btn;
    
    switch (button.tag) {
        case 99901:
            
            break;
        case 99902:
            
            break;
        case 99903:
            
            break;
        case 99904:
            
            break;
        case 99905:
            
            break;
            
        default:
            break;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBack:(id)sender {
    [ self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resettingPhone:(id)sender {
    
    _abackgroundView.hidden = NO;
    _settingView.hidden = NO;
    
    NSArray *phones = [[UPDao sharedInstance] getPhones];
    
    if ([phones count] > 0) {
        
        Phone *phone = [phones objectAtIndex:0];
        
        _phoneText.text = phone.phoneName;
        
        _rephoneText.text = phone.phoneName;
    }
    
    
    
    
}

- (IBAction)sendReport:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ListViewController *controller = [board instantiateViewControllerWithIdentifier:@"ListViewController"];
    [ self.navigationController pushViewController:controller animated:YES];
    
    
}

- (IBAction)updatStatus:(id)sender {
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    
    [self cancelStaus];
    
    if(!btn.selected){
        if (btn.tag == 10009) {
            UIButton *a = [_firstView viewWithTag:10001];
            a.selected = NO;
            
            UIButton *b = [_firstView viewWithTag:10002];
            b.selected = NO;
            
            UIButton *c = [_firstView viewWithTag:10003];
            c.selected = NO;
            
            UserTime *user = [[UPDao sharedInstance] getUserTime:@"99901"];
            
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
            
            
        }else if (btn.tag == 20009) {
            
            UIButton *a = [_twoView viewWithTag:20001];
            a.selected = NO;
            
            UIButton *b = [_twoView viewWithTag:20002];
            b.selected = NO;
            
            UIButton *c = [_twoView viewWithTag:20003];
            c.selected = NO;
            
            UserTime *user = [[UPDao sharedInstance] getUserTime:@"99902"];
            
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
            
        }else if (btn.tag == 30009) {
            UIButton *a = [_threeView viewWithTag:30001];
            a.selected = NO;
            
            UIButton *b = [_threeView viewWithTag:30002];
            b.selected = NO;
            
            UIButton *c = [_threeView viewWithTag:30003];
            c.selected = NO;
            UserTime *user = [[UPDao sharedInstance] getUserTime:@"99903"];
            
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
            
        }else if (btn.tag == 40009) {
            UIButton *a = [_fourView viewWithTag:40001];
            a.selected = NO;
            
            UIButton *b = [_fourView viewWithTag:40002];
            b.selected = NO;
            
            UIButton *c = [_fourView viewWithTag:40003];
            c.selected = NO;
            
            UserTime *user = [[UPDao sharedInstance] getUserTime:@"99904"];
            
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
            
        }else if (btn.tag == 50009) {
            UIButton *a = [_fiveView viewWithTag:50001];
            a.selected = NO;
            
            UIButton *b = [_fiveView viewWithTag:50002];
            b.selected = NO;
            
            UIButton *c = [_fiveView viewWithTag:50003];
            c.selected = NO;
            
            UserTime *user = [[UPDao sharedInstance] getUserTime:@"99905"];
            
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
            
        }

    
    }
    
    [self daveStatus];
    
}

- (IBAction)aupdatStatus:(id)sender {
    
    UIButton *btn = sender;
    //btn.selected = !btn.selected;
    
    [self cancelStaus];
   
    
   if (btn.tag == 10001 || btn.tag == 10002 || btn.tag == 10003) {
       
       if(!_oneBtn.selected)return;
       UIButton *a = [_firstView viewWithTag:10001];
       
       
       UIButton *b = [_firstView viewWithTag:10002];
       
       
       UIButton *c = [_firstView viewWithTag:10003];
       
       
       if(btn.tag == 10001){

           b.selected = NO;
           c.selected = NO;
       
       }else  if(btn.tag == 10002){
           
           a.selected = NO;
          
           c.selected = NO;
           
       }else  if(btn.tag == 10003){
           a.selected = NO;
           b.selected = NO;
          
       }
       
       btn.selected = !btn.selected;
       //99901
       
       UserTime *user = [[UPDao sharedInstance] getUserTime:@"99901"];
       
       if(btn.selected){
           user.isOn = btn.titleLabel.text;
           [[UPDao sharedInstance] updateUserTime:user];
       }else{
           user.isOn = @"off";
           [[UPDao sharedInstance] updateUserTime:user];
       }
       
    }else if (btn.tag == 20001 || btn.tag == 20002 || btn.tag == 20003) {
        
        if(!_twoBtn.selected)return;
        UIButton *a = [_twoView viewWithTag:20001];
       // a.selected = NO;
        
        UIButton *b = [_twoView viewWithTag:20002];
       // b.selected = NO;
        
        UIButton *c = [_twoView viewWithTag:20003];
        //c.selected = NO;
        
        if(btn.tag == 20001){
            
            b.selected = NO;
            c.selected = NO;
            
        }else  if(btn.tag == 20002){
            
            a.selected = NO;
            
            c.selected = NO;
            
        }else  if(btn.tag == 20003){
            a.selected = NO;
            b.selected = NO;
            
        }
        
        btn.selected = !btn.selected;
        
        UserTime *user = [[UPDao sharedInstance] getUserTime:@"99902"];
        
        if(btn.selected){
            user.isOn = btn.titleLabel.text;
            [[UPDao sharedInstance] updateUserTime:user];
        }else{
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
        }
        
    }else if (btn.tag == 30001 || btn.tag == 30002 || btn.tag == 30003) {
        
        if(!_threeBtn.selected)return;
        UIButton *a = [_threeView viewWithTag:30001];
        //a.selected = NO;
        
        UIButton *b = [_threeView viewWithTag:30002];
       // b.selected = NO;
        
        UIButton *c = [_threeView viewWithTag:30003];
        //c.selected = NO;
        if(btn.tag == 30001){
            
            b.selected = NO;
            c.selected = NO;
            
        }else  if(btn.tag == 30002){
            
            a.selected = NO;
            
            c.selected = NO;
            
        }else  if(btn.tag == 30003){
            a.selected = NO;
            b.selected = NO;
            
        }
        btn.selected = !btn.selected;
        
        UserTime *user = [[UPDao sharedInstance] getUserTime:@"99903"];
        
        if(btn.selected){
            user.isOn = btn.titleLabel.text;
            [[UPDao sharedInstance] updateUserTime:user];
        }else{
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
        }
        
    }else if (btn.tag == 40001 || btn.tag == 40002 || btn.tag == 40003) {
        
        if(!_fourBtn.selected)return;
        UIButton *a = [_fourView viewWithTag:40001];
        //a.selected = NO;
        
        UIButton *b = [_fourView viewWithTag:40002];
       // b.selected = NO;
        
        UIButton *c = [_fourView viewWithTag:40003];
       // c.selected = NO;
        
        if(btn.tag == 40001){
            
            b.selected = NO;
            c.selected = NO;
            
        }else  if(btn.tag == 40002){
            
            a.selected = NO;
            
            c.selected = NO;
            
        }else  if(btn.tag == 40003){
            a.selected = NO;
            b.selected = NO;
            
        }
        
        btn.selected = !btn.selected;
        
        UserTime *user = [[UPDao sharedInstance] getUserTime:@"99904"];
        
        if(btn.selected){
            user.isOn = btn.titleLabel.text;
            [[UPDao sharedInstance] updateUserTime:user];
        }else{
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
        }
        
    }else if (btn.tag == 50001 || btn.tag == 50002 || btn.tag == 50003) {
        
        if(!_fiveBtn.selected)return;
        UIButton *a = [_fiveView viewWithTag:50001];
       // a.selected = NO;
        
        UIButton *b = [_fiveView viewWithTag:50002];
        //b.selected = NO;
        
        UIButton *c = [_fiveView viewWithTag:50003];
       // c.selected = NO;
        
        if(btn.tag == 50001){
            
            b.selected = NO;
            c.selected = NO;
            
        }else  if(btn.tag == 50002){
            
            a.selected = NO;
            
            c.selected = NO;
            
        }else  if(btn.tag == 50003){
            a.selected = NO;
            b.selected = NO;
            
        }
        
        btn.selected = !btn.selected;
        
        UserTime *user = [[UPDao sharedInstance] getUserTime:@"99905"];
        
        if(btn.selected){
            user.isOn = btn.titleLabel.text;
            [[UPDao sharedInstance] updateUserTime:user];
        }else{
            user.isOn = @"off";
            [[UPDao sharedInstance] updateUserTime:user];
        }
        
    }
    [self daveStatus];
   
    
}

-(void)cancelStaus{

    NSArray *ds = [[UPDao sharedInstance] getCitysa:@""];
    
    for ( UserTime *user in ds) {
        
        if(![user.isOn isEqualToString:@"off"]){
            
            [self cancelLocalNotificationWithKey:user.name];
        }
    }
    

}

-(void)daveStatus{
    
    
    NSArray *newds = [[UPDao sharedInstance] getCitysa:@""];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    
    
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *strDate =[formatter1 stringFromDate:[NSDate date]];
    
    strDate = [strDate substringToIndex:10];
    
    
    for ( UserTime *newuser in newds) {
        
        if(![newuser.isOn isEqualToString:@"off"]){
            NSString *newdatea=  [NSString stringWithFormat:@"%@ %@:00",strDate,newuser.name];
            
            NSDate *g = [formatter1 dateFromString:newdatea];
            
            [self registerLocalNotification:[g timeIntervalSinceNow] notificationWithKey:newuser.name];
        }
    }


}
- (IBAction)upateTime:(id)sender {
    
    _currentBtn = sender;
    _backgroundView.hidden = NO;
    
    [UIView animateWithDuration:1 animations:^{
         _datePicker.hidden = NO;
    }];

}

@end
