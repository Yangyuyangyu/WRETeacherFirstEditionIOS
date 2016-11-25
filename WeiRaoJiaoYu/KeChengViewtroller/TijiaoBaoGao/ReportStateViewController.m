//
//  ReportStateViewController.m
//  MyFamily
//
//  Created by 陆洋 on 15/7/3.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "ReportStateViewController.h"
#import "UITableView+Improve.h"
#import "UIImage+ReSize.h"
#import "PrefixHeader.pch"

#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"

#import "ReportStateTableViewCell.h"
#import "TeacherTableViewCell.h"
#import "AFNetworking.h"
#import "KechengMedol.h"
#import "SVProgressHUD.h"
#import "Repair.h"

@interface ReportStateViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *IdArry;
    NSMutableArray *imageArray;
}
@property (weak, nonatomic) IBOutlet UILabel *Namelab;
@property (nonatomic,weak)UITextView *reportStateTextView;
@property (nonatomic,weak)UILabel *pLabel;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;
@property (nonatomic,weak)UIButton *addPictureButton;
@property (nonatomic,weak)ImagePickerChooseView *IPCView;
@property (nonatomic,strong)AGImagePickerController *imagePicker;

@property (nonatomic, strong) Repair *repair;

@property(nonatomic,strong)   NSString* date;

//imagePicker队列
@property (nonatomic,strong)NSMutableArray *imagePickerArray;

@property (nonatomic, assign) NSInteger number;
@end

@implementation ReportStateViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(takingPictures:) name:@"takingPicturesInfoList" object:nil];
    
    //通知传值
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moreImgUpload:) name:@"moreImgUploadInfokInfoList" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(report:) name:@"reportInfoList" object:nil];
}
//移除通知
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    IdArry=[[NSMutableArray alloc]init];
    
    _repair = [[Repair alloc] init];
    imageArray = [NSMutableArray array];
    
    [_Tableview improveTableView];
    _Tableview.delegate=self;
    _Tableview.dataSource=self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardDismiss:)];
    tap.delegate = self;
    [_Tableview registerNib:[UINib nibWithNibName:@"ReportStateTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_Tableview registerNib:[UINib nibWithNibName:@"TeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_Tableview addGestureRecognizer:tap];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    _date = [formatter stringFromDate:[NSDate date]];
    
    [self initHeaderView];
    
    
}

