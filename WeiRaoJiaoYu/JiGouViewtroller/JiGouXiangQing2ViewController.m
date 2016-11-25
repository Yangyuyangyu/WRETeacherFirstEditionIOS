//
//  JiGouXiangQing2ViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/3.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "JiGouXiangQing2ViewController.h"
#import "JigouTableViewCell3.h"
#import "KechengGuiHuaViewController.h"
#import "SheHuiGuanLizhiduViewController.h"
#import "SheTuanJianSheBiaoViewController.h"
#import "KechengMedol.h"
#import "DataReauest.h"
@interface JiGouXiangQing2ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataReauest *request;
    NSDictionary *Datadic;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
//简介
@property (weak, nonatomic) IBOutlet UILabel *GuanyuanLab;
//所属机构
@property (weak, nonatomic) IBOutlet UILabel *BirfLab;
//管理老师
@property (weak, nonatomic) IBOutlet UILabel *JIgouLab;

@end

@implementation JiGouXiangQing2ViewController

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
        _GuanyuanLab.text=request.brief;
        NSLog(@"%@",request.name);
        _BirfLab.text= request.agency_name;
        _JIgouLab.text= request.admins;
        NSArray *arr=[[NSArray alloc]init];
        arr=[Datadic objectForKey:@"news"];
        NSLog(@"%@",arr);
        NSLog(@"%@",request.news);
        _Tableview.delegate=self;
        _Tableview.dataSource=self;
        _Tableview.rowHeight=100;
        [_Tableview registerNib:[UINib nibWithNibName:@"JigouTableViewCell3" bundle:nil] forCellReuseIdentifier:@"cell4444"];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_Tableview setTableFooterView:view];

    }];
       // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)request.news.count);
    return request.news.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JigouTableViewCell3 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell4444" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dic=[request.news objectAtIndex:indexPath.row];
    DataReauest *data=[[DataReauest alloc]initWithDictiory:dic];
    cell.TimeLab.text=data.name;
    cell.LocationLab.text=data.time;
    [cell.ImgView sd_setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:nil];
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Btnclick:(UIButton *)sender
{
    if (sender.tag==0)
    {
        SheHuiGuanLizhiduViewController *controlller=[[SheHuiGuanLizhiduViewController alloc]init];
        [self.navigationController pushViewController:controlller animated:YES];
    }
    if (sender.tag==1)
    {
        SheTuanJianSheBiaoViewController *controller=[[SheTuanJianSheBiaoViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (sender.tag==2)
    {
        KechengGuiHuaViewController *controller=[[KechengGuiHuaViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (IBAction)fanhui:(UIButton *)sender
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
