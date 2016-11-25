//
//  JIGOUXiangQing3ViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/24.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "JIGOUXiangQing3ViewController.h"
#import "KechengGuiHuaViewController.h"
#import "SheHuiGuanLizhiduViewController.h"
#import "SheTuanJianSheBiaoViewController.h"
#import "KechengMedol.h"
#import "DataReauest.h"
@interface JIGOUXiangQing3ViewController ()
{
    
        DataReauest *request;
        NSDictionary *Datadic;
    
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UILabel *XiaoxiLab;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
//简介
@property (weak, nonatomic) IBOutlet UILabel *GuanLiyuanLab;
//所属机构
@property (weak, nonatomic) IBOutlet UILabel *JianJIeLab;
//管理老师
@property (weak, nonatomic) IBOutlet UILabel *JiGouLab;

@end

@implementation JIGOUXiangQing3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    [KechengMedol requsetWithSheTuanDetail:^(NSDictionary *responseDic) {
        Datadic=[[NSDictionary alloc]init];
        NSLog(@"%@",responseDic);
        NSDictionary *DataDic=[responseDic objectForKey:@"data"];
        NSLog(@"%@",DataDic);
        request=[[DataReauest alloc]initWithDictiory:DataDic];
        _NameLab.text=request.name;
        _GuanLiyuanLab.text=request.brief;
        NSLog(@"%@",request.name);
        _JianJIeLab.text=request.agency_name;
        _JiGouLab.text=request.admins;
        NSArray *arr=[[NSArray alloc]init];
        arr=[Datadic objectForKey:@"news"];
        NSLog(@"%@",arr);
        NSLog(@"%@",request.news);
        
        
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)KechengGuiHua:(UIButton *)sender {
    SheHuiGuanLizhiduViewController *controlller=[[SheHuiGuanLizhiduViewController alloc]init];
    [self.navigationController pushViewController:controlller animated:YES];
}
- (IBAction)SheTUanJIansheZhen:(UIButton *)sender {
    SheTuanJianSheBiaoViewController *controller=[[SheTuanJianSheBiaoViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)SheTuanJIeshe:(UIButton *)sender {
    KechengGuiHuaViewController *controller=[[KechengGuiHuaViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)Btnclick:(UIButton *)sender {
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