- (void)takingPictures:(NSNotification *)bitice{
    if ([self.reportStateTextView isFirstResponder]) {
        [self.reportStateTextView resignFirstResponder];
    }
    [self initImagePickerChooseView];
}
//提交照片
- (void)moreImgUpload:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]) {
        [imageArray addObject:bitice.userInfo[@"data"]];
        if (imageArray.count == self.imagePickerArray.count) {
            NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
            NSString *content = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,0]];
            NSString *problem = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,1]];
            NSString *solution = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,2]];
            NSString *work = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,10]];
            NSMutableString *mutaStr = [NSMutableString string];
            
            for (int i = 0; i < imageArray.count; i ++) {
                if (i == imageArray.count) {
                    NSString *img = [NSString stringWithFormat:@"%@",imageArray[i]];
                    [mutaStr appendString:img];
                }else{
                    NSString *img = [NSString stringWithFormat:@"%@,",imageArray[i]];
                    [mutaStr appendString:img];
                }
                
            }
            NSLog(@"%@",mutaStr);
            NSString *img = (NSString *)mutaStr;
            [_repair reportInfoList:content problem:problem solution:solution homework:@"1" work:work img:img];
        }
    }else{
        [self tooltip:bitice.userInfo[@"msg"]];
    }
}
//提交报告
- (void)report:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]) {
        NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
        [[NSUserDefaults standardUserDefaults] setObject:@"xiao" forKey:cid];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",cid,self.reportStateTextView.tag]]);
        for (int i = 0; i < 4; i ++) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@%d",cid,i]];
        }
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }else{
        [SVProgressHUD dismiss];
        [self tooltip:bitice.userInfo[@"msg"]];
        
    }
}
#define textViewHeight 100
#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 9
#define deleImageWH 25 // 删除按钮的宽高
//大图特别耗内存，不能把大图存在数组里，存类型或者小图
-(void)initHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    UITextView *reportStateTextView = [[UITextView alloc]initWithFrame:CGRectMake(padding, padding, screenWidth - 2*padding, textViewHeight)];
    reportStateTextView.text = self.reportStateTextView.text;  //防止用户已经输入了文字状态
    reportStateTextView.returnKeyType = UIReturnKeyDone;
    reportStateTextView.font = [UIFont systemFontOfSize:15];
    self.reportStateTextView = reportStateTextView;
    self.reportStateTextView.delegate = self;
    self.reportStateTextView.tag = 10;
    NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:cid]) {
        self.reportStateTextView.text = @"";
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"%@%d",cid,10]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:cid];
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",cid,self.reportStateTextView.tag]]) {
            self.reportStateTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",cid,self.reportStateTextView.tag]];
        }
    }
    
    [headView addSubview:reportStateTextView];
    
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding+5, 2 * padding, screenWidth, 10)];
    pLabel.text = @"请输入作业";
    pLabel.hidden = [self.reportStateTextView.text length];
    pLabel.font = [UIFont systemFontOfSize:15];
    pLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
    self.pLabel = pLabel;
    [headView addSubview:pLabel];
    
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding), CGRectGetMaxY(reportStateTextView.frame) + padding +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.frame = CGRectMake(pictureHW - deleImageWH , -5, deleImageWH + 5, deleImageWH + 5);
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [pictureImageView addSubview:dele];
        
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        pictureImageView.image = self.imagePickerArray[i];
        [headView addSubview:pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), CGRectGetMaxY(reportStateTextView.frame) + padding +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"addPictures"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
    }
    NSLog(@"%@",self.imagePickerArray);
    NSInteger headViewHeight = 120 + (10 + pictureHW)*([self.imagePickerArray count]/4 + 1);
    headView.frame = CGRectMake(0, 0, screenWidth, headViewHeight);
    _Tableview.tableFooterView = headView;
}

#pragma mark - addPicture
-(void)addPicture
{
    if ([self.reportStateTextView isFirstResponder]) {
        [self.reportStateTextView resignFirstResponder];
    }
    
    //_Tableview.scrollEnabled = NO;
    [self initImagePickerChooseView];
}

#pragma mark - gesture method
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImage"];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.imagePickerArray;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - keyboard method
-(void)keyboardDismiss:(UITapGestureRecognizer *)tap
{
    [self.reportStateTextView resignFirstResponder];
}

// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btn.superview;
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        [imageView removeFromSuperview];
    }
    [self initHeaderView];
}

