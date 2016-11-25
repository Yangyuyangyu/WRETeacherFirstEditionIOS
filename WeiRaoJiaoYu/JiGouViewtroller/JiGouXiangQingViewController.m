//
//  JiGouXiangQingViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/3.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "JiGouXiangQingViewController.h"
#import "JIGouTableViewCell.h"
#import "JiGouXiangQing2ViewController.h"
#import "KechengMedol.h"
#import "JiGouTableViewCell4.h"
#import "DataReauest.h"
#import "MapViewController.h"
#import "JIGOUXiangQing3ViewController.h"
@interface JiGouXiangQingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSArray *dataArry;
    NSString *join;
    NSDictionary *dataDic;
}
@property (weak, nonatomic) IBOutlet UILabel *TedianLab;
//位置
@property (weak, nonatomic) IBOutlet UILabel *ZIZhi;
//理念
@property (weak, nonatomic) IBOutlet UILabel *LaocaTionLab;
//简介
@property (weak, nonatomic) IBOutlet UILabel *JigouJianJie;
@property (weak, nonatomic) IBOutlet UIButton *JiaruBtn;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;

@property (weak, nonatomic) IBOutlet UIButton *Btn1;
@property (weak, nonatomic) IBOutlet UIButton *Btn2;
@property (weak, nonatomic) IBOutlet UIView *JiugouSmallView;
@property (weak, nonatomic) IBOutlet UILabel *NameLab1;
@property (weak, nonatomic) IBOutlet UIImageView *touXiangImgView;
@property (weak, nonatomic) IBOutlet UILabel *labbb1;
@property (weak, nonatomic) IBOutlet UILabel *labbb2;
//@property (weak, nonatomic) IBOutlet UILabel *ZhaungTaiLab;

@end

