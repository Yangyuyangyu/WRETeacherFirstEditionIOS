//
//  SheZhiViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/5.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "SheZhiViewController.h"
#import "YiJIanFanKuiViewController.h"
#import "GuanyuwomenViewController.h"
#import "LogViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "ChangePasswordVC.h"
@interface SheZhiViewController ()<UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    NSString *phone;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UILabel *HuangCun;
@property (weak, nonatomic) IBOutlet UILabel *KeFuDianHuaLab;
@property (nonatomic, copy)NSString *tmpSize;
@property (weak, nonatomic) IBOutlet UIView *changePwd;

@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/aboutUs"];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"关于我们%@",responseObject);
        NSDictionary *datadic=[responseObject objectForKey:@"data"];
        phone=[datadic objectForKey:@"telephone"];
        _KeFuDianHuaLab.text=phone;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    self.tabBarController.tabBar.hidden=YES;
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    float size = tmpSize / 1024.0 / 1024.0;
    NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"%.2fM",size] : [NSString stringWithFormat:@"%.2fK",size * 1024];
    _HuangCun.text=clearCacheName;
    _tmpSize = clearCacheName;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePwdTap:)];
    [self.changePwd addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DaDianHUa:(UIButton *)sender
{
    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert1.tag=100;
    [alert1 show];
    
}
- (IBAction)ckear:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否清理缓存？" preferredStyle:UIAlertControllerStyleAlert];
    //添加行为
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    //添加行为
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SDImageCache sharedImageCache] clearDisk];
        float tmpSize = [[SDImageCache sharedImageCache] getSize];
        float size = tmpSize / 1024.0 / 1024.0;
        NSString *clearCacheName = size >= 1 ? [NSString stringWithFormat:@"%.2fM",size] : [NSString stringWithFormat:@"%.2fK",size * 1024];
        _HuangCun.text=clearCacheName;
    }];
    [alertController addAction:action1];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)womeng:(UIButton *)sender {
    GuanyuwomenViewController *controller=[[GuanyuwomenViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)TuiChuZahngHao:(UIButton *)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您将要退出账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=101;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==1)
        {
            NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
            [defailts removeObjectForKey:@"uId"];
            UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"ViewController"];
            UIWindow *windoww=[UIApplication sharedApplication].delegate.window;
            UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:main];
            windoww.rootViewController=av;
        }
    }
    else
    {
        if (buttonIndex==1)
        {
            NSString *phonenumber=phone;
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phonenumber]];
            NSLog(@"medl.phone  %@",phonenumber);
            [[UIApplication sharedApplication] openURL:url];
            NSLog(@"打电话的url  %@",url);
            
        }
    }
    
}
- (IBAction)YIJIanFanKui:(UIButton *)sender {
    YiJIanFanKuiViewController *contro=[[YiJIanFanKuiViewController alloc]init];
    [self.navigationController pushViewController:contro animated:YES];
    
}
- (IBAction)Fanhui:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return YES;
    
}

-(void)changePwdTap:(UITapGestureRecognizer *)sender{
    ChangePasswordVC *changeVC=[[ChangePasswordVC alloc] init];
    [self.navigationController pushViewController:changeVC animated:YES];
    
    
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
