//
//  MainViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "MainViewController.h"
#import "ShouYeTableViewCell.h"
#import "KechengTableViewCell.h"
#import "TeacherTableViewCell.h"
#import "KechengMedol.h"
#import "AFHTTPSessionManager.h"
#import "DataReauest.h"
#import "QuanBuViewController.h"
#import "SVProgressHUD.h"
#import "JiGouXiangQingViewController.h"
#import "KechengXiangQingViewController.h"
#import "Person.h"
#import "ChineseString.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger btnindex;
    UITableView *_TableView;
    UIView *footivew;
    NSArray *DataArry;
    NSArray *suoyinCityList;
    NSArray *Aarray;
    NSArray *dataArry;
    NSArray *titles;
    UILocalizedIndexedCollation *collation;
      UIAlertView *alertview;
}
//@property (weak, nonatomic) IBOutlet UIImageView *TouxiangImgView;
//@property (weak, nonatomic) IBOutlet UIButton *ZhuyeBtn;
@property (weak, nonatomic) IBOutlet UIView *HeadView;

@property (weak, nonatomic) IBOutlet UIButton *KeChengBtn;
@property (weak, nonatomic) IBOutlet UIView *NavIew;
@property (weak, nonatomic) IBOutlet UIView *BackTableview;
@property (weak, nonatomic) IBOutlet UIButton *XueShengBtn;
//@property (weak, nonatomic) IBOutlet UILabel *ZhuYeLab;
@property (weak, nonatomic) IBOutlet UILabel *KechengLab;
@property (weak, nonatomic) IBOutlet UILabel *XueShengLab;
//@property (weak, nonatomic) IBOutlet UITableView *TableView;
//@property (weak, nonatomic) IBOutlet UIView *Headview;

@end

@implementation MainViewController
@synthesize indexArray;
@synthesize LetterResultArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    btnindex=1;
   
    
    //_TableView.tableHeaderView=[[UIView alloc]init];
    //    [_ZhuyeBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
    //    [_ZhuYeLab setBackgroundColor:XN_COLOR_GREEN_MINT];
    [_KeChengBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
    [_KechengLab setBackgroundColor:XN_COLOR_GREEN_MINT];
    
    _TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-169) style:UITableViewStylePlain];
    
    [self.view addSubview:_TableView];
