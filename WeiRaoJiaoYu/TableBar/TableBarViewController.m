//
//  TableBarViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "TableBarViewController.h"
#import "MyViewController.h"
#import "JiGouViewtroller.h"
#import "KeChengViewtroller.h"
#import "MainViewController.h"
#import "XiaoXiViewController.h"
@interface TableBarViewController ()

@end

@implementation TableBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"MainViewController"];
    UITabBarController *tbController = [[UITabBarController alloc] init];
    UIWindow *window=[UIApplication sharedApplication].delegate.window;
    window.rootViewController = tbController;
    
    //MainViewController *main=[[MainViewController alloc]init];
    JiGouViewtroller *inforVC = [[JiGouViewtroller alloc] init];
    KeChengViewtroller *homeVC = [[KeChengViewtroller alloc] init];
    MyViewController *myview=[[MyViewController alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveRemote) name:@"didReceiveRemoteNotification" object:nil];
    UINavigationController *mainVC=[[UINavigationController alloc]initWithRootViewController:main];
    UINavigationController *setNVC = [[UINavigationController alloc] initWithRootViewController:myview];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *infoNVC = [[UINavigationController alloc] initWithRootViewController:inforVC];
    setNVC.navigationBarHidden = YES;
    mainVC.navigationBarHidden=YES;
    homeNVC.navigationBarHidden = YES;
    infoNVC.navigationBarHidden = YES;
    
    
    tbController.viewControllers = @[homeNVC, infoNVC, mainVC,setNVC];
    tbController.tabBar.tintColor = XN_COLOR_GREEN_MINT;
    [tbController.tabBar setBarTintColor:[UIColor whiteColor]];
    //配置按钮
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"shaaa.png"] selectedImage:nil];
    
    UITabBarItem *inforItem = [[UITabBarItem alloc] initWithTitle:@"机构" image:[UIImage imageNamed:@"j2.png"] selectedImage:nil];
    
    UITabBarItem *setItem = [[UITabBarItem alloc] initWithTitle:@"课程表" image:[UIImage imageNamed:@"k3.png"] selectedImage:nil];
    UITabBarItem *mainItem=[[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"4.png"] selectedImage:nil];
    
    homeVC.tabBarItem = setItem;
    inforVC.tabBarItem = inforItem;
    mainVC.tabBarItem = homeItem;
    setNVC.tabBarItem=mainItem;
    
  
    
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveRemote{
     XiaoXiViewController*skipCtr = [[XiaoXiViewController alloc]init];
    [self.navigationController pushViewController:skipCtr animated:YES];
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
