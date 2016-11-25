//
//  wanjiViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/6.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "wanjiViewController.h"
#import "CManager.h"
#import "SVProgressHUD.h"
#import "RegisterMedol.h"
#import "BdingPhoneModel.h"
@interface wanjiViewController ()
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *YanZhengMa;
@property (weak, nonatomic) IBOutlet UIButton *YanZhengmaBtn;
@property (weak, nonatomic) IBOutlet UITextField *NewMa;
@property (weak, nonatomic) IBOutlet UIButton *Logbtn;
@property (weak, nonatomic) IBOutlet UITextField *MiMa;


@property (nonatomic, strong)RegisterMedol *reg;

@property (nonatomic, strong)BdingPhoneModel *bding;


@end

@implementation wanjiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _reg=[[RegisterMedol alloc]init];
    _bding=[[BdingPhoneModel alloc]init];
    self.navigationController.navigationBarHidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    _Logbtn.layer.masksToBounds=YES;
    _Logbtn.layer.cornerRadius=10;
    _Logbtn
    .layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 204/255.0, 224/255.0, 191/255.0, 1 });
    [_Logbtn.layer setBorderColor:colorref];//边框颜色
    [_Logbtn setBackgroundColor:XN_COLOR_GREEN_MINT];
    _PhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    _YanZhengMa.keyboardType = UIKeyboardTypeNumberPad;
    _NewMa.secureTextEntry=YES;
    _MiMa.secureTextEntry=YES;
    _YanZhengmaBtn.backgroundColor=XN_COLOR_GREEN_MINT;
    _YanZhengmaBtn.layer.masksToBounds=YES;
    _YanZhengmaBtn.layer.cornerRadius=5;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logbtn:(UIButton *)sender {
}
- (IBAction)YanZhengMa:(UIButton *)sender {
    if ([CManager validateMobile:_PhoneNumber.text]&&_PhoneNumber.text.length==11) {
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
        
        [_bding verificationInfoListphone1:_PhoneNumber.text];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }

    
    
}
- (IBAction)Clcik:(UIButton *)sender
{
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

@end
