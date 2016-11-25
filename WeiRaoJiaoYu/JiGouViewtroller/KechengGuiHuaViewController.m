//
//  KechengGuiHuaViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "KechengGuiHuaViewController.h"
#import "KechengMedol.h"
#import "DataReauest.h"
@interface KechengGuiHuaViewController ()
{
    NSString *detail;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;

@end

@implementation KechengGuiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [KechengMedol requsetWithSheTuanKechengGuiHua:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        NSDictionary *dataDic=[responseDic objectForKey:@"data"];
       
        detail=[dataDic objectForKey:@"plan"];
        
        UIWebView *web=[[UIWebView alloc]init];
        CGFloat height = [[web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        web.frame=CGRectMake(0, _Naview.bounds.size.height, WIDTH, height - _Naview.bounds.size.height);
        
        NSURL *url = [NSURL URLWithString:Baseurl];
        
        [web loadHTMLString:detail baseURL:url];
        [self.view addSubview:web];
        

    }];
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)fahui:(UIButton *)sender {
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
