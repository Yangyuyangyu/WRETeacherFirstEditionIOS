//
//  KechengXiangQingViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/5.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "KechengXiangQingViewController.h"
#import "JiGouXiangQingViewController.h"
#import "KechengMedol.h"
#import "AFNetworking.h"
#import "DataReauest.h"
#import "KechengShuoMiangTableViewCell.h"
#import "CommntTableViewCell.h"
#import "SVProgressHUD.h"
@interface KechengXiangQingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger Btnindex;
    NSArray *TypeArry;
    DataReauest *Request;
    UIWebView *web;
    CGFloat height;
    NSArray *comment;
    UIAlertView *alertview;
    
    //课程详情文本高度
    CGFloat height1;
    CGFloat height2;
    CGFloat height3;
    CGFloat height4;
}
@property (weak, nonatomic) IBOutlet UIImageView *BigImg;
@property (weak, nonatomic) IBOutlet UIButton *KeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *Kebtn2;
@property (weak, nonatomic) IBOutlet UILabel *Lab1;
@property (weak, nonatomic) IBOutlet UITableView *BigTableView;
@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UILabel *Keshu;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *JiGouName;
@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (weak, nonatomic) IBOutlet UIImageView *Teacherimg;
@property (weak, nonatomic) IBOutlet UILabel *TehearName;
@property (weak, nonatomic) IBOutlet UIButton *KechengExPlain;
@property (weak, nonatomic) IBOutlet UIButton *KechengDetail;
@property (weak, nonatomic) IBOutlet UIButton *KechengPingJia;
@property (weak, nonatomic) IBOutlet UILabel *KechengExpain;
@property (weak, nonatomic) IBOutlet UILabel *Kechengdetail;
@property (weak, nonatomic) IBOutlet UILabel *kechengpianhja;




@end