//    footivew=[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-89, [UIScreen mainScreen].bounds.size.width, 40)];
//    footivew.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:footivew];
    
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.titleLabel.font=[UIFont systemFontOfSize:15];
//    btn.frame=CGRectMake(0, 0, footivew.bounds.size.width, footivew.bounds.size.height);
//    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"全部历史课程" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,[UIScreen mainScreen].bounds.size.width/2)];
//    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [footivew addSubview:btn];
    
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_TableView setTableFooterView:view];
    _NavIew.backgroundColor=XN_COLOR_GREEN_MINT;

    // _TouxiangImgView.layer.masksToBounds=YES;
    //_TouxiangImgView.layer.cornerRadius=40;

    //[KechengMedol ZhuYeKecengUid:ShareS.uid];
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/course?&id=%@",ShareS.uid];
    NSLog(@"%@",urlstr);
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"老师课程%@",responseObject);
        DataArry=[responseObject objectForKey:@"data"];
        NSString *msgstr=[responseObject objectForKey:@"msg"];
        alertview=[[UIAlertView alloc]initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [alertview show];
        [_TableView registerNib:[UINib nibWithNibName:@"ShouYeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_TableView registerNib:[UINib nibWithNibName:@"KechengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
        [_TableView registerNib:[UINib nibWithNibName:@"TeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
        //_TableView.rowHeight=110;
        _TableView.delegate=self;
        _TableView.dataSource=self;
        [_TableView reloadData];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
  
    // Do any additional setup after loading the view from its nib.
}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview dismissWithClickedButtonIndex:0 animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)btnclick
{
    QuanBuViewController *controlleer=[[QuanBuViewController alloc]init];
    [self.navigationController pushViewController:controlleer animated:YES];
}
- (IBAction)ChageBtn:(UIButton *)sender
{
    btnindex=sender.tag;
    if (sender.tag==1)
    {
        _TableView.frame=CGRectMake(0, 120,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-209);
        footivew=[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-90, [UIScreen mainScreen].bounds.size.width, 40)];
        footivew.backgroundColor=[UIColor whiteColor];
        [self.view  addSubview:footivew];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, footivew.bounds.size.width, footivew.bounds.size.height);
        [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"全部历史课程" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,[UIScreen mainScreen].bounds.size.width/2)];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
         btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [footivew addSubview:btn];


        [_KeChengBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        //[_ZhuyeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_XueShengBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         
       // [_Headview removeFromSuperview];
       // _TableView.tableHeaderView=nil;
        [_TableView reloadData];
        
        
        
        
        [_KechengLab setBackgroundColor:XN_COLOR_GREEN_MINT];
        //[_ZhuYeLab setBackgroundColor:[UIColor clearColor]];
        [_XueShengLab setBackgroundColor:[UIColor clearColor]];

    }
    if (sender.tag==2)
    {
        _TableView.frame=CGRectMake(0, 120,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-169);
        [footivew removeFromSuperview];
        [_XueShengBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
       // [_ZhuyeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_KeChengBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_XueShengLab setBackgroundColor:XN_COLOR_GREEN_MINT];
        //[_ZhuYeLab setBackgroundColor:[UIColor clearColor]];
        [_KechengLab setBackgroundColor:[UIColor clearColor]];
       
        
        NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/myStudent?id=%@",ShareS.uid];
        AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
        [manger GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
           dataArry=[responseObject objectForKey:@"data"];
            
            self.indexArray = [ChineseString IndexArray:dataArry];
            self.LetterResultArr = [ChineseString LetterSortArray:dataArry];

            [_TableView reloadData];
         
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
        _TableView.showsHorizontalScrollIndicator = NO;
        _TableView.showsVerticalScrollIndicator = NO;
         _TableView.allowsSelection=YES;
        //[XtomFunction addbordertoView:myTableView radius:8.0f width:0.0f color:BB_White_Color];
        //设置索引列文本的颜色
        _TableView.sectionIndexColor = [UIColor redColor];
        _TableView.sectionIndexColor=[UIColor blueColor];
        //myTableView.sectionIndexBackgroundColor=BB_Red_Color;
        //myTableView.sectionIndexTrackingBackgroundColor=BB_White_Color;
        [_TableView reloadData];

    }
}

#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (btnindex==2)
    {
        return indexArray;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (btnindex==2)
    {
        NSLog(@"title===%@",title);
        return index;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (btnindex==1)
    {
        return 1;
    }
    else
    {
        return  [indexArray count];;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (btnindex==1)
    {
            ShouYeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *dic=[DataArry objectAtIndex:indexPath.row];
        DataReauest *dataRequest=[[DataReauest alloc]initWithDictiory:dic];
        [cell.Imgviewcell sd_setImageWithURL:[NSURL URLWithString:dataRequest.img] placeholderImage:nil];
        cell.NameLab.text=dataRequest.name;
        cell.TiameLab.text=dataRequest.class_time;
            return cell;
    }
    
    else
    {
        NSString *idetif=@"cell5";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetif];
        if (cell==nil) {
            cell=[tableView dequeueReusableCellWithIdentifier:idetif forIndexPath:indexPath];
            
        }
        cell.textLabel.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        return cell;
    }
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (btnindex==1)
    {
         return DataArry.count;
    }
    else
    {
        return [[self.LetterResultArr objectAtIndex:section] count];;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (btnindex==1)
    {
         return 110;
    }
   else
   {
       return 30;
   }
    
}

#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section];
    if (btnindex==2)
    {
         return key;
    }
    NSString *str=@"";
    return str;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (btnindex==2)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lab.text = [indexArray objectAtIndex:section];
        lab.textColor = [UIColor blackColor];
         return lab;
    }
    return nil;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (btnindex==1)
    {
        NSDictionary *dic=[DataArry objectAtIndex:indexPath.row];
        NSLog(@"%@",DataArry);
        NSString *cid=[dic objectForKey:@"cid"];
        NSLog(@"%@",cid);
        //NSString *kecid=[NSString stringWithFormat:@"%@",DataMedol.cid];
        [[NSUserDefaults standardUserDefaults]setObject:cid forKey:@"kecid"];
        // NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"kecid"];
        UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        KechengXiangQingViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"KechengXiangQingViewController"];
        
        // KechengXiangQingViewController *controller=[[KechengXiangQingViewController alloc]init];
        [self.navigationController pushViewController:main animated:YES];

    }
    }
- (IBAction)KeChengBtn:(UIButton *)sender {
    NSLog(@"aad");
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
