//
//  YiJIanFanKuiViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/5.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "YiJIanFanKuiViewController.h"
#import "SVProgressHUD.h"
@interface YiJIanFanKuiViewController ()
@property (weak, nonatomic) IBOutlet UIView *naview;

@end

@implementation YiJIanFanKuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naview.backgroundColor=XN_COLOR_GREEN_MINT;
    self.tabBarController.tabBar.hidden=YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Tijiao:(UIButton *)sender {
    [SVProgressHUD showInfoWithStatus:@"提交成功" maskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(dismissq) withObject:nil afterDelay:0.5];
    
}
- (void)dismissq
{
    [SVProgressHUD dismiss];
}


- (IBAction)FanHui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
