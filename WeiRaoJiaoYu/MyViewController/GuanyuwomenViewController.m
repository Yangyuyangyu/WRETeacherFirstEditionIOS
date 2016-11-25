//
//  GuanyuwomenViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/5.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "GuanyuwomenViewController.h"
#import "AFNetworking.h"
@interface GuanyuwomenViewController ()
{
    NSString *phone;
}


@end

@implementation GuanyuwomenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _NAVIEW.backgroundColor=XN_COLOR_GREEN_MINT;
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/aboutUs"];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"关于我们%@",responseObject);
        NSDictionary *datadic=[responseObject objectForKey:@"data"];
        phone=[datadic objectForKey:@"telephone"];
        _PhoneLab.text=phone;
        NSString *detail=[datadic objectForKey:@"detail"];
        
//        height = [[_Web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//        web.frame=CGRectMake(0, _HeadView.bounds.size.height, WIDTH, height);
        
        NSURL *url = [NSURL URLWithString:Baseurl];
        
        [_Web loadHTMLString:detail baseURL:url];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    self.tabBarController.tabBar.hidden=YES;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Fanhui:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)DaDianHua:(UIButton *)sender {
    NSString *phonenumber=phone;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phonenumber]];
    NSLog(@"medl.phone  %@",phonenumber);
    [[UIApplication sharedApplication] openURL:url];
    NSLog(@"打电话的url  %@",url);

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
