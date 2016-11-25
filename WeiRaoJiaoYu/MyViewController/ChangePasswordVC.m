//
//  ChangePasswordVC.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/9/26.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "ViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

@interface ChangePasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *nowPassword;
@property (weak, nonatomic) IBOutlet UITextField *nowAgainPassword;


@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarController.tabBar.hidden=YES;
    //点击ruturn回收键盘
    _oldPassword.delegate=self;
    _nowPassword.delegate=self;
    _nowAgainPassword.delegate=self;
    //空白回收键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
    [self.view addGestureRecognizer:singleTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)oKAction:(id)sender {
    if (_oldPassword.text.length==0||_nowPassword.text.length==0||_nowAgainPassword.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"用户密码不能为空"];
    }else if (![_nowPassword.text isEqualToString:_nowAgainPassword.text]){
        [SVProgressHUD showErrorWithStatus:@"新密码不相同"];
        
    }
    else
    {
        AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
        NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editPass";
        NSDictionary *dic=@{@"oldPass":_oldPassword.text,@"newPass":_nowAgainPassword.text,@"id":ShareS.uid};
        [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"修改密码%@",responseObject[@"code"]);
            int i=[responseObject[@"code"] intValue];
            switch (i) {
                case 0:
                {
                    NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
                    [defailts removeObjectForKey:@"uId"];
                    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"ViewController"];
                    UIWindow *windoww=[UIApplication sharedApplication].delegate.window;
                    UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:main];
                    windoww.rootViewController=av;
                }
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    break;
                    
                default:
                    [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
                    break;
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showSuccessWithStatus:@"网络错误,请稍后再试"];
        }];
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_oldPassword resignFirstResponder];
    [_nowPassword resignFirstResponder];
    [_nowAgainPassword resignFirstResponder];
    
    return YES;
}
-(void)closeKeyBoard:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
    
}

@end