#define IPCViewHeight 120
-(void)initImagePickerChooseView
{
    ImagePickerChooseView *IPCView = [[ImagePickerChooseView alloc]initWithFrame:CGRectMake(0, screenHeight - 64, screenWidth, IPCViewHeight) andAboveView:self.view];
    //IPCView.frame = CGRectMake(0, screenHeight - IPCViewHeight - 64, screenWidth, IPCViewHeight);
    if (ShareS.isZero == YES) {
        UIImagePickerController * piker = [[UIImagePickerController alloc]init];
        piker.allowsEditing = YES;
        piker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            piker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
            return;
        }
        [self presentViewController:piker animated:YES completion:^{
        }];
    }else{
        [IPCView setImagePickerBlock:^{
            self.imagePicker = [[AGImagePickerController alloc] initWithFailureBlock:^(NSError *error) {
                
                if (error == nil)
                {
                    [self dismissViewControllerAnimated:YES completion:^{}];
                    [self.IPCView disappear];
                } else
                {
                    NSLog(@"Error: %@", error);
                    
                    // Wait for the view controller to show first and hide it after that
                    double delayInSeconds = 0.5;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self dismissViewControllerAnimated:YES completion:^{}];
                    });
                }
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                
            } andSuccessBlock:^(NSArray *info) {
                NSMutableArray *mutArray = [NSMutableArray array];
                for (int i = 0; i < info.count; i ++) {
                    //ALAsset提取UIImage
                    UIImage *tempImg=[UIImage imageWithCGImage:((ALAsset *)[info objectAtIndex:i]).aspectRatioThumbnail];
                    [mutArray addObject:tempImg];
                }
                
                
                [self.imagePickerArray addObjectsFromArray:mutArray];
                [self dismissViewControllerAnimated:YES completion:^{}];
                [self.IPCView disappear];
                [self initHeaderView];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
            
            self.imagePicker.maximumNumberOfPhotosToBeSelected = 9 - [self.imagePickerArray count];
            
            [self presentViewController:self.imagePicker animated:YES completion:^{}];
        }];
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        IPCView.frame = CGRectMake(0, screenHeight - IPCViewHeight-64, screenWidth, IPCViewHeight);
    } completion:^(BOOL finished) {
    }];
    [self.view addSubview:IPCView];
    self.IPCView = IPCView;
    
    //不能添加约束，因为会导致frame暂时为0，后面的tableview cellfor......不会执行
    //添加约束
    /*self.IPCView.translatesAutoresizingMaskIntoConstraints = NO;
     NSArray *IPCViewConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_IPCView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_IPCView)];
     [self.view addConstraints:IPCViewConstraintH];
     
     NSArray *IPCViewConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_IPCView(60)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_IPCView)];
     [self.view addConstraints:IPCViewConstraintV];*/
    
    [self.IPCView addImagePickerChooseView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImageView *headpic = [[UIImageView alloc] init];
    headpic.image = info[UIImagePickerControllerOriginalImage];
    NSData * imgData = nil;
    
    if (UIImagePNGRepresentation(headpic.image)) {
        imgData = UIImagePNGRepresentation(headpic.image);
    }else if (UIImageJPEGRepresentation(headpic.image, 1))
    {
        imgData = UIImageJPEGRepresentation(headpic.image, 1);
    }
    
    //压缩处理
    imgData = UIImageJPEGRepresentation(headpic.image, 0.00001);
    
    //将图片尺寸变小
    UIImage * theImg = [self zipImageWithData:imgData limitedWith:340];
    [self saveImage:theImg WithName:@"userAvatar"];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
}
//压缩处理
- (UIImage *)zipImageWithData:(NSData *)imgData limitedWith:(CGFloat)width
{
    //获取图片
    UIImage * img = [UIImage imageWithData:imgData];
    
    CGSize oldImgSize = img.size;
    
    if (width > oldImgSize.width) {
        width = oldImgSize.width;
    }
    
    CGFloat newHeight = oldImgSize.height *((CGFloat)width / oldImgSize.width);
    
    //创建新的图片大小
    CGSize size = CGSizeMake(width, newHeight);
    
    //开启一个图片句柄
    UIGraphicsBeginImageContext(size);
    
    //将图片画入新的size
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //将图片句柄中获取一张新的图片
    UIImage * newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片句柄
    UIGraphicsEndImageContext();
    
    return newImg;
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    
    [self.addPictureButton setBackgroundImage:[UIImage imageWithContentsOfFile:totalPath] forState:UIControlStateNormal];
    NSLog(@"%@",totalPath);
    [self.imagePickerArray addObject:tempImage];
    _number = [self.imagePickerArray count];
    [self.IPCView disappear];
    [self initHeaderView];
    ShareS.isZero = NO;
    //保存到 NSUserDefaults
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setObject:totalPath forKey:@"avatar"];
    //    NSString *string = [userDefaults objectForKey:@"avatar"];
    //    _usericon.image = [UIImage imageWithContentsOfFile:string];
}

