//
//  SheHuiGuanLizhiduViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "SheHuiGuanLizhiduViewController.h"
#import "KechengMedol.h"
@interface SheHuiGuanLizhiduViewController ()
{
    NSString *detail;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UILabel *NeiRongLab;
@property (weak, nonatomic) IBOutlet UIView *SmallView;

@end

@implementation SheHuiGuanLizhiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [KechengMedol requsetWithSheTuanguanli:^(NSDictionary *responseDic) {
        
        NSLog(@"%@",responseDic);
        NSDictionary *dataDic=[responseDic objectForKey:@"data"];
        NSString *time=[dataDic  objectForKey:@"time"];
        NSString *title=[dataDic objectForKey:@"title"];
        _TimeLab.text=time;
        _NeiRongLab.text=title;
        detail=[dataDic objectForKey:@"detail"];
        NSLog(@"%@",detail);
        UIWebView *web=[[UIWebView alloc]init];
        CGFloat height = [[web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        web.frame=CGRectMake(0, _Naview.bounds.size.height+_SmallView.bounds.size.height, WIDTH, height - _Naview.bounds.size.height - _SmallView.bounds.size.height);
        
        NSURL *url = [NSURL URLWithString:Baseurl];
        
        [web loadHTMLString:detail baseURL:url];
        [self.view addSubview:web];

    }];
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)click:(UIButton *)sender
{
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
