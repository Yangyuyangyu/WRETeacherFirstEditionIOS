//
//  KeChengViewtroller.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/28.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "KeChengViewtroller.h"
#import "KechengTableViewCell.h"
#import "TkechengbiaoableViewCell.h"
#import "DianmingViewController.h"
#import "DaiKeViewController.h"
#import "QingJiaViewController.h"
#import "TiJiaoBaoGaoViewController.h"
#import "KechengXiangQingViewController.h"
#import "DataReauest.h"
#import "KechengMedol.h"
#import "AFHTTPSessionManager.h"
#import "KechengaTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "KeChengTableViewCell1.h"
#import "PingFenViewController.h"
#import "ReportStateViewController.h"
#import "MapViewController1.h"
#import "NavigationView.h"
#import "Repair.h"

@interface KeChengViewtroller ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger btnindex;
    NSDictionary *kechengbbDic;
    NSArray *dataArry;
    NSArray *DeteArry;
    NSInteger lea;
    NSInteger rep;
    NSInteger repor;
    NSInteger sta;
    NSArray *absentArry;
    NSString *  locationString;
    NSString *  nsDateString;
    NSInteger zonghms;
    NSDate *fromdate1;
}
@property (weak, nonatomic) IBOutlet UIButton *Zhouyibtn;
@property (weak, nonatomic) IBOutlet UIButton *ZhouerBrn;
@property (weak, nonatomic) IBOutlet UIButton *ZhouSanBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZhouSiBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZhouWuBtn;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UIButton *ZhouLiuBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZhouTianBtn;
@property (nonatomic, assign)NSInteger date;
@property (weak, nonatomic) IBOutlet UIView *NaView;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;

@property (nonatomic, assign) NSInteger weekdate;//判断是第几周

@property (nonatomic, strong) NavigationView *navigationView;

@property (nonatomic, strong) Repair *repair;

@property (nonatomic, assign) NSInteger number;
@end

@implementation KeChengViewtroller
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navigationView = [[NavigationView alloc] initWithTitle:@"课程表(本周)" leftButtonImage:nil];
    [self.view addSubview:_navigationView];
    
    _number = 0;
    _weekdate = 0;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH - 80, 30, 80, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"下一周" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    button.tag = 100;
    [button addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 30, 80, 30);
    button1.titleLabel.font = [UIFont systemFontOfSize:16];
    [button1 setTitle:@"上一周" forState:UIControlStateNormal];
    [button1 setTintColor:[UIColor whiteColor]];
    button1.tag = 101;
    [button1 addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    self.navigationController.navigationBar.hidden=YES;
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    
    //[dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    //NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    dataArry=[[NSArray alloc]init];
    
    NSNotificationCenter* notificationCenter1 =   [NSNotificationCenter defaultCenter];
    [notificationCenter1 addObserver:self selector:@selector(KaiShiShangkedsd) name:@"KaiShiShangKeggg" object:nil];
    
    
    
    DeteArry=[[NSArray alloc]init];
    self.tabBarController.tabBar.hidden=NO;
    _NaView.backgroundColor=XN_COLOR_GREEN_MINT;
    _date = [self getNowWeekday];
    NSLog(@"%ld",(long)_date);
    btnindex=_date-1;
    switch (_date) {
        case 1:
            _lab7.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouTianBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 7;
            break;
        case 2:
            _lab1.backgroundColor = XN_COLOR_GREEN_MINT;
            [_Zhouyibtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 1;
            break;
        case 3:
            _lab2.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouerBrn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 2;
            break;
        case 4:
            _lab3.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouSanBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 3;
            break;
        case 5:
            _lab4.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouSiBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 4;
            break;
        case 6:
            _lab5.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouWuBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 5;
            break;
        case 7:
            _lab6.backgroundColor = XN_COLOR_GREEN_MINT;
            [_ZhouLiuBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            _number = 6;
            break;
        default:
            break;
    }
    [KechengMedol requsetWithKecheng:^(NSArray *responseArr) {
        
        dataArry=responseArr;
        
        if (_date==1)
        {
            DeteArry=ShareS.courseArry7;
        }
        if (_date==2)
        {
            DeteArry=ShareS.courseArry1;
        }
        if (_date==3)
        {
            DeteArry=ShareS.courseArry2;
        }
        if (_date==4)
        {
            DeteArry=ShareS.courseArry3;
        }
        if (_date==5)
        {
            DeteArry=ShareS.courseArry4;
        }
        if (_date==6)
        {
            DeteArry=ShareS.courseArry5;
        }
        if (_date==7)
        {
            DeteArry=ShareS.courseArry6;
        }
        
        
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_Tableview registerNib:[UINib nibWithNibName:@"TkechengbiaoableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
        [_Tableview registerNib:[UINib nibWithNibName:@"TkechengbiaoableViewCell" bundle:nil] forCellReuseIdentifier:@"cell11111"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell2"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell21"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell22"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell23"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell24"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell25"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell26"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell27"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell28"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell29"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell20"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell31"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KechengaTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"cell32"];
        [_Tableview registerNib:[UINib nibWithNibName:@"KeChengTableViewCell1" bundle:nil] forCellReuseIdentifier:@"cell99"];
        _Tableview.rowHeight=127;
        _Tableview.delegate=self;
        _Tableview.dataSource=self;
        NSLog(@" 第6个%@",ShareS.courseArry6);
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_Tableview setTableFooterView:view];
        
        _Tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [KechengMedol requsetWithKecheng:^(NSArray *responseArr) {
                    dataArry=responseArr;
                    NSLog(@"%@",dataArry);
                    if (btnindex==1)
                    {
                        DeteArry=ShareS.courseArry1;
                    }
                    if (btnindex==2) {
                        DeteArry=ShareS.courseArry2;
                    }
                    if (btnindex==3)
                    {
                        DeteArry=ShareS.courseArry3;
                    }
                    if (btnindex==4)
                    {
                        DeteArry=ShareS.courseArry4;
                    }
                    if (btnindex==5) {
                        DeteArry=ShareS.courseArry5;
                    }
                    if (btnindex==6)
                    {
                        DeteArry=ShareS.courseArry6;
                    }
                    if (btnindex==7)
                    {
                        DeteArry=ShareS.courseArry7;
                    }
                    
                    [_Tableview reloadData];
                    [_Tableview.mj_header endRefreshing];//结束刷新
                } week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
                
                
                
                
            });
        }];
    }week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
    
    _repair = [[Repair alloc] init];
    
    
    
    
}

