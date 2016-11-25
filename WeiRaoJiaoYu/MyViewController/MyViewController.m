//
//  MyViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "MyViewController.h"
#import "SheZhiViewController.h"
#import "JiaoYuJingLiViewController.h"
#import "PeasonViewController.h"
#import "ChengGuoViewController.h"
#import "XiaoXiViewController.h"
@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UILabel *Namelabb;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabb;
@property (weak, nonatomic) IBOutlet UIImageView *Imgviewa;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Namelabb.text=ShareS.name;
    _PhoneLabb.text=ShareS.phone;
    _Imgviewa.layer.masksToBounds=YES;
    _Imgviewa.layer.cornerRadius=40;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_Imgviewa sd_setImageWithURL:[NSURL URLWithString:ShareS.headImgUrl] placeholderImage:nil];
    self.tabBarController.tabBar.hidden=NO;
    _Namelabb.text=ShareS.name;
    _PhoneLabb.text=ShareS.phone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Change:(UIButton *)sender
{
    if (sender.tag==3)
    {
        self.hidesBottomBarWhenPushed = YES;
        SheZhiViewController *shezhi=[[SheZhiViewController alloc]init];
        [self.navigationController pushViewController:shezhi animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (sender.tag==1)
    {
        self.hidesBottomBarWhenPushed = YES;
        JiaoYuJingLiViewController *contro=[[JiaoYuJingLiViewController alloc]init];
        [self.navigationController pushViewController:contro animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (sender.tag==0)
    {
        self.hidesBottomBarWhenPushed = YES;
        PeasonViewController *person=[[PeasonViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (sender.tag==2)
    {
        self.hidesBottomBarWhenPushed = YES;
        ChengGuoViewController *controller=[[ChengGuoViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (IBAction)XiaoXiBtn:(UIButton *)sender {
    XiaoXiViewController *xiaoxi=[[XiaoXiViewController alloc]init];
    [self.navigationController pushViewController:xiaoxi animated:YES];
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