-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}
#pragma mark - UIGesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.pLabel.hidden = [textView.text length];
}
//
//
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text])
    {
        if (textView.tag != 10) {
            return YES;
        }else{
            if ([self.reportStateTextView.text length]) {
                [self.reportStateTextView resignFirstResponder];
            }
            else
            {
                return NO;
            }
        }
        
    }
    return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==0)
    {
        return 1;
    }
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    if (indexPath.section==0)
    {
        TeacherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.Namelab.text=_date;
        
        return cell;
    }
    else
    {
        ReportStateTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.TextView.delegate = self;
        cell.TextView.tag = indexPath.row;
        NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",cid,indexPath.row]]) {
            cell.TextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",cid,indexPath.row]];
        }
        if (indexPath.row==0)
        {
            cell.Namelab.text=@"课堂重点";
            
        }
        if (indexPath.row==1)
        {
            cell.Namelab.text=@"上课情况及问题";
        }
        if (indexPath.row==2)
        {
            cell.Namelab.text=@"建议办法";
        }
        if (indexPath.row==3)
        {
            TeacherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.Namelab.text=@"课后作业";
        }
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    else
    {
        return 1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        if (indexPath.row==3)
        {
            return 44;
        }
        return 115;
    }
    else
    {
        return 44;
    }
}

//提交
- (IBAction)Tijiao:(UIButton *)sender
{
    NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
    // NSLog(@"%@",Id);
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *urlstr=[NSString stringWithFormat:@"http://www.weiraoedu.com/Api/TeacherApi/studentOfCourse?id=%@",cid];
    NSLog(@"%@",urlstr);
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    
    [session GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary*dataDic=[responseObject objectForKey:@"data"];
        NSArray *dataArry=[dataDic objectForKey:@"student"];
        for (int i=0; i<dataArry.count; i++)
        {
            NSDictionary *dic=[dataArry objectAtIndex:i];
            //                NSString *name=[dic objectForKey:@"name"];
            //                NSString *Id=[dic objectForKey:@"id"];
            NSString *score=[dic objectForKey:@"score"];
            [IdArry addObject:score];
        }
        if (IdArry.count!=0)
        {
            NSString *kong=@"";
            if ([IdArry containsObject:kong])
            {
                [self tooltip:@"你还有学生没有评分"];
            }
            else
            {
                [SVProgressHUD showWithStatus:@"努力提交中..."];
                if (self.imagePickerArray.count == 0) {
                    NSString *content = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,0]];
                    NSString *problem = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,1]];
                    NSString *solution = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,2]];
                    NSString *work = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%d",cid,10]];
                    NSString *homework = @"";
                    if (work.length == 0) {
                        homework = @"0";
                    }else{
                        homework = @"1";
                    }
                    [_repair reportInfoList:content problem:problem solution:solution homework:homework work:work img:@""];
                }else{
                    for (int i = 0; i < self.imagePickerArray.count; i ++) {
                        NSData* imageData = UIImagePNGRepresentation(self.imagePickerArray[i]);
                        [_repair moreImgUploadInfokInfoList:imageData];
                    }
                }
                
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark--UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    if (textView.tag == 10) {
        frame = textView.superview.frame;
    }else{
        frame = textView.superview.superview.superview.frame;
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 216, 0.0);
    
    int offset = frame.origin.y - (self.view.frame.size.height - 216.0);//键盘高度216
    _Tableview.contentInset = contentInsets;
    _Tableview.scrollIndicatorInsets = contentInsets;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if (textView.tag == 0 || textView.tag == 1) {
        return;
    }
    CGPoint scrollPoint = CGPointMake(0.0, offset + 210);
    [_Tableview setContentOffset:scrollPoint animated:YES];
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSString *cid=[[NSUserDefaults standardUserDefaults]objectForKey:@"TiJiaoBaoGaokid"];
    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:[NSString stringWithFormat:@"%@%ld",cid,textView.tag]];
    
    double duration = 0.30f;
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        _Tableview.contentInset = contentInsets;
        _Tableview.scrollIndicatorInsets = contentInsets;
    }];
}


- (IBAction)FanHui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
@end