@implementation KechengXiangQingViewController
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    TypeArry=[[NSArray alloc]initWithObjects:@"试学人群",@"教学目标",@"退班规则",@"插班规则", nil];
    Btnindex=0;
    NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"kecid"];
    NSLog(@"%@",cid);
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    senssion.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/courseInfo?id=%@",cid];
    NSLog(@"%@",urlstr);
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_BigTableView registerNib:[UINib nibWithNibName:@"KechengShuoMiangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_BigTableView registerNib:[UINib nibWithNibName:@"CommntTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
        NSLog(@"课程详情结果%@",responseObject);
        NSDictionary *dataDic=[responseObject objectForKey:@"data"];
        comment=[dataDic objectForKey:@"comment"];
        NSDictionary *infoDic=[dataDic objectForKey:@"info"];
        Request=[[DataReauest alloc]initWithDictiory:infoDic];
        
        _Name.text=Request.fit_crowd;
        _Type.text=Request.name;
        if ([Request.course_num isEqual:@"0"])
        {
            _Keshu.text=@"";
        }
        else
        {
            _Keshu.text=Request.course_num;
        }
        
        
        _Address.text=Request.address;
        _JiGouName.text=Request.agency;
        
        NSDictionary *tInfo=[dataDic objectForKey:@"tInfo"];
        DataReauest *Request1=[[DataReauest alloc]initWithDictiory:tInfo];
        _TehearName.text=Request1.name;
        [_Teacherimg sd_setImageWithURL:[NSURL URLWithString:Request1.head] placeholderImage:nil];
        [_BigImg sd_setImageWithURL:[NSURL URLWithString:Request.img] placeholderImage:nil];
        _BigTableView.dataSource=self;
        _BigTableView.delegate=self;
        _BigTableView.tableHeaderView=_HeadView;
        self.tabBarController.tabBar.hidden=YES;
        _Lab1.backgroundColor=XN_COLOR_GREEN_MINT;
        [_KeBtn1 setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        _Teacherimg.layer.masksToBounds=YES;
        _Teacherimg.layer.cornerRadius=30;
        [_KechengExPlain setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        _KechengExpain.backgroundColor=XN_COLOR_GREEN_MINT;
        NSString *msg=[responseObject objectForKey:@"msg"];
        alertview=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [alertview show];
        //计算文字高度
        height1=[self heightForString:Request.fit_crowd fontSize:14 andWidth:WIDTH];
        height2=[self heightForString:Request.goal fontSize:14 andWidth:WIDTH];
        height3=[self heightForString:Request.quit_rule fontSize:14 andWidth:WIDTH];
        height4=[self heightForString:Request.join_rule fontSize:14 andWidth:WIDTH];
        
        
        [_BigTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"%@",error);
     }];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview dismissWithClickedButtonIndex:0 animated:NO];
    
}
- (IBAction)TianZhuang:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:Request.agency_id forKey:@"agencyid"];
    NSLog(@"%@",Request.agency_id);
    JiGouXiangQingViewController *controller=[[JiGouXiangQingViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)clcik:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"hahahahha %@",Request.quit_rule);
    if (Btnindex==0)
    {
        _BigTableView.contentSize=CGSizeMake(WIDTH, 800);
        if (indexPath.row==0)
        {
            KechengShuoMiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.TypeLab.text=[TypeArry objectAtIndex:indexPath.row];
            cell.MuBiaoRenQun.text=Request.fit_crowd;
            NSLog(@"%@",cell.MuBiaoRenQun.text);
            return cell;
        }
        if (indexPath.row==1)
        {
            KechengShuoMiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.TypeLab.text=[TypeArry objectAtIndex:indexPath.row];
            cell.MuBiaoRenQun.text=Request.goal;
            return cell;
        }
        if (indexPath.row==2)
        {
            KechengShuoMiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.TypeLab.text=[TypeArry objectAtIndex:indexPath.row];
            cell.MuBiaoRenQun.text=Request.quit_rule;
            return cell;
        }
        else
        {
            KechengShuoMiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.TypeLab.text=[TypeArry objectAtIndex:indexPath.row];
            cell.MuBiaoRenQun.text=Request.join_rule;
            return cell;
        }
        
    }
    if (Btnindex==1)
    {
        _BigTableView.contentSize=CGSizeMake(WIDTH, _HeadView.bounds.size.height+height);
        NSString *cellid=@"cell1";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        if (cell==nil) {
            cell=[tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
            
        }
        
        return cell;
        
    }
    else
    {
        if ([comment isKindOfClass:[NSNull class]])
        {
            _BigTableView.contentSize=CGSizeMake(WIDTH, 20);
            NSString *idetif=@"cell5";
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetif];
            if (cell==nil) {
                cell=[tableView dequeueReusableCellWithIdentifier:idetif forIndexPath:indexPath];
                
            }
            
            return cell;
        }
        
        else
        {_BigTableView.contentSize=CGSizeMake(WIDTH, 350*comment.count);
            NSDictionary *comentDic=[comment objectAtIndex:indexPath.row];
            DataReauest *comentRequest=[[DataReauest alloc]initWithDictiory:comentDic];
            CommntTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
            cell.Namelab.text=comentRequest.user_name;
            cell.TouXiang.layer.masksToBounds=YES;
            cell.TouXiang.layer.cornerRadius=40;
            [cell.TouXiang sd_setImageWithURL:[NSURL URLWithString:comentRequest.user_img] placeholderImage:[UIImage imageNamed:@"head.png"]];
            cell.Timelab.text=comentRequest.time;
            cell.CommentLab.text=comentRequest.content;
            return cell;
            
            
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Btnindex==0)
    {
        return 4;
    }
    if (Btnindex==2)
    {
        if ([comment isKindOfClass:[NSNull class]])
        {
            [SVProgressHUD showErrorWithStatus:@"暂无数据"];
            
            return 1;
            
        }
        else
        {
            NSLog(@"comment.count %lu",(unsigned long)comment.count);
            return comment.count;
        }
        
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (Btnindex==0){
        if (indexPath.row==0){
            return 30+height1;
        }else if(indexPath.row==1){
            return 30+height2;
        }else if(indexPath.row==2){
            return 30+height3;
        }else if(indexPath.row==3){
            return 30+height4;
        }
    }
    
    if (Btnindex==2)
    {
        return 90;
    }
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)Fahui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (IBAction)Change:(UIButton *)sender
{
    Btnindex=sender.tag;
    if (sender.tag==0)
    {
        [web removeFromSuperview];
        [_KechengExPlain setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        
        _KechengExpain.backgroundColor=XN_COLOR_GREEN_MINT;
        
        [_KechengDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Kechengdetail setBackgroundColor:[UIColor clearColor]];
        
        [_KechengPingJia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_kechengpianhja setBackgroundColor:[UIColor clearColor]];
        [_BigTableView reloadData];
    }
    if (sender.tag==1)
    {
        
        web=[[UIWebView alloc]init];
        height = [[web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        web.frame=CGRectMake(0, _HeadView.bounds.size.height, WIDTH, height);
        
        NSURL *url = [NSURL URLWithString:Baseurl];
        
        [web loadHTMLString:Request.detail baseURL:url];
        [_BigTableView  addSubview:web];
        [_KechengExPlain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _KechengExpain.backgroundColor=[UIColor clearColor];
        
        [_KechengDetail setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_Kechengdetail setBackgroundColor:XN_COLOR_GREEN_MINT];
        
        [_KechengPingJia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_kechengpianhja setBackgroundColor:[UIColor clearColor]];
        [_BigTableView reloadData];
    }
    if (sender.tag==2)
    {
        [web removeFromSuperview];
        [_KechengExPlain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _KechengExpain.backgroundColor=[UIColor clearColor];
        
        [_KechengDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Kechengdetail setBackgroundColor:[UIColor clearColor]];
        
        [_KechengPingJia setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_kechengpianhja setBackgroundColor:XN_COLOR_GREEN_MINT];
        
        [_BigTableView reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//计算文字高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
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
