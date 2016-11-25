//
//  PeasonViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/10.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "PeasonViewController.h"
#import "SVProgressHUD.h"
#import "HeadPortraitModel.h"
typedef NS_ENUM(NSInteger,ChosePhontType)
{
    
    ChosePhontTypeAlbum,
    ChosePhontTypeCamera

};
@interface PeasonViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker *picker1;
    UIView *dateview;
     UIView *dateview1;
    NSArray *sexArry;
    UIPickerView *sexpicker;
}
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UILabel *SexLab;
@property (weak, nonatomic) IBOutlet UILabel *BirthDayLab;
@property (weak, nonatomic) IBOutlet UIImageView *Touxiang;
@property (nonatomic, strong)HeadPortraitModel *headP;

@property (nonatomic, copy) NSString *headImg;
@end

@implementation PeasonViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_Touxiang sd_setImageWithURL:[NSURL URLWithString:ShareS.headImgUrl] placeholderImage:nil];
    
    _PhoneNumber.text=ShareS.phone;
    _Name.text=ShareS.name;
    _BirthDayLab.text=ShareS.birthday;
    if ([ShareS.sex isEqualToString:@"1"])
    {
        _SexLab.text=@"男";
    }
    else
    {
        _SexLab.text=@"女";
    }

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headPortrait:) name:@"headPortraitInfoList" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiugaiziliao:) name:@"xiugaiziliaoInfolist" object:nil];
}
//移除通知
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"vv%@",ShareS.headImgUrl);
    [_Touxiang sd_setImageWithURL:[NSURL URLWithString:ShareS.headImgUrl] placeholderImage:nil];
    _PhoneNumber.text=ShareS.phone;
    _PhoneNumber.enabled = NO;
    _Name.text=ShareS.name;
    _BirthDayLab.text=ShareS.birthday;
    if ([ShareS.sex isEqualToString:@"1"])
    {
        _SexLab.text=@"男";
    }
    else
    {
        _SexLab.text=@"女";
    }
    sexArry=@[@"男",@"女"];
     _headP = [[HeadPortraitModel alloc]init];
    _Touxiang.layer.masksToBounds=YES;
    _Touxiang.layer.cornerRadius=50;
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    _SexLab.userInteractionEnabled=YES;
    _BirthDayLab.userInteractionEnabled=YES;
   //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headPortraitInfoList1:) name:@"headPortraitInfoList" object:nil];
    [_SexLab  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory)]];
    [_BirthDayLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory1)]];
    
    // Do any additional setup after loading the view from its nib.
}
//头像
- (void)headPortrait:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]){
        _headImg = bitice.userInfo[@"data"];
        [_Touxiang sd_setImageWithURL:[NSURL URLWithString:_headImg] placeholderImage:nil];
    }
}
//修改信息
- (void)xiugaiziliao:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]){
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        ShareS.headImgUrl = _headImg;
        ShareS.name = _Name.text;
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [SVProgressHUD showSuccessWithStatus:bitice.userInfo[@"msg"]];
    }
}

- (void)KaiShiShangke11
{
    
}
- (void)KaiShiShangke22
{
    
}

- (void)clickCategory
{
    dateview1=[[UIView alloc]initWithFrame:CGRectMake(10, 80,WIDTH-20, 300)];
    dateview1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:dateview1];
    sexpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, WIDTH-20, 250)];
    sexpicker.delegate=self;
    sexpicker.dataSource=self;
    [dateview1 addSubview:sexpicker];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, 270, WIDTH-50, 30);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor=XN_COLOR_GREEN_MINT;
    [dateview1 addSubview:btn];
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[sexArry objectAtIndex:row];
    return str;
}

