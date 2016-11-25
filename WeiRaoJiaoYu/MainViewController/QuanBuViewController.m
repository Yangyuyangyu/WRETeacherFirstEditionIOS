//
//  QuanBuViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/18.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "QuanBuViewController.h"
#import "AFHTTPSessionManager.h"
#import "ShouYeTableViewCell.h"
#import "DataReauest.h"
#import "JiGouXiangQingViewController.h"
#import "KechengXiangQingViewController.h"
@interface QuanBuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArry;
}
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic) IBOutlet UIView *Naview;

@end

@implementation QuanBuViewController
- (IBAction)FanHui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/finishedClass?&id=%@",ShareS.uid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"历史课程%@",responseObject);
        dataArry=[responseObject objectForKey:@"data"];
         [_TableView registerNib:[UINib nibWithNibName:@"ShouYeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _TableView.delegate=self;
        _TableView.dataSource=self;
        _TableView.rowHeight=110;
        UIView *view11 = [UIView new];
        view11.backgroundColor = [UIColor clearColor];
        [_TableView setTableFooterView:view11];

        _Naview.backgroundColor=XN_COLOR_GREEN_MINT;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
       // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouYeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
    [cell.Imgviewcell sd_setImageWithURL:[NSURL URLWithString:request.img] placeholderImage:nil];
    cell.NameLab.text=request.name;
    cell.TiameLab.text=request.class_time;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KechengXiangQingViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"KechengXiangQingViewController"];
    
    // KechengXiangQingViewController *controller=[[KechengXiangQingViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];}
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
