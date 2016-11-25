//
//  RegisterViewcontroller.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/29.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "RegisterViewcontroller.h"
#import "RegisterMedol.h"
#import "CManager.h"
#import "BdingPhoneModel.h"
#import "SVProgressHUD.h"
#import "LogViewController.h"
#import "ViewController.h"
#import "AgreementController.h"
@interface RegisterViewcontroller ()
@property (weak, nonatomic) IBOutlet UITextField *PhonenNmber;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UITextField *YanZhengMa;
@property (nonatomic, strong)RegisterMedol *reg;
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UIButton *YanZhengMabtn;
@property (nonatomic, strong)BdingPhoneModel *bding;
@property (weak, nonatomic) IBOutlet UIButton *ZhuCeBtn;
@property (weak, nonatomic) IBOutlet UIButton *tick;

@property (nonatomic, assign) BOOL isAgreed;
@end

@implementation RegisterViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _bding = [[BdingPhoneModel alloc] init];
      _reg = [[RegisterMedol alloc] init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"reginfoList" object:nil];
    self.navigationController.navigationBarHidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    _ZhuCeBtn.backgroundColor=XN_COLOR_GREEN_MINT;
    _ZhuCeBtn.layer.masksToBounds=YES;
    _ZhuCeBtn.layer.cornerRadius=10;
    _PhonenNmber.keyboardType = UIKeyboardTypeNumberPad;
    _YanZhengMa.keyboardType=UIKeyboardTypeNumberPad;
    _PassWord.secureTextEntry=YES;
    _YanZhengMabtn.backgroundColor=XN_COLOR_GREEN_MINT;
    _YanZhengMabtn.layer.masksToBounds=YES;
    _YanZhengMabtn.layer.cornerRadius=5;
    // Do any additional setup after loading the view from its nib.
}
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GetMa:(UIButton *)sender
{if ([CManager validateMobile:_PhonenNmber.text]&&_PhonenNmber.text.length==11) {
    __block int timeout = 120;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.enabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            //            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.titleLabel.font = [UIFont systemFontOfSize:14];
                [sender setTitle:[NSString stringWithFormat:@"%@秒再次获取",strTime] forState:UIControlStateNormal];
                sender.enabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
    sender.enabled = NO;
   
    [_bding verificationInfoListphone:_PhonenNmber.text];
}else {
    [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
}

    
}
- (void)tooltip:(NSString *)string {
    //提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:string preferredStyle:UIAlertControllerStyleAlert];
    //添加行为
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)Click:(UIButton *)sender
{
    if (_PhonenNmber.text.length == 0) {
        [self tooltip:@"密码不能为空"];
    }else if (_PassWord.text.length < 6 || _PassWord.text.length > 20){
        [self tooltip:@"密码必须大于6位小于20位"];
    }else {
        if ([CManager validateMobile:_PhonenNmber.text]){
            if (_isAgreed == YES) {
                [_reg obtainInfoList:_PhonenNmber.text UserPwd:_PassWord.text Code:_YanZhengMa.text];
            }else{
                [self tooltip:@"是否同意服务协议"];
            }
        }else{
            [self tooltip:@"电话号码格式不正确"];
        }
        

}
}
-(void)refresh:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@1]) {
        [self tooltip:@"用户已经存在"];
    }else if ([bitice.userInfo[@"code"] isEqualToNumber:@2]){
        [self tooltip:@"缺少必填项"];
    }else if ([bitice.userInfo[@"code"] isEqualToNumber:@3]){
        [self tooltip:@"密码不能为空"];
    }else if ([bitice.userInfo[@"code"] isEqualToNumber:@4]){
        [self tooltip:@"验证码不能为空"];
    }else if ([bitice.userInfo[@"code"] isEqualToNumber:@5]){
        [self tooltip:@"验证码不正确"];
    }else if ([bitice.userInfo[@"code"] isEqualToNumber:@0]){
        //提示框
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
//        //添加行为
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alertController addAction:action];
//        [self presentViewController:alertController animated:YES completion:nil];
        LogViewController *controller=[[LogViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}
//勾选
- (IBAction)tick:(UIButton *)sender {
    if (!_tick.selected) {
        _tick.selected = !_tick.selected;
        _isAgreed = YES;
    }else{
        _tick.selected = !_tick.selected;
        _isAgreed = NO;
    }
}
//声明
- (IBAction)statement:(UIButton *)sender {
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AgreementController * loginVC = [mainSB instantiateViewControllerWithIdentifier:@"AgreementController"];
    loginVC.isStatement = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
//协议
- (IBAction)negotiate:(UIButton *)sender {
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AgreementController * loginVC = [mainSB instantiateViewControllerWithIdentifier:@"AgreementController"];
    loginVC.isStatement = NO;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)FanHui:(UIButton *)sender
{
//    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController* main = [mainSB instantiateViewControllerWithIdentifier:@"ViewController"];
  
    
    //[self.navigationController popToViewController:main animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)YanZhengMa:(UITextField *)sender
{
    
}
@end