- (void)clickCategory1
{
   dateview=[[UIView alloc]initWithFrame:CGRectMake(10, 80,WIDTH-20, 300)];
    dateview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:dateview];
    picker1 = [[UIDatePicker alloc] init];
    picker1.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    picker1.frame=CGRectMake(0, 0, WIDTH-20, 250);
    //picker.backgroundColor=[UIColor grayColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, 270, WIDTH-50, 30);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor=XN_COLOR_GREEN_MINT;
    [dateview addSubview:btn];
    picker1.datePickerMode =   UIDatePickerModeDate;
    [dateview addSubview:picker1];
    

    NSLog(@"修改生日");
}
- (void)click1
{
    NSInteger showRow = [sexpicker selectedRowInComponent:0];
    NSString *mytextshow = [sexArry objectAtIndex:showRow];
    _SexLab.text = mytextshow;
    if ([_SexLab.text isEqualToString:@"女"])
    {
        ShareS.sex=@"2";
    }
    else{
        ShareS.sex=@"1";
    }
    [dateview1 removeFromSuperview];
}
- (void)click
{
    NSDate *date=picker1.date;
    NSDateFormatter *dateformate = [[NSDateFormatter alloc] init ];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *showdate =[dateformate stringFromDate:date];

    NSLog(@"日期是%@",showdate);
    _BirthDayLab.text=showdate;
    ShareS.birthday=_BirthDayLab.text;
    [dateview removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Btnclick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Queren:(UIButton *)sender
{
    NSLog(@"%@,%@,%@,%@,%@",ShareS.headImgUrl,ShareS.name,ShareS.sex,ShareS.birthday,ShareS.uid);
    if (_headImg.length == 0) {
        _headImg = ShareS.headImgUrl;
    }
    [_headP xiugaiziliaoInfolist:_headImg Name:_Name.text Sex:ShareS.sex Birthday:ShareS.birthday aId:ShareS.uid];
    
}
- (IBAction)XiuGaiTouXiang:(UIButton *)sender {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择相片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosePhoto:ChosePhontTypeAlbum];
    }];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosePhoto:ChosePhontTypeCamera];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:album];
    [alert addAction:camera];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{
        self.hidesBottomBarWhenPushed = YES;
        
    }];

}
- (void)chosePhoto:(ChosePhontType)type
{
    UIImagePickerController * piker = [[UIImagePickerController alloc]init];
    piker.allowsEditing = YES;
    piker.delegate = self;
    
    if (type == ChosePhontTypeAlbum) {
        piker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if(type == ChosePhontTypeCamera)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            piker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
            return;
        }
    }
    
    //[self presentViewController:piker animated:YES completion:nil];
    [self presentViewController:piker animated:YES completion:^{
        self.hidesBottomBarWhenPushed = YES;
    }];
    
    
}

#pragma mark - 选择图片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _Touxiang.image = info[UIImagePickerControllerOriginalImage];
    NSData * imgData = nil;
    
    if (UIImagePNGRepresentation(_Touxiang.image)) {
        imgData = UIImagePNGRepresentation(_Touxiang.image);
    }else if (UIImageJPEGRepresentation(_Touxiang.image, 1))
    {
        imgData = UIImageJPEGRepresentation(_Touxiang.image, 1);
    }
    
    //压缩处理
    imgData = UIImageJPEGRepresentation(_Touxiang.image, 0.00001);
    
    //将图片尺寸变小
    UIImage * theImg = [self zipImageWithData:imgData limitedWith:140];
    [self saveImage:theImg WithName:@"userAvatar"];
    //[picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.tabBarController.tabBar.hidden=YES;
    }];
    
    
    
}

////取消选择
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}


//从document取得图片
//- (UIImage *)getImage:(NSString *)urlStr
//{
//    return [UIImage imageWithContentsOfFile:urlStr];
//}

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

//保存图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    
    NSLog(@"%@",tempImage);
    
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    
    //保存到 NSUserDefaults
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setObject:totalPath forKey:@"avatar"];
    //    NSString *string = [userDefaults objectForKey:@"avatar"];
    //    _usericon.image = [UIImage imageWithContentsOfFile:string];
    //上传头像
    [_headP headPortraitInfoList:imageData];
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
