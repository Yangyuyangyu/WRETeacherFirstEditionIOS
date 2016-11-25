//
//  JiGouViewtroller.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "JiGouViewtroller.h"
#import "JIGouTableViewCell.h"
#import "JiGouXiangQingViewController.h"
#import "TianJiaViewController.h"
#import "KechengMedol.h"
#import "DataMedol.h"
#import "MJRefresh.h"
@interface JiGouViewtroller ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArry;
}
@property (weak, nonatomic) IBOutlet UIView *naview;
@property (weak, nonatomic) IBOutlet UIButton *TianJiaBtn;

@property (weak, nonatomic) IBOutlet UITableView *Tableview;
@end

@implementation JiGouViewtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArry=[[NSArray alloc]init];
      _naview.backgroundColor=XN_COLOR_GREEN_MINT;
    [KechengMedol requsetWithjiaru:^(NSArray *responseArr) {
        dataArry=responseArr;
    
        NSLog(@"\\%@",dataArry);
        _Tableview.rowHeight=150;
      
        [_Tableview registerNib:[UINib nibWithNibName:@"JIGouTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _Tableview.delegate=self;
        _Tableview.dataSource=self;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_Tableview setTableFooterView:view];
        
        _Tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [KechengMedol requsetWithjiaru:^(NSArray *responseArr) {
                    dataArry=responseArr;
                    [_Tableview reloadData];
                    [_Tableview.mj_header endRefreshing];//结束刷新
                }];
                
                
                
                
            });
        }];

        
        
       

    }];
    
    //self.view.backgroundColor=[UIColor greenColor];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIGouTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    NSDictionary *dic1=[dic objectForKey:@"agencyInfo"];
    DataReauest *dataRquest=[[DataReauest alloc]initWithDictiory:dic];
    ShareS.JiGouDetailRequestMedol=dataRquest;
    DataMedol *datamedol=[[DataMedol alloc]initWithDictiory:dic1];
    ShareS.JiGouDetaildataMedol=datamedol;
    [cell.Touxiang sd_setImageWithURL:[NSURL URLWithString:datamedol.img] placeholderImage:nil];
    cell.Name.text=datamedol.name;
    cell.TecherName.text=datamedol.teacherNum;
    cell.Address.text=datamedol.location;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JiGouXiangQingViewController *controller=[[JiGouXiangQingViewController alloc]init];
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    
    DataMedol *datamedol=[[DataMedol alloc]initWithDictiory:dic];
    [[NSUserDefaults standardUserDefaults]setObject:datamedol.status forKey:@"stastus"];
    NSLog(@"%@",datamedol.status);
    
    NSDictionary *dic1=[dic objectForKey:@"agencyInfo"];
   DataReauest *dataRquest=[[DataReauest alloc]initWithDictiory:dic1];
    
    NSString *JiGouId=[NSString stringWithFormat:@"%d",dataRquest.HdID];
    [[NSUserDefaults standardUserDefaults]setObject:JiGouId forKey:@"agencyid"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)TianJia:(UIButton *)sender {
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TianJiaViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"TianJiaViewController"];
    [self.navigationController pushViewController:main animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