- (void)info:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]){
        NSDictionary *dic = bitice.userInfo[@"data"][@"info"];
        ShareS.sex = dic[@"sex"];
        ShareS.name = dic[@"name"];
        ShareS.headImgUrl = dic[@"head"];
        ShareS.uid = dic[@"id"];
        ShareS.phone = dic[@"phone"];
        ShareS.birthday = dic[@"birthday"];
    }
}


- (void)timer
{
    //获得系统时间
    //    NSDate *  senddate=[NSDate date];
    //
    //    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [dateformatter setDateFormat:@"HH:mm:ss"];
    //    locationString=[dateformatter stringFromDate:senddate];
    //    NSLog(@"%@",locationString);
    //    NSArray *array = [locationString componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
    //    NSString *HH = array[0];
    //    NSString *MM= array[1];
    //    NSString *ss = array[2];
    //    NSInteger h = [HH integerValue];
    //    NSInteger m = [MM integerValue];
    //    NSInteger s = [ss integerValue];
    //     zonghms = h*3600 + m*60 +s;
    //    NSLog(@"%ld",(long)zonghms);
    //    [[NSUserDefaults standardUserDefaults]setObject:locationString forKey:@"XT"];
    
    //获得系统日期
    //    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    //    currentDate = [currentDate dateByAddingTimeInterval:3600];//加一个小时
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm"];
    //    locationString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"dateString:%@",locationString);
    
    
    //    NSCalendar  * cal=[NSCalendar  currentCalendar];
    //    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    //    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    //    NSInteger year=[conponent year];
    //    NSInteger month=[conponent month];
    //    NSInteger day=[conponent day];
    //    nsDateString= [NSString  stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)month,(long)day];
    //    NSLog(@"%@",nsDateString);
    //    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //    [format setDateFormat:@"yyyy-MM-dd"];
    //    fromdate1=[format dateFromString:nsDateString];
    //    NSLog(@"%@",fromdate1);
    //    [[NSUserDefaults standardUserDefaults]setObject:nsDateString forKey:@"RiQi"];
    [_Tableview reloadData];
    
    
}

- (BOOL)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    NSLog(@"%@,%@",date01,date02);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: return NO; break;
            //date02比date01小
        case NSOrderedDescending: return YES; break;
            //date02=date01
        case NSOrderedSame: return YES; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
}

- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

//通知
- (void)KaiShiShangkedsd
{
    NSLog(@"%ld",(long)btnindex);
    [KechengMedol requsetWithKecheng:^(NSArray *responseArr)
     {
         NSDictionary *dic=[responseArr objectAtIndex:btnindex-1];
         NSArray *courseArry=[dic objectForKey:@"course"];
         DeteArry=courseArry;
         NSLog(@"%@",DeteArry);
         [_Tableview reloadData];
     }week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
    
}
//- (void)qiandaolou
//{
//    NSString *btntag=[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"];
//    NSInteger tag=[btntag integerValue];
//        CLLocationCoordinate2D coors[2] = {0};
//        //定位点
//        coors[0].latitude = _locService.userLocation.location.coordinate.latitude;
//        coors[0].longitude = _locService.userLocation.location.coordinate.longitude;
//        NSLog(@"%f%f",coors[0].latitude,coors[0].longitude);
//
//        NSLog(@"按钮的序列值 : %ld",(long)btnindex);
//
//        NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
//        NSArray *courseArry=[dic objectForKey:@"course"];
//        NSLog(@"dateArry %@",DeteArry);
//        NSDictionary *dic1=[courseArry objectAtIndex:tag];
//        DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
//        NSLog(@"上课记录id 是 %d",request.HdID);
//        NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
//        float lng=coors[0].latitude;
//        float  lat=coors[0].longitude;
//        NSString *lng1=[NSString stringWithFormat:@"%f",lng];
//        NSString *lat1=[NSString stringWithFormat:@"%f",lat];
//        [KechengMedol QianDaoRequestClassid:Kid Lng:lng1 Lat:lat1];
//
//         NSLog(@"Daike%ld",(long)tag);
//
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(info:) name:@"infoInfoList" object:nil];
    
    self.tabBarController.tabBar.hidden=NO;
    absentArry= [[NSUserDefaults standardUserDefaults]objectForKey:@"absent"];
    
    [KechengMedol requsetWithKecheng:^(NSArray *responseArr) {
        
        dataArry=responseArr;
        NSLog(@"%@",dataArry);
        if (btnindex==1)
        {
            DeteArry=ShareS.courseArry1;
        }
        if (btnindex==2) {
            DeteArry=ShareS.courseArry2;
        }
        if (btnindex==3)
        {
            DeteArry=ShareS.courseArry3;
        }
        if (btnindex==4)
        {
            DeteArry=ShareS.courseArry4;
        }
        if (btnindex==5) {
            DeteArry=ShareS.courseArry5;
        }
        if (btnindex==6)
        {
            DeteArry=ShareS.courseArry6;
        }
        if (btnindex==7)
        {
            DeteArry=ShareS.courseArry7;
        }
        
        [_Tableview reloadData];
    }week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
    
    [_repair infoInfoList];
}

