//
//  LogViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "LogViewController.h"
#import "TableBarViewController.h"
#import "LoginMedol.h"
#import "SVProgressHUD.h"
#import "BPush.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
@interface LogViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LogBtn;
@property (weak, nonatomic) IBOutlet UIView *Navview;
@property (weak, nonatomic) IBOutlet UILabel *Lab;
@property (nonatomic, strong) LoginMedol *login;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumBer;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(login:) name:@"logininfoList" object:nil];
    _login=[[LoginMedol alloc]init];
    
    _PassWord.secureTextEntry=YES;
    _PhoneNumBer.keyboardType=UIKeyboardTypeNumberPad;
    _PhoneNumBer.delegate=self;
    _LogBtn.backgroundColor=XN_COLOR_GREEN_MINT;
   _LogBtn.layer.cornerRadius=5;
    _LogBtn.layer.masksToBounds=YES;
    self.navigationController.navigationBarHidden=YES;
    _Navview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clcik:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//
//
//- (void)dealloc {
//    if (_mapView) {
//        _mapView = nil;
//    }
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    //    [super viewWillAppear:YES];
//    [_mapView viewWillAppear];
//   
//    _locService.delegate = self;
//    [_locService startUserLocationService];
//    _locService.distanceFilter = 200.0f;
//    _mapView.showsUserLocation = NO;
//    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
//    _mapView.showsUserLocation = YES;
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    //    [super viewWillDisappear:YES];
//    [_mapView viewWillDisappear];
//    
//    [_locService stopUserLocationService];
//    _mapView.showsUserLocation = NO;
//    _locService.delegate = nil;
//}
//-(void)startUserLocationService
//{
//   
//}
///**
// *在地图View停止定位后，会调用此函数
// *@param mapView 地图View
// */
//- (void)didStopLocatingUser
//{
//    NSLog(@"stop locate");
//}
//
//
////实现相关delegate 处理位置信息更新
////处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    //NSLog(@"heading is %@",userLocation.heading);
//}
///**
// *用户位置更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Btnclick:(UIButton *)sender
{
    if (_PhoneNumBer.text.length == 0 || _PassWord.text.length == 0) {
        //提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名，密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //添加行为
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
   if(_PhoneNumBer.text.length>11)
   {
       
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
       //添加行为
       UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
       [alertController addAction:action];
       [self presentViewController:alertController animated:YES completion:nil];
   }
    
    else
    {
        [_login obtainInfoList:_PhoneNumBer.text userPwd:_PassWord.text];
//        TableBarViewController *controller=[[TableBarViewController alloc]init];
//        [self.navigationController pushViewController:controller animated:YES];
        //        [SVProgressHUD showWithStatus:@"登录中" maskType:SVProgressHUDMaskTypeClear];
    }

    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 10)
        return NO; // return NO to not change text
    return YES;
}
-(void)login:(NSNotification *)bitice
{
    
    
//    NSLog(@"%@",bitice.userInfo[@"code"]);
//    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]) {
//        NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
//        if (ShareS.uid.length!=0) {
//            
//            [BPush registerDeviceToken:[defailts objectForKey:@"deviceToken"]];
//           NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/createTag";
//            NSDictionary *dic = @{@"id":ShareS.uid,@"channelId":[defailts objectForKey:@"deviceToken1"]};
//            AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
//            [manger POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
//                                    // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
//                    
//                                    // 网络错误
//                                    if (error) {
//                                        return ;
//                                    }
//                                    if (result) {
//                                        // 确认绑定成功
//                                        if ([result[@"error_code"]intValue]!=0) {
//                                            return;
//                                        }
//                                        // 获取channel_id
//                                        NSString *myChannel_id = [BPush getChannelId];
//                                        NSLog(@"==%@",myChannel_id);
//                                        //获取当前设备应用的tag列表
//                                        [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
//                                            if (result) {
//                                                NSLog(@"result ============== %@",result);
//                                            }
//                                        }];
//                                        [BPush setTag:[defailts objectForKey:@"deviceToken1"] withCompleteHandler:^(id result, NSError *error) {
//                                            if (result) {
//                                                NSLog(@"设置tag成功");
//                                            }
//                                        }];
//                                    }
//                                }];
//
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//            }];
//            

        
        
        
        
        TableBarViewController *controller=[[TableBarViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        
    //}
//}
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
