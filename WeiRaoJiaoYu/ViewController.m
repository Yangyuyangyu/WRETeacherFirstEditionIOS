//
//  ViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/27.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "ViewController.h"
#import "LogViewController.h"
#import "RegisterViewcontroller.h"
#import "wanjiViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *LogBtn;
@property (weak, nonatomic) IBOutlet UIButton *logbtn1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBarHidden=YES;
    [_LogBtn setBackgroundColor:XN_COLOR_GREEN_MINT];
    _LogBtn.layer.masksToBounds=YES;
    _LogBtn.layer.cornerRadius=10;
    
    
    
    
    _logbtn1.layer.masksToBounds=YES;
    _logbtn1.layer.cornerRadius=10;
     _logbtn1.layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 204/255.0, 224/255.0, 191/255.0, 1 });
    [_logbtn1.layer setBorderColor:colorref];//边框颜色
    [_logbtn1 setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
    
    //[_logbtn1 setBackgroundColor:XN_COLOR_GREEN_MINT];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Wanjimima:(UIButton *)sender {
    wanjiViewController *log=[[wanjiViewController alloc]init];
//    UIWindow *windoww=[UIApplication sharedApplication].delegate.window;
//    UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:log];
//    windoww.rootViewController=av;
    [self.navigationController pushViewController:log animated:YES];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Click:(UIButton *)sender
{
    if (sender.tag==1)
    {
        NSLog(@"sssssss");
        LogViewController *log=[[LogViewController alloc]init];
//        UIWindow *windoww=[UIApplication sharedApplication].delegate.window;
//        UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:log];
//        windoww.rootViewController=av;
        [self.navigationController pushViewController:log animated:YES];
        
        
           }
    if (sender.tag==2)
    {
        RegisterViewcontroller *log=[[RegisterViewcontroller alloc]init];
//        UIWindow *windoww=[UIApplication sharedApplication].delegate.window;
//        UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:log];
//        windoww.rootViewController=av;
        [self.navigationController pushViewController:log animated:YES];
    }
    NSLog(@"ssadadasd %ld",(long)sender.tag);
}
@end
