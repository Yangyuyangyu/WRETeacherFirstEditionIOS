//
//  DaiKeViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "DaiKeViewController.h"
#import "KechengMedol.h"
#import "LTableViewCell.h"
#import "LYTableViewCell.h"
#import "Model.h"
#import "CZCover.h"
#import "AFNetworking.h"
static NSString *identify2 = @"CELL";
@interface DaiKeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UITextViewDelegate>
{
    LYTableViewCell *cell;
    NSArray *projectArray;
    NSArray *dataArry;
    UIAlertView*alertview111;;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UITextField *PhoneText;
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *ZhangHaoText;
@property (weak, nonatomic) IBOutlet UIButton *ZhuangTaiBtn;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
- (IBAction)Liexing:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (weak, nonatomic) IBOutlet UITextField *MimaText;
@property (nonatomic,strong) NSMutableArray *arrays;
@property (nonatomic,strong) Model *selectModel;
@property(assign, nonatomic)NSInteger clickCount;
@property (nonatomic, strong)UITableView *projectTab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line;

@property (nonatomic, assign) NSInteger number;

@end

@implementation DaiKeViewController
-(NSMutableArray *)arrays{
    
    if (!_arrays) {
        
        _arrays = [NSMutableArray array];
        
    }
    //http://www.weiraoedu.com/Api/TeacherApi/getTeacher
    return _arrays;
    
}

- (IBAction)Btnclick:(UIButton *)sender
{
    NSString *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSLog(@"%@",name);
    NSLog(@"%@",phone);
    
    if (name.length == 0 || phone.length == 0) {
        //提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请先选择代课老师" preferredStyle:UIAlertControllerStyleAlert];
        //添加行为
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (_TextView.text.length==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入备注" preferredStyle:UIAlertControllerStyleAlert];
        //添加行为
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (_PhoneText.text.length>11)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入11位键盘" preferredStyle:UIAlertControllerStyleAlert];
        //添加行为
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        NSString *DaiKeId=[[NSUserDefaults standardUserDefaults]objectForKey:@"DaiKekid"];
        NSString *reason=projectArray[_number];
        NSLog(@"%@",reason);
        NSString *Id=[[NSUserDefaults standardUserDefaults]objectForKey:@"Id"];
        //[KechengMedol DaikeRequestReason:reason Account:name Pass:phone Remark:_TextView.text Cid:DaiKeId ID:ShareS.uid];
        [KechengMedol DaikeRequestReason:reason Account:name Pass:phone Remark:_TextView.text Cid:DaiKeId ID:ShareS.uid Tid:Id];
        NSLog(@"代课的id是 %@",DaiKeId);
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    _NameText.delegate=self;
    //    _PhoneText.delegate=self;
    _PhoneText.keyboardType=UIKeyboardTypeNumberPad;
    _TextView.delegate = self;
    NSNotificationCenter *fictionCenter=[NSNotificationCenter defaultCenter];
    [fictionCenter addObserver:self selector:@selector(automaticLogin1) name:@"KaiShiShangKelou" object:nil];
    dataArry=[[NSArray alloc]init];
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/getTeacher?id=%@",ShareS.uid];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"默认老师%@",responseObject);
        dataArry=[responseObject objectForKey:@"data"];
        self.tabBarController.tabBar.hidden=YES;
        _TableView.delegate=self;
        _TableView.dataSource=self;
        _TableView.rowHeight = 50;
        projectArray = @[@"病假",@"事假",@"其他"];
        _number = 0;
        [_TableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_TableView setTableFooterView:view];
        for (int i = 0; i < 99; i++) {
            Model *model = [[Model alloc] init];
            [self.arrays addObject:model];
        }
        
        
        
        _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark--UITextViewDelegate


//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = _TextView.superview.frame;
    int offset = frame.origin.y + 300 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0){
        _line.constant = -offset;
    }
    [UIView commitAnimations];
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView
{
    double duration = 0.30f;
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        _line.constant = 14;
    }];
}


- (IBAction)SouSUo:(UIButton *)sender
{
    AFHTTPSessionManager *senssion=[AFHTTPSessionManager manager];
    NSLog(@"%@%@",_NameText.text,_PhoneText.text);
    
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/getTeacher?id=%@&name=%@&mobile=%@",ShareS.uid,_NameText.text,_PhoneText.text];
    [senssion GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@搜索老师%@",urlstr,responseObject);
        NSString *str=[responseObject objectForKey:@"msg"];
        alertview111=[[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [alertview111 show];
        
        dataArry=[responseObject objectForKey:@"data"];
        [_TableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
////    NSString *str = [NSString stringWithFormat:@"%ld",_number];
////    NSLog(@"vvvv%ld",(long)_number);
////    NSString *text=[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
////    NSLog(@"filed 的只是%@",textField.text);
////    [KechengMedol Seacher:str Name:text Page:@"0"];
////
////    // _recommended = YES;
////    [_BigTextView resignFirstResponder];
//
//    return YES;
//}

- (void)automaticLogin1
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return 3;
    }
    return dataArry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identify2];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
        }
        cell1.textLabel.text = projectArray[indexPath.row];
        cell1.textLabel.font = [UIFont systemFontOfSize:14];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
        NSString *name=[dic objectForKey:@"name"];
        NSString *phone=[dic objectForKey:@"phone"];
        cell.NameLab.text=name;
        cell.PhoneLab.text=phone;
        [cell.btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn.tag = indexPath.row;
        cell.clickCount=indexPath;
        Model *model =self.arrays[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell cellWithData:model];
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100)
    {
        UITableViewCell *cell111=[tableView cellForRowAtIndexPath:indexPath];
        _number = indexPath.row;
        //NSLog(@"%@",cell.textLabel.text);
        [_ZhuangTaiBtn setTitle:cell111.textLabel.text forState:UIControlStateNormal];
        [tableView removeFromSuperview];
    }
    
    
    
}

-(void)ClickBtn:(UIButton *)btn
{
    
    NSLog(@"你选了第%ld行",(long)btn.tag);
    
    //NSLog(@"%@",cell.clickCount);
    NSDictionary *dic=[dataArry objectAtIndex:btn.tag];
    NSString *name=[dic objectForKey:@"name"];
    NSString *phone=[dic objectForKey:@"phone"];
    NSString *Id=[dic objectForKey:@"id"];
    NSLog(@"%@",name);
    NSLog(@"%@",phone);
    NSLog(@"%@",Id);
    [[NSUserDefaults standardUserDefaults]setObject:Id forKey:@"Id"];
    
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:@"phone"];
    if (self.selectModel) {
        self.selectModel.isSelected = !self.selectModel.isSelected;
    }
    Model *model = self.arrays[btn.tag];
    if (!model.isSelected) {
        model.isSelected = !model.isSelected;
        self.selectModel = model;
    }
    
    [_TableView reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)performDismiss:(NSTimer*)timer

{
    
    [alertview111 dismissWithClickedButtonIndex:0 animated:NO];
    
}
- (IBAction)Fanhui:(UIButton *)sender {
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

- (IBAction)Liexing:(UIButton *)sender
{
    [_ReasonView addSubview:self.projectTab];
}
- (UITableView *)projectTab{
    if (!_projectTab)
    {
        _projectTab = [[UITableView alloc]initWithFrame:CGRectMake(300, CGRectGetMaxY(_ZhuangTaiBtn.frame) + 10, 100, 75)];
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


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    
    [self.view endEditing:YES];
}
@end
