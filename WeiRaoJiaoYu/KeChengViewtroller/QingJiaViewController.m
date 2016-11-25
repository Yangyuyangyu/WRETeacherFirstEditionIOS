//
//  QingJiaViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "QingJiaViewController.h"
#import "KechengMedol.h"

static NSString *identify2 = @"CELL";
@interface QingJiaViewController ()<UITableViewDelegate ,UITableViewDataSource>{
    NSArray *projectArray;
}
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (weak, nonatomic) IBOutlet UILabel *binjia;

@property (nonatomic, strong)UITableView *projectTab;

@end

@implementation QingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
    projectArray = @[@"病假",@"事假",@"其他"];
}
- (IBAction)TiJIao:(UIButton *)sender
{
   NSString *kid= [[NSUserDefaults standardUserDefaults]objectForKey:@"QinJiakid"];
    [KechengMedol QingJiaRequestReason:_binjia.text Remark:_TextView.text ID:ShareS.uid Class_id:kid];
}
- (IBAction)Fanhui:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)bingjia:(UIButton *)sender {
    [self.view addSubview:self.projectTab];
}

- (UITableView *)projectTab{
    if (!_projectTab)
    {
        _projectTab = [[UITableView alloc]initWithFrame:CGRectMake(300, 120, 100, 90)];
        _projectTab.tableFooterView = [[UIView alloc] init];
        _projectTab.dataSource = self;
        _projectTab.delegate = self;
        [_projectTab setSeparatorInset:UIEdgeInsetsMake(0,-60,0,0)];
        _projectTab.rowHeight = 30;
        _projectTab.scrollEnabled = NO;
    }
    return _projectTab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identify2];
    if (!cell1) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
    }
    cell1.textLabel.text = projectArray[indexPath.row];
    cell1.textLabel.font = [UIFont systemFontOfSize:14];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;

   
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell111=[tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"%@",cell.textLabel.text);
    _binjia.text = cell111.textLabel.text;
    [tableView removeFromSuperview];

}

@end