//提示框
- (void)tooltip:(NSString *)string {
    //提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:string preferredStyle:UIAlertControllerStyleAlert];
    //添加行为
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
//上下一周
- (void)handleEvent:(UIButton *)sender{
    NSArray *array = @[_Zhouyibtn,_ZhouerBrn,_ZhouSanBtn,_ZhouSiBtn,_ZhouWuBtn,_ZhouLiuBtn,_ZhouTianBtn];
    NSArray *nameArray  = @[@"课程表(前三周)",@"课程表(前两周)",@"课程表(前一周)",@"课程表(本周)",@"课程表(后一周)",@"课程表(后两周)",@"课程表(后三周)"];
    if (sender.tag == 100) {
        _weekdate ++;
        if (_weekdate > 3) {
            [self tooltip:@"只能查看后三周的课"];
            _weekdate = 3;
        }else{
            for (int i = 0; i < nameArray.count; i ++) {
                _navigationView.titleLabel.text = nameArray[_weekdate + 3];
                [_navigationView.titleLabel sizeToFit];
            }
        }
        if (_weekdate == 0) {
            //            for (int i = 0; i < array.count; i ++) {
            //                [array[_number - 1] setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            //            }
        }else{
            for (int i = 0; i < array.count; i ++) {
                [array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        [KechengMedol requsetWithKecheng:^(NSArray *responseArr) {
            dataArry=responseArr;
            NSLog(@"%@",dataArry);
            if (btnindex==1)
            {
                _lab1.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry1;
            }
            if (btnindex==2) {
                _lab2.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry2;
            }
            if (btnindex==3)
            {
                _lab3.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry3;
            }
            if (btnindex==4)
            {
                _lab4.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry4;
            }
            if (btnindex==5) {
                _lab5.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry5;
            }
            if (btnindex==6)
            {
                _lab6.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry6;
            }
            if (btnindex==7)
            {
                _lab7.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry7;
            }
            if (dataArry.count == 0) {
                [self tooltip:@"暂无数据"];
            }
            [_Tableview reloadData];
        } week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
    }else{
        _weekdate --;
        if (_weekdate < -3) {
            [self tooltip:@"只能查看前三周的课"];
            _weekdate = -3;
        }else{
            for (int i = 0; i < nameArray.count; i ++) {
                _navigationView.titleLabel.text = nameArray[_weekdate + 3];
                [_navigationView.titleLabel sizeToFit];
            }
        }
        if (_weekdate == 0) {
            for (int i = 0; i < array.count; i ++) {
                [array[_number - 1] setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
            }
        }else{
            for (int i = 0; i < array.count; i ++) {
                [array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        [KechengMedol requsetWithKecheng:^(NSArray *responseArr) {
            dataArry=responseArr;
            NSLog(@"%@",dataArry);
            if (btnindex==1)
            {
                _lab1.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry1;
            }
            if (btnindex==2) {
                _lab2.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry2;
            }
            if (btnindex==3)
            {
                _lab3.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry3;
            }
            if (btnindex==4)
            {
                _lab4.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry4;
            }
            if (btnindex==5) {
                _lab5.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry5;
            }
            if (btnindex==6)
            {
                _lab6.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry6;
            }
            if (btnindex==7)
            {
                _lab7.backgroundColor = XN_COLOR_GREEN_MINT;
                DeteArry=ShareS.courseArry7;
            }
            if (dataArry.count == 0) {
                [self tooltip:@"暂无数据"];
            }
            [_Tableview reloadData];
        } week:[NSString stringWithFormat:@"%ld",(long)_weekdate]];
    }
    _lab1.backgroundColor = [UIColor whiteColor];
    _lab2.backgroundColor = [UIColor whiteColor];
    _lab3.backgroundColor = [UIColor whiteColor];
    _lab4.backgroundColor = [UIColor whiteColor];
    _lab5.backgroundColor = [UIColor whiteColor];
    _lab6.backgroundColor = [UIColor whiteColor];
    _lab7.backgroundColor = [UIColor whiteColor];
}

- (IBAction)change:(UIButton *)sender
{
    btnindex=sender.tag;
    
    if (sender.tag==1)
    {
        DeteArry=ShareS.courseArry1;
        [_Zhouyibtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lab1.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_Tableview reloadData];
        
    }
    if (sender.tag==2)
    {
        DeteArry=ShareS.courseArry2;
        [_ZhouerBrn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lab2.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab1.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_Tableview reloadData];
        
    }
    if (sender.tag==3)
    {
        DeteArry=ShareS.courseArry3;
        [_ZhouSanBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lab3.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab1.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_Tableview reloadData];
    }
    if (sender.tag==4)
    { DeteArry=ShareS.courseArry4;
        [_ZhouSiBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lab4.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab1.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Tableview reloadData];
        
    }
    if (sender.tag==5)
    { DeteArry=ShareS.courseArry5;
        [_ZhouWuBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        _lab5.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab1.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Tableview reloadData];
        
    }
    if (sender.tag==6)
    { DeteArry=ShareS.courseArry6;
        [_ZhouLiuBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouTianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        _lab6.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab1.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab7.backgroundColor=[UIColor clearColor];
        [_Tableview reloadData];
    }
    if (sender.tag==7)
    { DeteArry=ShareS.courseArry7;
        [_ZhouTianBtn setTitleColor:XN_COLOR_GREEN_MINT forState:UIControlStateNormal];
        [_ZhouerBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouSiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Zhouyibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ZhouLiuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        _lab7.backgroundColor=XN_COLOR_GREEN_MINT;
        _lab2.backgroundColor=[UIColor clearColor];
        _lab3.backgroundColor=[UIColor clearColor];
        _lab4.backgroundColor=[UIColor clearColor];
        _lab1.backgroundColor=[UIColor clearColor];
        _lab5.backgroundColor=[UIColor clearColor];
        _lab6.backgroundColor=[UIColor clearColor];
        [_Tableview reloadData];
        
    }
    [_Tableview reloadData];
}
#pragma- Mark点击事件
//代课
- (void)DaiKeclick:(UIButton *)btn
{
    
    
    NSLog(@"按钮的序列值 : %ld",(long)btnindex);
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSLog(@"dateArry %@",DeteArry);
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    //NSLog(@"上课记录id 是 %@",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    
    [[NSUserDefaults standardUserDefaults]setObject:Kid forKey:@"DaiKekid"];
    NSLog(@"%@",Kid);
    DaiKeViewController *controller=[[DaiKeViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
    
    NSLog(@"Daike%ld",(long)btn.tag);
}
//请假
- (void)QinJiaclick:(UIButton *)btn
{
    NSLog(@"按钮的序列值 : %ld",(long)btnindex);
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSLog(@"dateArry %@",DeteArry);
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    
    [[NSUserDefaults standardUserDefaults]setObject:Kid forKey:@"QinJiakid"];
    QingJiaViewController *controller=[[QingJiaViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSLog(@"Daike%ld",(long)btn.tag);
}
//定位
- (void)QianDaoclick:(UIButton *)btn
{
    NSLog(@"Daike%ld",(long)btn.tag);
    //    NSString *Btntag=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    //    [[NSUserDefaults standardUserDefaults]setObject:Btntag forKey:@"btntag"];
    
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    
    MapViewController1 *controller=[[MapViewController1 alloc]init];
    controller.class_id = Kid;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)KaishiShangKeclick:(UIButton *)btn
{
    
    if ([btn.titleLabel.text isEqualToString:@"开始上课"])
    {
        NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
        NSArray *courseArry=[dic objectForKey:@"course"];
        NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
        NSString *Type=[dic1 objectForKey:@"type"];
        int type=[Type intValue];
        int type1=type+1;
        NSString *Type1=[NSString stringWithFormat:@"%d",type1];
        DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
        NSLog(@"上课记录id 是 %d",request.HdID);
        NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
        [KechengMedol KaiShiShangKeRequestStatus:Type1 Cid:Kid];
        
        NSLog(@"按钮的序列值 : %ld",(long)btnindex);
        NSLog(@"Daike%ld",(long)btn.tag);
        
    }
}
//补点名  点名
- (void)Dianmingclick:(UIButton *)btn
{
    NSString *dId=@"100";
    [[NSUserDefaults standardUserDefaults]setObject:dId forKey:@"ddd"];
    
    //    NSLog(@"Daike%ld",(long)btn.tag);
    //    NSLog(@"按钮的序列值 : %ld",(long)btnindex);
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    //    NSLog(@"dateArry %@",DeteArry);
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    //    NSLog(@"%@",dic1);
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    //    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    
    [[NSUserDefaults standardUserDefaults]setObject:Kid forKey:@"DianMingkid"];
    if ([btn.titleLabel.text isEqualToString:@"点名"])
    {
        
        
        DianmingViewController *viewcontrollewr=[[DianmingViewController alloc]init];
        [self.navigationController pushViewController:viewcontrollewr animated:YES];
    }else{
        DianmingViewController *viewcontrollewr=[[DianmingViewController alloc]init];
        viewcontrollewr.recordId = [[NSUserDefaults standardUserDefaults]objectForKey:@"DianMingkid"];
        [self.navigationController pushViewController:viewcontrollewr animated:YES];
        
        
    }
    NSLog(@"----------------------点击了点名");
    
    
    
}
//提交记录
- (void)TiJiaoBaoGaoclick:(UIButton *)btn
{
    
    
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    //    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    [[NSUserDefaults standardUserDefaults]setObject:Kid forKey:@"TiJiaoBaoGaokid"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *locationVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportStateViewController"];
    [self.navigationController pushViewController:locationVC animated:YES];
    //    TiJiaoBaoGaoViewController *controller=[[TiJiaoBaoGaoViewController alloc]init];
    //    [self.navigationController pushViewController:controller animated:YES];
    
    //    NSLog(@"Daike%ld",(long)btn.tag);
    NSLog(@"----------------------点击了提交记录");
}
//评分
- (void)PingFenclick:(UIButton *)btn
{
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    self.hidesBottomBarWhenPushed = YES;
    PingFenViewController *controller=[[PingFenViewController alloc]init];
    controller.courseId = Kid;
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    
    NSLog(@"Daike%ld",(long)btn.tag);
}

- (void)QueRenYuYueclick:(UIButton *)btn
{
    
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    
    
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    NSString *Type=[dic1 objectForKey:@"type"];
    int type=[Type intValue];
    int type1=type-1;
    
    NSString *Type1=[NSString stringWithFormat:@"%d",type1];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    [KechengMedol KaiShiShangKeRequestStatus:Type1 Cid:Kid];
    
    
    
    NSLog(@"Daike%ld",(long)btn.tag);
}
-(void)budianmingclick:(UIButton *)btn
{
    NSString *dId=@"101";
    [[NSUserDefaults standardUserDefaults]setObject:dId forKey:@"ddd"];
    
    
    NSLog(@"Daike%ld",(long)btn.tag);
    NSLog(@"按钮的序列值 : %ld",(long)btnindex);
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    NSLog(@"dateArry %@",DeteArry);
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    
    [[NSUserDefaults standardUserDefaults]setObject:Kid forKey:@"DianMingkid"];
    
    DianmingViewController *controller=[[DianmingViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)QuXiaoYuYueclick:(UIButton *)btn
{
    
    
    NSDictionary *dic=[dataArry objectAtIndex:btnindex-1];
    NSArray *courseArry=[dic objectForKey:@"course"];
    
    
    NSDictionary *dic1=[courseArry objectAtIndex:btn.tag];
    NSString *Type=[dic1 objectForKey:@"type"];
    int type=[Type intValue];
    int type1=type-1;
    NSString *Type1=[NSString stringWithFormat:@"%d",type1];
    DataReauest *request=[[DataReauest alloc]initWithDictiory:dic1];
    NSLog(@"上课记录id 是 %d",request.HdID);
    NSString *Kid=[NSString stringWithFormat:@"%d",request.HdID];
    [KechengMedol KaiShiShangKeRequestStatus:Type1 Cid:Kid];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (btnindex==1)
    {
        return ShareS.courseArry1.count;
    }
    if (btnindex==2)
    {
        return ShareS.courseArry2.count;
    }
    if (btnindex==3)
    {
        return ShareS.courseArry3.count;
    }
    if (btnindex==4)
    {
        return ShareS.courseArry4.count;
    }
    if (btnindex==5)
    {
        return ShareS.courseArry5.count;
    }
    if (btnindex==6)
    {
        return ShareS.courseArry6.count;
    }
    else
    {
        return ShareS.courseArry7.count;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[DeteArry objectAtIndex:indexPath.row];
    DataReauest *DataMedol=[[DataReauest alloc]initWithDictiory:dic];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    currentDate = [currentDate dateByAddingTimeInterval:3600];//加一个小时
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    locationString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",locationString);
    
    NSString *class_time = DataMedol.class_time;
    NSRange range = [class_time rangeOfString:@"~"];//匹配得到的下标
    NSLog(@"rang:%@",NSStringFromRange(range));
    class_time = [class_time substringToIndex:range.location];//截取范围类的字符串
    NSLog(@"截取的值为：%@",class_time);
    
    BOOL miao = [self compareDate:locationString withDate:class_time];
    
    NSString *second_call=[dic objectForKey:@"second_call"];
    NSLog(@"budianming%@",second_call);
    NSString *type=[dic objectForKey:@"type"];
    NSString *status=[dic objectForKey:@"status"];
    NSString *leave=[dic objectForKey:@"leave"];
    NSString *replace=[dic objectForKey:@"replace"];
    NSString *report=[dic objectForKey:@"report"];
    repor=[second_call integerValue];
    sta=[status integerValue];
    NSLog(@"%@%@",leave,replace);
    lea=[leave integerValue];
    rep=[replace integerValue];
    NSInteger reportInt = [report integerValue];
    NSLog(@"report %@",report);
    NSLog(@"%@",DataMedol.date);
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:DataMedol.date];
    NSLog(@"%@",fromdate);
    
    if ([type isEqualToString:@"1"])
    {//签到，请假
        if (lea==0||rep==0)
        {
            
            
        }
        if (lea==2||rep==2)
        {
            
            if (btnindex<_date-1)
            {
                //                    签到、代课、请假
                TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                cell.KeLab.text=@"大课";
                cell.DaiKeBtn.tag=indexPath.row;
                cell.QinhJiaBtn.tag=indexPath.row;
                cell.QianDaoBtn.tag=indexPath.row;
                
                NSLog(@"时间是%@",DataMedol.class_time);
                [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                cell.QianDaoBtn.layer.masksToBounds=YES;
                cell.QianDaoBtn.layer.cornerRadius=5;
                cell.QianDaoBtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                return cell;
            }
            
            
            
            
            if (btnindex==_date-1)
            {
                if (miao == YES)
                    
                {   //签到、代课、请假
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"大课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                }
                
                else
                {   //签到、代课、请假
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"大课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.QianDaoBtn.userInteractionEnabled=NO;
                    cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    //[cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                    
                }
                
            }
            else
            {   //签到、代课、请假
                TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                cell.KeLab.text=@"大课";
                cell.DaiKeBtn.tag=indexPath.row;
                cell.QinhJiaBtn.tag=indexPath.row;
                cell.QianDaoBtn.tag=indexPath.row;
                
                NSLog(@"时间是%@",DataMedol.class_time);
                [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                if (miao == YES) {
                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                }
                //                    cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                cell.QianDaoBtn.layer.masksToBounds=YES;
                cell.QianDaoBtn.layer.cornerRadius=5;
                cell.QianDaoBtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                return cell;
                
            }
            
        }
        if (lea==-1||rep==-1)
        {
            if (sta==0)
            {
                NSLog(@"%@",fromdate1);
                NSLog(@"%@",fromdate);
                NSLog(@"%ld",(long)btnindex);
                NSLog(@"%ld",(long)_date);
                if (btnindex<_date-1)
                {
                    //签到、代课、请假
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"大课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    if (miao == YES) {
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                }
                
                
                
                
                if (btnindex==_date-1)
                {
                    if (miao == YES)
                    {   //签到、代课、请假
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"大课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        cell.QianDaoBtn.userInteractionEnabled=YES;
                        cell.QianDaoBtn.backgroundColor=[UIColor whiteColor];
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                    }
                    
                    else
                    {   //签到、代课、请假
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"大课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled=NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                        //[cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                        
                    }
                    
                }
                else
                {    //签到、代课、请假
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"大课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    if (miao == YES) {
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled=YES;
                        cell.QianDaoBtn.backgroundColor=[UIColor whiteColor];
                    }else{
                        cell.QianDaoBtn.userInteractionEnabled = NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    }
                    
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                    
                }
                
            }
            
            
            if (sta==1)
            {   //一个按钮
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                NSLog(@"时间是%@",DataMedol.class_time);
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.yuyuebtn setTitle:@"开始上课" forState:UIControlStateNormal];
                cell.yuyuebtn.tag=indexPath.row;
                cell.Kelab.text=@"大课";
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                //cell.yuyuebtn.tag=104;
                cell.yuyuebtn.userInteractionEnabled=YES;
                [cell.yuyuebtn addTarget:self action:@selector(KaishiShangKeclick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                
                return cell;
                
                
                
            }
            
            
            
            
            if (sta==2)
            {//一个按钮
                
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.yuyuebtn setTitle:@"点名" forState:UIControlStateNormal];
                
                cell.Kelab.text=@"大课";
                cell.yuyuebtn.tag=indexPath.row;
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                
                if([cell.yuyuebtn.titleLabel.text  isEqualToString:@"点名"]){
                    [cell.yuyuebtn addTarget:self action:@selector(Dianmingclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.yuyuebtn.userInteractionEnabled=YES;
                    NSLog(@"------------添加点名方法");
                }
                
                
                return cell;
                
                
                
            }
            
            
            
            if (sta==3)
            {
                if (repor==0)
                {
                    if (rep==0)
                    {//一个按钮
                        KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        [cell.yuyuebtn setTitle:@"审核中" forState:UIControlStateNormal];
                        cell.yuyuebtn.userInteractionEnabled=NO;
                        cell.Kelab.text=@"大课";
                        cell.yuyuebtn.tag=indexPath.row;
                        cell.yuyuebtn.layer.masksToBounds=YES;
                        cell.yuyuebtn.layer.cornerRadius=5;
                        cell.yuyuebtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                        [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                        [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                        // cell.yuyuebtn.tag=106;
                        
                        return cell;
                        
                    }else if (rep==1){
                        //一个按钮
                        KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        if (reportInt == 0) {
                            [cell.yuyuebtn setTitle:@"记录审核中" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=NO;
                        }else if (reportInt == 1){
                            [cell.yuyuebtn setTitle:@"课程结束" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=NO;
                        }
                        else{
                            [cell.yuyuebtn setTitle:@"再次提交" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=YES;
                            [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        
                        
                        
                        cell.Kelab.text=@"大课";
                        cell.yuyuebtn.tag=indexPath.row;
                        cell.yuyuebtn.layer.masksToBounds=YES;
                        cell.yuyuebtn.layer.cornerRadius=5;
                        cell.yuyuebtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                        [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                        [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                        // cell.yuyuebtn.tag=106;
                        
                        return cell;
                        
                    }
                    else
                        
                    {   //3个按钮  补点名、评分、提交记录
                        KeChengTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell99" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        
                        if (absentArry.count!=0)
                        {
                            [cell.yuyuebtn setTitle:@"提交记录" forState:UIControlStateNormal];
                            [cell.yuyuebtn1 setTitle:@"评分" forState:UIControlStateNormal];
                            if (repor == 0) {
                                cell.yuyuebtn2.hidden = YES;
                            }else{
                                cell.yuyuebtn2.hidden = NO;
                                [cell.yuyuebtn2 setTitle:@"补点名" forState:UIControlStateNormal];
                                cell.yuyuebtn2.tag = indexPath.row;
                            }
                            cell.imagview.image=[UIImage imageNamed:@"Shenhe.png"];
                            cell.yuyuebtn1.tag=indexPath.row;
                            cell.yuyuebtn.tag=indexPath.row;
                            
                            if([cell.yuyuebtn.titleLabel.text isEqualToString:@"提交记录"]){
                                [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                                NSLog(@"------------添加提交记录方法");
                            }
                            
                            
                            [cell.yuyuebtn1 addTarget:self action:@selector(PingFenclick:) forControlEvents:UIControlEventTouchUpInside];
                            [cell.yuyuebtn2 addTarget:self action:@selector(Dianmingclick:) forControlEvents:UIControlEventTouchUpInside];
                            cell.Kelab.text=@"大课";
                            cell.yuyuebtn.layer.masksToBounds=YES;
                            cell.yuyuebtn.layer.cornerRadius=5;
                            cell.yuyuebtn.layer.borderWidth=1;
                            cell.yuyuebtn1.layer.masksToBounds=YES;
                            cell.yuyuebtn1.layer.cornerRadius=5;
                            cell.yuyuebtn1.layer.borderWidth=1;
                            cell.yuyuebtn2.layer.masksToBounds=YES;
                            cell.yuyuebtn2.layer.cornerRadius=5;
                            cell.yuyuebtn2.layer.borderWidth=1;
                            
                            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
                            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                            
                            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                            
                            [cell.yuyuebtn1.layer setBorderColor:colorref];//边框颜色
                            
                            [cell.yuyuebtn1 setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                            
                            [cell.yuyuebtn2.layer setBorderColor:colorref];//边框颜色
                            
                            [cell.yuyuebtn2 setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                        }
                        else
                        {
                            [cell.yuyuebtn setTitle:@"提交记录" forState:UIControlStateNormal];
                            
                            [cell.yuyuebtn1 setTitle:@"评分" forState:UIControlStateNormal];
                            
                            cell.yuyuebtn2.hidden = YES;
                            cell.imagview.image=[UIImage imageNamed:@"Shenhe.png"];
                            cell.yuyuebtn1.tag=indexPath.row;
                            cell.yuyuebtn.tag=indexPath.row;
                            [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                            [cell.yuyuebtn1 addTarget:self action:@selector(PingFenclick:) forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.Kelab.text=@"大课";
                            cell.yuyuebtn.layer.masksToBounds=YES;
                            cell.yuyuebtn.layer.cornerRadius=5;
                            cell.yuyuebtn.layer.borderWidth=1;
                            cell.yuyuebtn1.layer.masksToBounds=YES;
                            cell.yuyuebtn1.layer.cornerRadius=5;
                            cell.yuyuebtn1.layer.borderWidth=1;
                            
                            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
                            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                            
                            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                            
                            [cell.yuyuebtn1.layer setBorderColor:colorref];//边框颜色
                            
                            [cell.yuyuebtn1 setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                            
                        }
                        
                        return cell;
                        
                    }
                    
                }
                
                
                
                
                else
                {
                    if (rep==0)
                    {   //2个按钮
                        KechengTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        [cell.yuyuebtn setTitle:@"审核中" forState:UIControlStateNormal];
                        if (repor == 0) {
                            cell.yuyuebtn1.hidden = YES;
                        }else{
                            cell.yuyuebtn1.hidden = NO;
                            [cell.yuyuebtn1 setTitle:@"补点名" forState:UIControlStateNormal];
                        }
                        [cell.yuyuebtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        cell.yuyuebtn1.tag=indexPath.row;
                        cell.yuyuebtn.tag=indexPath.row;
                        //[cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.yuyuebtn1 addTarget:self action:@selector(Dianmingclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.Kelab.text=@"大课";
                        cell.yuyuebtn.layer.masksToBounds=YES;
                        cell.yuyuebtn.layer.cornerRadius=5;
                        cell.yuyuebtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
                        [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                        [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                        
                    }
                    if (rep==1)
                    {
                        KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        if (reportInt == 0) {
                            [cell.yuyuebtn setTitle:@"记录审核中" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=NO;
                        }else if (reportInt == 1){
                            [cell.yuyuebtn setTitle:@"课程结束" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=NO;
                        }
                        else{
                            [cell.yuyuebtn setTitle:@"再次提交" forState:UIControlStateNormal];
                            cell.yuyuebtn.userInteractionEnabled=YES;
                            [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        
                        cell.Kelab.text=@"大课";
                        cell.yuyuebtn.tag=indexPath.row;
                        cell.yuyuebtn.layer.masksToBounds=YES;
                        cell.yuyuebtn.layer.cornerRadius=5;
                        cell.yuyuebtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                        [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                        [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                        // cell.yuyuebtn.tag=106;
                        
                        return cell;
                        
                    }
                    else
                    {
                        KeChengTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell99" forIndexPath:indexPath];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        [cell.yuyuebtn setTitle:@"提交记录" forState:UIControlStateNormal];
                        [cell.yuyuebtn1 setTitle:@"评分" forState:UIControlStateNormal];
                        
                        if (repor == 0) {
                            cell.yuyuebtn2.hidden = YES;
                        }else{
                            cell.yuyuebtn2.hidden = NO;
                            [cell.yuyuebtn2 setTitle:@"补点名" forState:UIControlStateNormal];
                            cell.yuyuebtn2.tag = indexPath.row;
                        }
                        cell.imagview.image=[UIImage imageNamed:@"Shenhe.png"];
                        [cell.yuyuebtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        cell.yuyuebtn1.tag=indexPath.row;
                        cell.yuyuebtn.tag=indexPath.row;
                        [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.yuyuebtn1 addTarget:self action:@selector(PingFenclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.yuyuebtn2 addTarget:self action:@selector(Dianmingclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.Kelab.text=@"大课";
                        cell.yuyuebtn.layer.masksToBounds=YES;
                        cell.yuyuebtn.layer.cornerRadius=5;
                        cell.yuyuebtn.layer.borderWidth=1;
                        cell.yuyuebtn1.layer.masksToBounds=YES;
                        cell.yuyuebtn1.layer.cornerRadius=5;
                        cell.yuyuebtn1.layer.borderWidth=1;
                        cell.yuyuebtn2.layer.masksToBounds=YES;
                        cell.yuyuebtn2.layer.cornerRadius=5;
                        cell.yuyuebtn2.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
                        [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                        [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
            }
            else
            {
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                cell.yuyuebtn.tag=indexPath.row;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (reportInt == 0) {
                    [cell.yuyuebtn setTitle:@"记录审核中" forState:UIControlStateNormal];
                    cell.yuyuebtn.userInteractionEnabled=NO;
                }else if (reportInt == 1){
                    [cell.yuyuebtn setTitle:@"课程结束" forState:UIControlStateNormal];
                    cell.yuyuebtn.userInteractionEnabled=NO;
                }
                else{
                    [cell.yuyuebtn setTitle:@"再次提交" forState:UIControlStateNormal];
                    cell.yuyuebtn.userInteractionEnabled=YES;
                    [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                }
                cell.Kelab.text=@"大课";
                
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                // cell.yuyuebtn.tag=108;
                
                return cell;
                
                
                
            }
            
            
            
            
            
            
            
        }
        
        
        
        else
        {
            KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell22" forIndexPath:indexPath];
            cell.TimeLab.text=DataMedol.class_time;
            cell.NameLab.text=DataMedol.name;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
            [cell.yuyuebtn setTitle:@"申请通过" forState:UIControlStateNormal];
            cell.yuyuebtn.userInteractionEnabled=NO;
            cell.Kelab.text=@"大课";
            cell.yuyuebtn.layer.masksToBounds=YES;
            cell.yuyuebtn.layer.cornerRadius=5;
            cell.yuyuebtn.layer.borderWidth=1;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
            NSLog(@"时间是%@",DataMedol.class_time);
            return cell;
            
        }
        
    }
    
    else
    {
        
        
        if ([status isEqualToString:@"0"])
        {
            KechengTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.TimeLab.text=DataMedol.class_time;
            cell.NameLab.text=DataMedol.name;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
            [cell.yuyuebtn setTitle:@"确认预约" forState:UIControlStateNormal];
            [cell.yuyuebtn1 setTitle:@"取消预约" forState:UIControlStateNormal];
            [cell.yuyuebtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            cell.yuyuebtn1.tag=indexPath.row;
            cell.yuyuebtn.tag=indexPath.row;
            [cell.yuyuebtn addTarget:self action:@selector(QueRenYuYueclick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.yuyuebtn1 addTarget:self action:@selector(QuXiaoYuYueclick:) forControlEvents:UIControlEventTouchUpInside];
            cell.Kelab.text=@"小课";
            cell.yuyuebtn.layer.masksToBounds=YES;
            cell.yuyuebtn.layer.cornerRadius=5;
            cell.yuyuebtn.layer.borderWidth=1;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
            
            return cell;
            
        }
        
        
        
        
        if ([status isEqualToString:@"1"])
        {
            if (lea==0||rep==0)
            {
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell27" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                NSLog(@"时间是%@",DataMedol.class_time);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                [cell.yuyuebtn setTitle:@"申请审核中" forState:UIControlStateNormal];
                cell.yuyuebtn.userInteractionEnabled=NO;
                cell.Kelab.text=@"小课";
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                
                return cell;
                
            }
            if (lea==1||rep==1)
            {
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell28" forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                NSLog(@"时间是%@",DataMedol.class_time);
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                [cell.yuyuebtn setTitle:@"申请通过" forState:UIControlStateNormal];
                cell.yuyuebtn.userInteractionEnabled=NO;
                cell.Kelab.text=@"小课";
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                
                return cell;
                
            }
            if (lea==2||rep==2)
            {
                //                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                //                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                //                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                //                    cell.TimeLab.text=DataMedol.class_time;
                //                    cell.NameLab.text=DataMedol.name;
                //                    cell.KeLab.text=@"小课";
                //                    cell.DaiKeBtn.tag=indexPath.row;
                //                    cell.QinhJiaBtn.tag=indexPath.row;
                //                    cell.QianDaoBtn.tag=indexPath.row;
                //                    NSLog(@"时间是%@",DataMedol.class_time);
                //                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    cell.QianDaoBtn.layer.masksToBounds=YES;
                //                    cell.QianDaoBtn.layer.cornerRadius=5;
                //                    cell.QianDaoBtn.layer.borderWidth=1;
                //                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                //                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                //                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                //                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                //                    return cell;
                if (btnindex<_date-1)
                {
                    
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"小课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.userInteractionEnabled=YES;
                    cell.QianDaoBtn.backgroundColor=[UIColor whiteColor];
                    
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                }
                
                
                
                
                if (btnindex==_date-1)
                {
                    if (miao == YES)
                        
                    {
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"小课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled=YES;
                        cell.QianDaoBtn.backgroundColor=[UIColor whiteColor];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                    }
                    
                    else
                    {
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"小课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled=NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                        //[cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                        
                    }
                    
                }
                else
                {
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"小课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    if (miao == YES) {
                        cell.QianDaoBtn.userInteractionEnabled=YES;
                        cell.QianDaoBtn.backgroundColor=[UIColor whiteColor];
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                        cell.QianDaoBtn.userInteractionEnabled = NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    }
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                    
                }
                
                
            }
            
            
            if (lea==-1&&rep==-1)
            {
                //                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                //                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                //                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                //                    cell.TimeLab.text=DataMedol.class_time;
                //                    cell.NameLab.text=DataMedol.name;
                //                    cell.KeLab.text=@"小课";
                //                    cell.DaiKeBtn.tag=indexPath.row;
                //                    cell.QinhJiaBtn.tag=indexPath.row;
                //                    cell.QianDaoBtn.tag=indexPath.row;
                //                    NSLog(@"时间是%@",DataMedol.class_time);
                //                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                //                    cell.QianDaoBtn.layer.masksToBounds=YES;
                //                    cell.QianDaoBtn.layer.cornerRadius=5;
                //                    cell.QianDaoBtn.layer.borderWidth=1;
                //                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                //                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                //                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                //                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                //                    return cell;
                if (btnindex<_date-1)
                {
                    
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"小课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    cell.QianDaoBtn.userInteractionEnabled = YES;
                    cell.QianDaoBtn.backgroundColor = [UIColor whiteColor];
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                }
                
                
                
                
                if (btnindex==_date-1)
                {
                    if (miao == YES)
                        
                    {
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"小课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled = YES;
                        cell.QianDaoBtn.backgroundColor = [UIColor whiteColor];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                    }
                    
                    else
                    {
                        TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                        cell.TimeLab.text=DataMedol.class_time;
                        cell.NameLab.text=DataMedol.name;
                        cell.KeLab.text=@"小课";
                        cell.DaiKeBtn.tag=indexPath.row;
                        cell.QinhJiaBtn.tag=indexPath.row;
                        cell.QianDaoBtn.tag=indexPath.row;
                        
                        NSLog(@"时间是%@",DataMedol.class_time);
                        [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.userInteractionEnabled=NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                        //[cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                        cell.QianDaoBtn.layer.masksToBounds=YES;
                        cell.QianDaoBtn.layer.cornerRadius=5;
                        cell.QianDaoBtn.layer.borderWidth=1;
                        
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                        [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                        [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                        return cell;
                        
                    }
                    
                }
                else
                {
                    TkechengbiaoableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell11111" forIndexPath:indexPath];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                    cell.TimeLab.text=DataMedol.class_time;
                    cell.NameLab.text=DataMedol.name;
                    cell.KeLab.text=@"小课";
                    cell.DaiKeBtn.tag=indexPath.row;
                    cell.QinhJiaBtn.tag=indexPath.row;
                    cell.QianDaoBtn.tag=indexPath.row;
                    
                    NSLog(@"时间是%@",DataMedol.class_time);
                    [cell.DaiKeBtn addTarget:self action:@selector(DaiKeclick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.QinhJiaBtn addTarget:self action:@selector(QinJiaclick:) forControlEvents:UIControlEventTouchUpInside];
                    if (miao == YES) {
                        cell.QianDaoBtn.userInteractionEnabled = YES;
                        cell.QianDaoBtn.backgroundColor = [UIColor whiteColor];
                        [cell.QianDaoBtn addTarget:self action:@selector(QianDaoclick:) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                        cell.QianDaoBtn.userInteractionEnabled = NO;
                        cell.QianDaoBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    }
                    cell.QianDaoBtn.layer.masksToBounds=YES;
                    cell.QianDaoBtn.layer.cornerRadius=5;
                    cell.QianDaoBtn.layer.borderWidth=1;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 243/255.0, 221/255.0, 151/255.0, 1 });
                    [cell.QianDaoBtn.layer setBorderColor:colorref];//边框颜色
                    [cell.QianDaoBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:221/255.0 blue:151/255.0 alpha:1] forState:UIControlStateNormal];
                    return cell;
                    
                }
                
                
            }
            
            
        }
        
        
        
        
        if ([status isEqualToString:@"2"])
        {
            KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.TimeLab.text=DataMedol.class_time;
            cell.NameLab.text=DataMedol.name;
            cell.yuyuebtn.tag=indexPath.row;
            [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
            [cell.yuyuebtn setTitle:@"开始上课" forState:UIControlStateNormal];
            cell.Kelab.text=@"小课";
            cell.yuyuebtn.layer.masksToBounds=YES;
            cell.yuyuebtn.layer.cornerRadius=5;
            cell.yuyuebtn.layer.borderWidth=1;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
            //cell.yuyuebtn.tag=104;
            [cell.yuyuebtn addTarget:self action:@selector(KaishiShangKeclick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }
        if ([status isEqualToString:@"3"])
        {
            if (lea==-1&&rep==-1)
            {
                
                
                
                
                
                KechengTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                [cell.yuyuebtn setTitle:@"提交记录" forState:UIControlStateNormal];
                [cell.yuyuebtn1 setTitle:@"评分" forState:UIControlStateNormal];
                
                cell.imaview.image=[UIImage imageNamed:@"Shenhe.png"];
                [cell.yuyuebtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                cell.yuyuebtn1.tag=indexPath.row;
                cell.yuyuebtn.tag=indexPath.row;
                [cell.yuyuebtn addTarget:self action:@selector(TiJiaoBaoGaoclick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.yuyuebtn1 addTarget:self action:@selector(PingFenclick:) forControlEvents:UIControlEventTouchUpInside];
                cell.Kelab.text=@"小课";
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                cell.yuyuebtn1.layer.masksToBounds=YES;
                cell.yuyuebtn1.layer.cornerRadius=5;
                cell.yuyuebtn1.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 240/255.0, 176/255.0, 155/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn1.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:240/255.0 green:176/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
                return cell;
                
                return cell;
                
            }
            else
            {
                KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
                cell.TimeLab.text=DataMedol.class_time;
                cell.NameLab.text=DataMedol.name;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (reportInt == 0) {
                    [cell.yuyuebtn setTitle:@"记录审核中" forState:UIControlStateNormal];
                }else if (reportInt == 1){
                    [cell.yuyuebtn setTitle:@"课程结束" forState:UIControlStateNormal];
                }
                else{
                    [cell.yuyuebtn setTitle:@"记录被拒绝" forState:UIControlStateNormal];
                }
                cell.Kelab.text=@"小课";
                [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
                cell.yuyuebtn.layer.masksToBounds=YES;
                cell.yuyuebtn.layer.cornerRadius=5;
                cell.yuyuebtn.layer.borderWidth=1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
                [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
                [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
                cell.yuyuebtn.userInteractionEnabled=NO;
                
                return cell;
                
            }
            
        }
        else
        {
            KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.TimeLab.text=DataMedol.class_time;
            cell.NameLab.text=DataMedol.name;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (reportInt == 0) {
                [cell.yuyuebtn setTitle:@"记录审核中" forState:UIControlStateNormal];
            }else if (reportInt == 1){
                [cell.yuyuebtn setTitle:@"课程结束" forState:UIControlStateNormal];
            }
            else{
                [cell.yuyuebtn setTitle:@"记录被拒绝" forState:UIControlStateNormal];
            }
            cell.Kelab.text=@"小课";
            [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
            cell.yuyuebtn.layer.masksToBounds=YES;
            cell.yuyuebtn.layer.cornerRadius=5;
            cell.yuyuebtn.layer.borderWidth=1;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
            [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
            [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
            cell.yuyuebtn.userInteractionEnabled=NO;
            
            return cell;
            
            
        }
        
    }
    
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[DeteArry objectAtIndex:indexPath.row];
    DataReauest *DataMedol=[[DataReauest alloc]initWithDictiory:dic];
    NSLog(@"%@",DataMedol.cid);
    NSLog(@"%d",DataMedol.HdID);
    NSString *kecid=[NSString stringWithFormat:@"%@",DataMedol.cid];
    [[NSUserDefaults standardUserDefaults]setObject:kecid forKey:@"kecid"];
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KechengXiangQingViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"KechengXiangQingViewController"];
    
    // KechengXiangQingViewController *controller=[[KechengXiangQingViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];
}


-(void)getCellType{
    //    KechengaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell21" forIndexPath:indexPath];
    //    cell.TimeLab.text=DataMedol.class_time;
    //    cell.NameLab.text=DataMedol.name;
    //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //    [cell.CellImgview sd_setImageWithURL:[NSURL URLWithString:DataMedol.img] placeholderImage:nil];
    //    [cell.yuyuebtn setTitle:@"申请审核中" forState:UIControlStateNormal];
    //    cell.yuyuebtn.userInteractionEnabled=NO;
    //    cell.Kelab.text=@"大课";
    //    cell.yuyuebtn.layer.masksToBounds=YES;
    //    cell.yuyuebtn.layer.cornerRadius=5;
    //    cell.yuyuebtn.layer.borderWidth=1;
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 157/255.0, 202/255.0, 239/255.0, 1 });
    //    [cell.yuyuebtn.layer setBorderColor:colorref];//边框颜色
    //    [cell.yuyuebtn setTitleColor:[UIColor colorWithRed:157/255.0 green:202/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
    //    NSLog(@"时间是%@",DataMedol.class_time);
    //    return cell;
}



@end
