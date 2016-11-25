//
//  TiJiaoBaoGaoViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "TiJiaoBaoGaoViewController.h"
#import "KechengMedol.h"
#import "AFNetworking.h"
@interface TiJiaoBaoGaoViewController ()
{
    BOOL a;
   
    NSMutableArray *IdArry;
    UIAlertView*alertview111;
}
@property (weak, nonatomic) IBOutlet UITextView *SloutionTextView;
@property (weak, nonatomic) IBOutlet UITextView *ProblemTextView;
@property (weak, nonatomic) IBOutlet UITextView *ContenTextView;
@property (weak, nonatomic) IBOutlet UITextView *ZuoYeTextview;
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UIButton *ZuoYebtn;

@property (weak, nonatomic) IBOutlet UIView *ZuoYeView;
@end

@implementation TiJiaoBaoGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IdArry=[[NSMutableArray alloc]init];
   
    self.tabBarController.tabBar.hidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)fanhui:(UIButton *)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)TiJiao:(UIButton *)sender
{
    
     NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
   // NSLog(@"%@",Id);
        AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
      NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/studentOfCourse?id=%@",cid];
    NSLog(@"%@",urlstr);
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        
        [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary*dataDic=[responseObject objectForKey:@"data"];
            NSArray *dataArry=[dataDic objectForKey:@"student"];
            for (int i=0; i<dataArry.count; i++)
            {
                NSDictionary *dic=[dataArry objectAtIndex:i];
//                NSString *name=[dic objectForKey:@"name"];
//                NSString *Id=[dic objectForKey:@"id"];
                NSString *score=[dic objectForKey:@"score"];
                [IdArry addObject:score];
            }
            if (IdArry.count!=0)
            {
                NSString *kong=@"";
                if ([IdArry containsObject:kong])
                {
                    alertview111=[[UIAlertView alloc]initWithTitle:nil message:@"你还有学生没有评分" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismissdd:) userInfo:nil repeats:NO];
                    [alertview111 show];

                }
                else
                {
                    if (a==YES)
                    {
                        if (_SloutionTextView.text==nil||_ProblemTextView.text==nil||_ContenTextView.text==nil||_ZuoYeTextview.text==nil)
                        {
                            alertview111=[[UIAlertView alloc]initWithTitle:nil message:@"请把记录填完整" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismissdd:) userInfo:nil repeats:NO];
                            [alertview111 show];
                        }
                        else
                        {
                             [KechengMedol TiJiaoBaoGaoRequest:cid Content:_ContenTextView.text Problem:_ProblemTextView.text Solution:_SloutionTextView.text Homwork:@"1" Work:@"" Img:@""];
                        }
                       
                    }
                    else{
                        if (_SloutionTextView.text==nil||_ProblemTextView.text==nil||_ContenTextView.text==nil) {
                            alertview111=[[UIAlertView alloc]initWithTitle:nil message:@"请把记录填完整" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismissdd:) userInfo:nil repeats:NO];
                            [alertview111 show];
                        }
                        else
                        {
                            [KechengMedol TiJiaoBaoGaoRequest:cid Content:_ContenTextView.text Problem:_ProblemTextView.text Solution:_SloutionTextView.text Homwork:@"0" Work:@""Img:@""];
                        }
                        
                    }
                    
                }

            }
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

        
    
}
- (void)performDismissdd:(NSTimer *)timer
{
     [alertview111 dismissWithClickedButtonIndex:0 animated:NO];
}



@end
