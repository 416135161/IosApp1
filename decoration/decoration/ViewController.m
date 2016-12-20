//
//  ViewController.m
//  decoration
//
//  Created by 林 建军 on 03/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "ViewController.h"
#import "SuccessViewController.h"
#import "SearchViewController.h"
#import "City.h"
#import "UPDao+City.h"
#import "SettingViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property(nonatomic,strong) NSString *oldGroupName;

@property(nonatomic) NSInteger atotal;

@property(nonatomic) NSInteger currentPage;
@property(nonatomic) NSInteger acurrentPage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [ self preferredStatusBarStyle ];
    self.readerDelegate = self;
    
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *ascanner = self.scanner;
    
    [ascanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    _oldGroupName = nil;
    _atotal = 0;
    _currentPage = 0;
    _acurrentPage = 0;
   
    
}

    
- (void) imagePickerController: (UIImagePickerController*) reader
     didFinishPickingMediaWithInfo: (NSDictionary*) info{
        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
        ZBarSymbol *symbol = nil;
        for(symbol in results)
        break;
        NSString *data = symbol.data;
      NSString *dString =  [self deCode:data];
    
    if([dString containsString:@"##"]){
        
        
        if([dString containsString:@"*"]){
            if(!_oldGroupName){
                //设置
                _resultLabel.text = @"失败!请按编号顺序重新扫描！";
                return;
            }
             NSArray *ds = [dString componentsSeparatedByString:@"##"];
            
            NSInteger count = [ds count];
            
            NSArray *ads = [dString componentsSeparatedByString:@"*"];
            
            NSInteger acount = [ds count];
            
            if(acount == 3){
                NSString *sandata = [ads objectAtIndex:1];
                NSArray *newds = [sandata componentsSeparatedByString:@"/"];
                NSString *newString = [newds objectAtIndex:1];
                //有群组的
                if ([newString length] > 1) {
                    NSString *groupString = [newString substringFromIndex:1];
                    
                    NSString *aString = [newds objectAtIndex:0];
                    NSString *bString = [newString substringToIndex:1];
                    
                    if(_acurrentPage + 1 != _atotal){
                        _resultLabel.text =  [NSString stringWithFormat:@"请按顺序扫描第%@张！",@(_acurrentPage + 1)];
                        return;
                    
                    }
                    
                 
                        
                        if([groupString isEqualToString:_oldGroupName] && [bString integerValue] == _atotal){
                            
                            UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
                             _resultLabel.text =  [NSString stringWithFormat:@"共%@张全部扫描成功！",bString];
                            [self saveDatas:image setDesc:[ds objectAtIndex:0] setTag:groupString];
                        
                        //tiaozhuan
                        }
                      
                        
                        
                        
                    
                    
                }else{
                    //没有分组
                    
                    NSString *sandata = [ads objectAtIndex:1];
                    NSArray *newds = [sandata componentsSeparatedByString:@"/"];
                    
                    NSString *aString = [newds objectAtIndex:0];
                    NSString *bString =  [newds objectAtIndex:1];
                    
                    if(_acurrentPage + 1  != _atotal){
                        _resultLabel.text =  [NSString stringWithFormat:@"请按顺序扫描第%@张！",@(_acurrentPage + 1)];
                        return;
                        
                    }
                    

                    if([@"NO" isEqualToString:_oldGroupName] && [bString integerValue] == _atotal){
                        
                       
                       
                          _resultLabel.text =  [NSString stringWithFormat:@"共%@张全部扫描成功！",bString];
                        UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
                        
                        [self saveDatas:image setDesc:[ds objectAtIndex:0] setTag:@"-"];
                        
                    }

                    
                
                
                }
            
            }
        
        
        }else{
            NSArray *ds = [dString componentsSeparatedByString:@"##"];
            
           UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
              _resultLabel.text = @"恭喜扫描成功！";
            [self saveDatas:image setDesc:[ds objectAtIndex:0] setTag:@"-"];
        }
        
        
       

    }else{
       
        [self analyse:dString];
    
    
    }
    
    
    
}
-(void)saveDatas:(UIImage *)image setDesc:(NSString *) str setTag:(NSString *)tag{

    _oldGroupName = nil;
     _atotal = 0;
    _currentPage = 0;
    _acurrentPage = 0;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSString *path_sandox = NSHomeDirectory();
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSDate *date = [NSDate date];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
   
    NSString *name =  [NSString stringWithFormat:@"%@.png",currentDateStr];
    City *city = [[City alloc] init];
      city.name = name;
    city.groupName = tag;
    
   city.cityID =  [NSString stringWithFormat:@"%f",[date timeIntervalSince1970] ];
    
      [[[UPDao alloc] init] createCity:city];
    //NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/flower.png"];
    //设置一个图片的存储路径
    
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",currentDateStr]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SuccessViewController *scontroller = [board instantiateViewControllerWithIdentifier:@"SuccessViewController"];
    
    scontroller.datas =  str;
    [ self.navigationController pushViewController: scontroller animated:YES];

}

