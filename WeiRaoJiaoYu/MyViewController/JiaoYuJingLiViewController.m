//
//  JiaoYuJingLiViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/5.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "JiaoYuJingLiViewController.h"
#import "KechengMedol.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
@interface JiaoYuJingLiViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (weak, nonatomic) IBOutlet UIView *Naview;

@end

@implementation JiaoYuJingLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (void)KaiShiShangke22222
{
    
}
- (IBAction)FanhuiBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)TiJiao:(UIButton *)sender
{
    if (_TextView.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"教育经历不能为空"];
    }
    else
    {
        AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
        NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editEdu";
        NSDictionary *dic=@{@"content":_TextView.text,@"id":ShareS.uid};
        [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"教育经历的结果%@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            //[self performSelector:@selector(dismissq) withObject:nil afterDelay:0.5];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    

    //[KechengMedol JiaoyuJIngli:_TextView.text Uid:ShareS.uid];
    //[SVProgressHUD showErrorWithStatus:@"修改成功" maskType:SVProgressHUDMaskTypeClear];
   

}
//- (void)dismissq
//{
//    [SVProgressHUD dismiss];
//}
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