@implementation JiGouXiangQingViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (IBAction)ShengQingJiaru:(UIButton *)sender
{
    NSString *jigouid=[[NSUserDefaults standardUserDefaults]objectForKey:@"agencyid"];
    [KechengMedol ShenQingJiaruRequest:jigouid ID:ShareS.uid];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *jigouid=[[NSUserDefaults standardUserDefaults]objectForKey:@"agencyid"];
    NSLog(@"%@",jigouid);
    [KechengMedol JigouXiangQRequest:jigouid Tid:ShareS.uid];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userRefresh2:) name:@"modificationinfoList111" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userRefresh22:) name:@"modificationinfoList222" object:nil];
   
    // Do any additional setup after loading the view from its nib.
}
- (void)userRefresh22:(NSNotification *)bitcode
{
    NSLog(@"jjj%@",bitcode.userInfo);
    
     join=[[NSString alloc]init];
    dataArry=[[NSArray alloc]init];
    dataDic=[[NSDictionary alloc]init];
    NSDictionary *dic=[bitcode.userInfo objectForKey:@"data"];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
    [_touXiangImgView sd_setImageWithURL:[NSURL URLWithString:request.img] placeholderImage:nil];
    _NameLab1.text=request.name;
    _JigouJianJie.text=request.brief;
//    _LaocaTionLab.text=request.location;
//    _ZIZhi.text=request.qualification;
    _ZIZhi.text=request.location;
    _LaocaTionLab.text=request.feature;
    
//    _TedianLab.text=request.feature;
    join=request.joined;
    NSLog(@"%@",join);

    if ([join isEqual:@"-1"])
    {
        _FalutReason.text=nil;
        [_JiaruBtn setTitle:@"申请加入"forState:UIControlStateNormal];
        _JiaruBtn.userInteractionEnabled=YES;
    }
        
    if ([join isEqual:@"0"])
    {
        _FalutReason.text=nil;
        [_JiaruBtn setTitle:@"审核中....." forState:UIControlStateNormal];
        _JiaruBtn.userInteractionEnabled=NO;
        _JiaruBtn.backgroundColor=[UIColor grayColor];

        
    }
    
    if ([join isEqual:@"1"]) {
        _FalutReason.text=nil;
        [_JiaruBtn setTitle:@"你已加入该机构" forState:UIControlStateNormal];
        _JiaruBtn.userInteractionEnabled=NO;
        _JiaruBtn.backgroundColor=[UIColor grayColor];
    }
  if ([join isEqual:@"2"])
    {
        [_JiaruBtn setTitle:@"再次加入" forState:UIControlStateNormal];
        _FalutReason.text=request.refuse;
        _JiaruBtn.userInteractionEnabled=YES;
        _JiaruBtn.backgroundColor=[UIColor grayColor];
        
        
    }
    
    
    _JiaruBtn.layer.masksToBounds=YES;
    _JiaruBtn.layer.cornerRadius=5;
    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    [_labbb1 setBackgroundColor:XN_COLOR_GREEN_MINT];
    [_Btn1 setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
    _touXiangImgView.layer.masksToBounds=YES;
    _touXiangImgView.layer.cornerRadius=40;
    NSLog(@"%@",dataArry);
}
- (void)userRefresh2:(NSNotification *)bitcode
{
    NSLog(@"%@",[bitcode.userInfo objectForKey:@"code"]);
    if ([bitcode.userInfo[@"code"] isEqualToNumber:@0])
    {
        [_JiaruBtn setTitle:@"审核中....." forState:UIControlStateNormal];
        _JiaruBtn.userInteractionEnabled=NO;
        _JiaruBtn.backgroundColor=[UIColor grayColor];
    }
}

- (IBAction)Change:(UIButton *)sender {
    if (sender.tag==0)
    {
        NSString *jigouid=[[NSUserDefaults standardUserDefaults]objectForKey:@"agencyid"];
        NSLog(@"%@",jigouid);
        [KechengMedol JigouXiangQRequest:jigouid Tid:ShareS.uid];
        [_labbb1 setBackgroundColor:XN_COLOR_GREEN_MINT];
        [_labbb2 setBackgroundColor:[UIColor clearColor]];
        [_Btn1 setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_Btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [table removeFromSuperview];
    }
    else
    {

         [KechengMedol requsetWithShenTuan:^(NSArray *responseArr) {
             NSLog(@"%@",responseArr);
             dataArry=responseArr;
             table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _JiugouSmallView.bounds.size.height-30) style:UITableViewStylePlain];
             NSLog(@"%f",table.bounds.size.height);
             //table.backgroundColor=[UIColor redColor];
             
             [_JiugouSmallView addSubview:table];
             table.delegate=self;
             table.dataSource=self;
             table.rowHeight=80;
             [table registerNib:[UINib nibWithNibName:@"JiGouTableViewCell4" bundle:nil] forCellReuseIdentifier:@"cell1"];
             UIView *view = [UIView new];
             view.backgroundColor = [UIColor clearColor];
             [table setTableFooterView:view];


         }];
        [_labbb2 setBackgroundColor:XN_COLOR_GREEN_MINT];
        [_labbb1 setBackgroundColor:[UIColor clearColor]];
        [_Btn2 setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_Btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
    }
    
}
- (IBAction)DiangWei:(UIButton *)sender
{
    MapViewController *controller=[[MapViewController alloc]init];
//    controller.loati=ShareS.JiGouDetaildataMedol.latitude;
//    controller.longi=ShareS.JiGouDetaildataMedol.longitude;
    [self.navigationController pushViewController:controller animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArry.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JiGouTableViewCell4 *cell=[table dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
    NSLog(@"%d",request.HdID);
    NSString *GroupId=[NSString stringWithFormat:@"%d",request.HdID];
    [[NSUserDefaults standardUserDefaults]setObject:GroupId forKey:@"GroupId"];
    cell.NameLab.text=request.name;
    cell.Name1Lab.text=request.admins;
    cell.JIanJIeLab.text=request.brief;
    [cell.Touxiang sd_setImageWithURL:[NSURL URLWithString:request.img] placeholderImage:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",dataArry.count);
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
    NSLog(@"%d",request.HdID);
    NSString *GroupId=[NSString stringWithFormat:@"%d",request.HdID];
    [[NSUserDefaults standardUserDefaults]setObject:GroupId forKey:@"GroupId"];
    [KechengMedol requsetWithSheTuanDetail:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        NSDictionary *dic=[responseDic objectForKey:@"data"];
        NSArray *news=[dic objectForKey:@"news"];
        if (news.count==0)
        {
            JIGOUXiangQing3ViewController *controller=[[JIGOUXiangQing3ViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else{
            JiGouXiangQing2ViewController *controller=[[JiGouXiangQing2ViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];

        }
       
        
    }];


   
}
- (IBAction)FanHui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