-(void)analyse:(NSString *)dString{

    NSArray *ds = [dString componentsSeparatedByString:@"*"];
    
    NSInteger count = [ds count];
    
    if(count == 3){
        NSString *sandata = [ds objectAtIndex:1];
        NSArray *newds = [sandata componentsSeparatedByString:@"/"];
        NSString *newString = [newds objectAtIndex:1];
        //有群组的
        if ([newString length] > 1) {
            NSString *groupString = [newString substringFromIndex:1];
            
            NSString *aString = [newds objectAtIndex:0];
            NSString *bString = [newString substringToIndex:1];
            
           if( _currentPage == [aString integerValue] )return;
            
           if( [aString integerValue] == 1){
               _oldGroupName = groupString;
               _resultLabel.text = [NSString stringWithFormat:@"第%@/%@扫描成功，请继续按顺序扫描！",aString,bString];
               _atotal = [bString integerValue];
               _currentPage  = 1;
               _acurrentPage = 1;
               
           }else{
              
              
               if([_oldGroupName isEqualToString:groupString] &&  (_currentPage + 1) == [aString integerValue]  &&  _atotal == [bString integerValue]){
                   _oldGroupName = groupString;
                   _resultLabel.text = [NSString stringWithFormat:@"第%@/%@扫描成功，请继续按顺序扫描！",aString,bString];
                   _atotal = [bString integerValue];
                    _currentPage = [aString integerValue] ;
                   _acurrentPage++;
               }
           
           }
            
            
        }else{
            //没有群组的
            NSString *sandata = [ds objectAtIndex:1];
            NSArray *newds = [sandata componentsSeparatedByString:@"/"];
            
            NSString *aString = [newds objectAtIndex:0];
            NSString *bString =  [newds objectAtIndex:1];
            
            if( _currentPage == [aString integerValue] )return;
            
            
            if( [aString integerValue] == 1){
               
                _resultLabel.text = [NSString stringWithFormat:@"第%@/%@扫描成功，请继续按顺序扫描！",aString,bString];
                _atotal = [bString integerValue];
                _currentPage  = 1;
                 _acurrentPage = 1;
                 _oldGroupName = @"NO";
            }else{
                
                if([_oldGroupName isEqualToString:@"NO"] &&  (_currentPage + 1) == [aString integerValue] &&  _atotal == [bString integerValue]){
                   _oldGroupName = @"NO";
                    _currentPage = [aString integerValue] ;
                    _acurrentPage++;
                    _resultLabel.text = [NSString stringWithFormat:@"第%@/%@扫描成功，请继续按顺序扫描！",aString,bString];
                    _atotal = [bString integerValue];
                }
                
            }
            
            
        }
        
        
        
    }


}

-(NSString *)deCode:(NSString *)data{
    
    if (!data || data.length < 4 || ![data containsString:@"*"]) {
        return nil;
        
    }else{
       NSArray * ds =    [data componentsSeparatedByString:@"*"];
        Byte offset = 0;
        Byte datag[[ds count] - 1];
        
        offset = [[ds lastObject] integerValue];
        
        for (int j = 0; j < [ds count] - 1; j++) {
            datag[j] = [[ds objectAtIndex:j] integerValue] - offset;
        }
        
        NSData *adata = [[NSData alloc] initWithBytes:datag length:[ds count] - 1];
        
        NSString *aString = [[NSString alloc]initWithData:adata encoding:NSUTF8StringEncoding];
        NSLog(@"%@",aString);
        
        return aString;
        
    }
    
    
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openLight:(id)sender {
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
         [self setCameraFlashMode:UIImagePickerControllerCameraFlashModeOn];
    }else{
        [self setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
    }
    
}

- (IBAction)goPics:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SearchViewController *controller = [board instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [ self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)goSetting:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SettingViewController *controller = [board instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [ self.navigationController pushViewController:controller animated:YES];

}

@end
