//
//  SecoreViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/8.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "SecoreViewController.h"
#import "MovieAddComment.h"
#import "AFHTTPSessionManager.h"
@interface SecoreViewController ()
{
  
    ///MovieAddComment *movie1;
    //MovieAddComment *movie2;
   // MovieAddComment *movie3;
    UIAlertView*alertview111;
    NSMutableArray *IdArry;
    NSMutableArray *ScoreArry;
     NSMutableArray *ViewArry;
}
@property (weak, nonatomic) IBOutlet UIButton *QueRenBtn;
@property (weak, nonatomic) IBOutlet UIButton *QuXiaoBtn;

@property (weak, nonatomic) IBOutlet UIView *NAVIEW;
@end

@implementation SecoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IdArry=[[NSMutableArray alloc]init];
    ScoreArry=[[NSMutableArray alloc]init];
    ViewArry=[[NSMutableArray alloc]init];
    self.tabBarController.tabBar.hidden=YES;
    _NAVIEW.backgroundColor=XN_COLOR_GREEN_MINT;
    [_QueRenBtn setBackgroundColor:XN_COLOR_GREEN_MINT];
    _QueRenBtn.layer.masksToBounds=YES;
    _QueRenBtn.layer.cornerRadius=10;
    _QuXiaoBtn.layer.masksToBounds=YES;
    _QuXiaoBtn.layer.cornerRadius=10;
    _QuXiaoBtn.layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 204/255.0, 224/255.0, 191/255.0, 1 });
    [_QuXiaoBtn.layer setBorderColor:colorref];//边框颜色
    [_QuXiaoBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *class_id=[[NSUserDefaults standardUserDefaults]objectForKey:@"class_id"];
    NSString *courseid=[[NSUserDefaults standardUserDefaults]objectForKey:@"courseid"];
    NSString *Studentid=[[NSUserDefaults standardUserDefaults]objectForKey:@"Studentid"];
    NSLog(@"%@%@",courseid,Studentid);
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/scoreItem?class_id=%@&studentId=%@",class_id,Studentid];
    NSLog(@"%@",urlstr);
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    
    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dataArry=[responseObject objectForKey:@"data"];
        for (int i=0; i<dataArry.count; i++)
        {
            NSDictionary *dic=[dataArry objectAtIndex:i];
            NSString *name=[dic objectForKey:@"name"];
            NSString *Id=[dic objectForKey:@"id"];
            NSString *score=[dic objectForKey:@"score"];
            MovieAddComment *movie = [[MovieAddComment alloc] initWithFrame:CGRectMake(0, 80*i+64+10,WIDTH, 80)];
             float Score=[score floatValue];
             movie.tag=100+i;
            [ViewArry addObject:movie];
            movie.namelab.text=name;
            movie.ID=Id;
            movie.ScoreLab.text=score;
        [self.view addSubview:movie];
        [self PingFenCount:Score Tag:movie.tag];

            [IdArry addObject:Id];
           
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
-(void)PingFenCount:(float)score Tag:(NSInteger)tag
{
    if (score==0)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarUnSelect"];
    }
    if (score==0.5)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelectHeaf"];
    }
    if (score==1)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
    }
    if (score==1.5) {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelectHeaf"];
        
        
    }
    if (score==2)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
    }
    if (score==2.5) {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelectHeaf"];
        
    }
    if (score==3)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelected"];
    }
    if (score==3.5) {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star4.image=[UIImage imageNamed:@"StarSelectHeaf"];
    }
    if (score==4)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star4.image=[UIImage imageNamed:@"StarSelected"];
    }
    if (score==4.5)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star4.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star5.image=[UIImage imageNamed:@"StarSelectHeaf"];

    }
    if (score==5)
    {
        MovieAddComment *movie=[self.view viewWithTag:tag];
        movie.img_star1.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star2.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star3.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star4.image=[UIImage imageNamed:@"StarSelected"];
        movie.img_star5.image=[UIImage imageNamed:@"StarSelected"];

    }
}
- (IBAction)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)QueRen:(UIButton *)sender
{
    NSLog(@"%@",IdArry);
   NSString *str=[[NSString alloc]init];
    for (int i=0; i<IdArry.count; i++)
    {        if (i==IdArry.count-1)
        {
             NSString *str1=[IdArry objectAtIndex:i];
            str=[str stringByAppendingString:str1];
        }
        else
        {
            
            NSString *str1=[IdArry objectAtIndex:i];
            NSString *str3=@",";
            NSString *str2=[NSString stringWithFormat:@"%@%@",str1,str3];
            str=[str stringByAppendingString:str2];

        }
    }
    
    float Score = 0.0;
    for (MovieAddComment *moveView in ViewArry)
    {
        NSLog(@"%@",moveView.ScoreLab.text);
         [ScoreArry addObject:moveView.ScoreLab.text];
       float score=[moveView.ScoreLab.text floatValue];
        Score=(score+Score)/2;
    }
   
    NSString *scorestr=[[NSString alloc]init];
    for (int i=0; i<ScoreArry.count; i++)
    {
    if (i==ScoreArry.count-1)
    {
        NSString *scorestr1=[ScoreArry objectAtIndex:i];
        scorestr=[scorestr stringByAppendingString:scorestr1];
    }
    else
    {
        
        NSString *str1=[ScoreArry objectAtIndex:i];
        NSString *str3=@",";
        NSString *str2=[NSString stringWithFormat:@"%@%@",str1,str3];
        scorestr=[scorestr stringByAppendingString:str2];
        
    }
    }
     NSString *class_id=[[NSUserDefaults standardUserDefaults]objectForKey:@"class_id"];
    NSString *Studentid=[[NSUserDefaults standardUserDefaults]objectForKey:@"Studentid"];
    NSLog(@"%@",ScoreArry);
    NSLog(@"%@",str);
    NSLog(@"%@",scorestr);
    NSLog(@"%.2f",Score);
    NSLog(@"%@",Studentid);
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/saveScore?studentId=%@&classId=%@&item=%@&score=%@",Studentid,class_id,str,scorestr];
    NSLog(@"%@",urlstr);
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
   [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"%@",responseObject);
       NSString *str=[responseObject objectForKey:@"msg"];
           alertview111=[[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
           [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
           [alertview111 show];
       [self.navigationController popViewControllerAnimated:YES];
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
   }];

//
//    NSLog(@"%@",movie.ScoreLab.text);
//    NSLog(@"%@",movie1.ScoreLab.text);
}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview111 dismissWithClickedButtonIndex:0 animated:NO];
    
}
- (IBAction)QuXiao:(UIButton *)sender {
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
