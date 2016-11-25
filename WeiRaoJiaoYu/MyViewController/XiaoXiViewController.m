//
//  XiaoXiViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/25.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "AFNetworking.h"
#import "MessageTableViewCell.h"
#import "DataReauest.h"
@interface XiaoXiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArry;
}

@property (weak, nonatomic) IBOutlet UITableView *TableView;
@end

@implementation XiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _TableView.rowHeight=70;
    self.tabBarController.tabBar.hidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/message?id=%@",ShareS.uid];
     AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        dataArry=[responseObject objectForKey:@"data"];
        _TableView.delegate=self;
        _TableView.dataSource=self;
        [_TableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_TableView  setTableFooterView:view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    // Do any additional setup after loading the view from its nib.
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
    MessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    DataReauest *Request=[[DataReauest alloc]initWithDictiory:dic];
    cell.TimeLab.text=Request.time;
    cell.TextLab.text=Request.content;
    return cell;
}
- (IBAction)Btnclick:(UIButton *)sender {
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
