//
//  ChengGuoViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/20.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "ChengGuoViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
@interface ChengGuoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (weak, nonatomic) IBOutlet UIView *NavIew;
@end

@implementation ChengGuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _NavIew.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Tijiao:(UIButton *)sender {
    
    if (_TextView.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入您的成果"];
    }
    else
    {
        AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
        NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/editShare";
        NSDictionary *dic=@{@"content":_TextView.text,@"id":ShareS.uid};
        [session POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"教育经历的结果%@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            //[self performSelector:@selector(dismissq) withObject:nil afterDelay:0.5];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }

//    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    //[self performSelector:@selector(dismissq) withObject:nil afterDelay:0.5];
//    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)Btnclcik:(UIButton *)sender {
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
