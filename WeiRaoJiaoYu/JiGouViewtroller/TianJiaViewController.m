//
//  TianJiaViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "TianJiaViewController.h"
#import "JIGouTableViewCell.h"
#import "KechengMedol.h"
#import "DataReauest.h"
#import "CZCover.h"
#import "MJRefresh.h"
#import "JiGouXiangQingViewController.h"
static NSString *identify2 = @"CELL";
@interface TianJiaViewController ()<UITableViewDelegate,UITableViewDataSource,CZCoverDelegate,UITextFieldDelegate>
{
    NSArray *dataArry;
    NSArray *projectArray;

}
@property (weak, nonatomic) IBOutlet UILabel *option;
@property (weak, nonatomic) IBOutlet UITextField *BigTextView;
@property (weak, nonatomic) IBOutlet UIView *BigView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (nonatomic, strong)CZCover *cover;
@property (nonatomic, assign)NSInteger number;
@property (nonatomic, strong)UITableView *projectTab;
@property (nonatomic, assign)BOOL recommended;
@end

@implementation TianJiaViewController
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _Kmedol=[[KechengMedol alloc]init];
    _BigTextView.delegate=self;
    if ([self.projectTab respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.projectTab setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.projectTab respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.projectTab setLayoutMargins:UIEdgeInsetsZero];
        
    }
    _option.text = @"机构";
    _number = 0;
     projectArray = @[@"机构",@"学校"];
    
    [_Kmedol SeacherTuiJIan:@"0" Page:@"0"];
    _TableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_Kmedol SeacherTuiJIan:@"0" Page:@"0"];
        [_TableView.mj_header endRefreshing];//结束刷新
    }];
    
    
    _TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
            _number=_number+1;
            NSString *Number=[NSString stringWithFormat:@"%ld",(long)_number];
            NSLog(@"%@",Number);
            [_Kmedol SeacherTuiJIan:@"0" Page:Number];
            
            [_TableView.mj_footer endRefreshing];
            
            
        });
    }];

    _BigView.layer.masksToBounds=YES;
    _BigView.layer.cornerRadius=10;
    _BigView.layer.borderWidth=2;
    _BigView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userRefresh1:) name:@"modificationinfoList" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userRefresh2:) name:@"modificationinfoList1" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _recommended = NO;
}
- (void)userRefresh1:(NSNotification *)bicode
{
    NSLog(@"%@",bicode.userInfo);
    dataArry=[bicode.userInfo objectForKey:@"data"];
    NSLog(@"DataArry%@",dataArry);
    [_TableView registerNib:[UINib nibWithNibName:@"JIGouTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _TableView.dataSource=self;
    _TableView.delegate=self;
    _TableView.rowHeight=150;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_TableView setTableFooterView:view];

}
- (void)userRefresh2:(NSNotification *)bicode
{
    NSLog(@"%@",bicode.userInfo);
    dataArry=[bicode.userInfo objectForKey:@"data"];
      NSLog(@"DataArry%@",dataArry);
    [_TableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return nil;
    }
    else
    {
        NSString *headertitle=@"为您推荐";
        return headertitle;
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return 2;
    }
    else{
        return dataArry.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
        }
        cell.textLabel.text = projectArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        JIGouTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
         NSLog(@"DataArry%@",dataArry);
        DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
        if (request.img.length==0)
        {
            cell.Touxiang.image=[UIImage imageNamed:@"img_sousuo.png"];
            
        }
        else
        {
            [cell.Touxiang sd_setImageWithURL:[NSURL URLWithString:request.img] placeholderImage:nil];

        }
        cell.Name.text=request.name;
        NSString *str=[NSString stringWithFormat:@"%@位老师",request.teacherNum];
        cell.TecherName.text=str;
        cell.Address.text=request.school_name;
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        
        if (NULL!=_TableView.mj_footer) {
            [_TableView.mj_footer removeFromSuperview];
        }
    
//        if (_TableView.mj_header!=NULL) {
//             [_TableView.mj_header removeFromSuperview];
//        }
       
        _number = indexPath.row + 1;
        _option.text = projectArray[_number - 1];
        [_cover remove];
        NSString *numberStr=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        [KechengMedol SeacherTuiJIan1:numberStr Page:@"0"];
}
    else
    {
        JiGouXiangQingViewController *jigouDetail=[[JiGouXiangQingViewController alloc]init];
        NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
        NSLog(@"DataArry%@",dataArry);
        DataReauest *request=[[DataReauest alloc]initWithDictiory:dic];
        NSString *jigouid=[NSString stringWithFormat:@"%d",request.HdID];
        [[NSUserDefaults standardUserDefaults]setObject:jigouid forKey:@"agencyid"];
        [self.navigationController pushViewController:jigouDetail animated:YES];
    }
}
- (IBAction)BtnClick:(UIButton *)sender
{
    _cover = [CZCover show];
    _cover.delegate = self;
    [self.view addSubview:_cover];
     [_cover addSubview:self.projectTab];
}
- (UITableView *)projectTab{
    if (!_projectTab) {
        _projectTab = [[UITableView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_BigView.frame) + 40, 60, 50)];
        _projectTab.tableFooterView = [[UIView alloc] init];
        _projectTab.dataSource = self;
        _projectTab.delegate = self;
        [_projectTab setSeparatorInset:UIEdgeInsetsMake(0,-60,0,0)];
        _projectTab.rowHeight = 25;
        _projectTab.scrollEnabled = NO;
        _projectTab.tag = 100;
    }
    return _projectTab;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *str = [NSString stringWithFormat:@"%ld",_number];
    NSLog(@"vvvv%ld",(long)_number);
    NSString *text=[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"filed 的只是%@",textField.text);
    [KechengMedol Seacher:str Name:text Page:@"0"];
    
   // _recommended = YES;
    [_BigTextView resignFirstResponder];
    return YES;
}

- (IBAction)fanhui:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
