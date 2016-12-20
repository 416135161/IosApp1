//
//  SuccessViewController.m
//  decoration
//
//  Created by 林 建军 on 05/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController ()
   

@end

@implementation SuccessViewController
    @synthesize datas;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descLabel.text = datas;
}
- (IBAction)goBack:(id)sender {
   [ self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
