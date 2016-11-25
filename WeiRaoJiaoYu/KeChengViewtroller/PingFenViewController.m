//
//  PingFenViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/7.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "PingFenViewController.h"
#import "AFNetworking.h"
#import "JiGouTableViewCell222.h"
#import "DataReauest.h"
#import "PingViewController1.h"
#import "SecoreViewController.h"
@interface PingFenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *studentArry;
    NSDictionary*courseInfoDic;
    UIAlertView *alertview111;
}
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UIView *NavIew;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;

@end

@implementation PingFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _NavIew.backgroundColor=XN_COLOR_GREEN_MINT;
    NSString *cid = _courseId;
    NSLog(@"%@",cid);
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    senssion.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/studentOfCourse?id=%@",cid];
    NSLog(@"%@",urlstr);
    
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"%@",responseObject);
        NSString *msg=[responseObject objectForKey:@"msg"];
        alertview111=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismissd:) userInfo:nil repeats:NO];
        [alertview111 show];
        
        NSDictionary *DataDic=[responseObject objectForKey:@"data"];
        courseInfoDic=[DataDic objectForKey:@"courseInfo"];
        studentArry=[DataDic objectForKey:@"student"];
        [_Tableview registerNib:[UINib nibWithNibName:@"JiGouTableViewCell222" bundle:nil] forCellReuseIdentifier:@"cell"];
        _Tableview.dataSource=self;
        _Tableview.delegate=self;
        [_Tableview reloadData];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_Tableview setTableFooterView:view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
         NSLog(@"%@",error);
     }];


    // Do any additional setup after loading the view from its nib.
}
- (void)performDismissd:(NSTimer *)timer
{
    [alertview111 dismissWithClickedButtonIndex:0 animated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *cid=_courseId;
    NSLog(@"%@",cid);
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    senssion.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/studentOfCourse?id=%@",cid];
    NSLog(@"%@",urlstr);
    
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         
         
         NSDictionary *DataDic=[responseObject objectForKey:@"data"];
         courseInfoDic=[DataDic objectForKey:@"courseInfo"];
         _NameLab.text = courseInfoDic[@"name"];
         studentArry=[DataDic objectForKey:@"student"];
         [_Tableview registerNib:[UINib nibWithNibName:@"JiGouTableViewCell222" bundle:nil] forCellReuseIdentifier:@"cell"];
         _Tableview.dataSource=self;
         _Tableview.delegate=self;
         [_Tableview reloadData];
         UIView *view = [UIView new];
         view.backgroundColor = [UIColor clearColor];
         [_Tableview setTableFooterView:view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
         NSLog(@"%@",error);
     }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return studentArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JiGouTableViewCell222 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=[studentArry objectAtIndex:indexPath.row];
    NSString *name=[dic objectForKey:@"name"];
    NSString *score=[dic objectForKey:@"score"];
    cell.Namelab.text=name;
    cell.SecoreLab.text=score;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//课程
    NSString *class_id=[courseInfoDic objectForKey:@"class_id"];
    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id"];
    NSString *name=[courseInfoDic objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
    NSString *Id=[courseInfoDic objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:Id forKey:@"courseid"];
    //学生
    NSDictionary *dic=[studentArry objectAtIndex:indexPath.row];
    NSString *ID=[dic objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:ID forKey:@"Studentid"];
    NSString *Studentname=[dic objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:Studentname forKey:@"studentname"];
    NSString *score=[dic objectForKey:@"score"];
    [[NSUserDefaults standardUserDefaults]setObject:score forKey:@"score"];
    NSString *score_id=[dic objectForKey:@"score_id"];
    [[NSUserDefaults standardUserDefaults]setObject:score_id forKey:@"score_id"];
    SecoreViewController *controller=[[SecoreViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Back:(UIButton *)sender
{
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
