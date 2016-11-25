//
//  SheTuanJianSheBiaoViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "SheTuanJianSheBiaoViewController.h"
#import "KechengMedol.h"
#import "DataReauest.h"
@interface SheTuanJianSheBiaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UILabel *PeopleNumber;
@property (weak, nonatomic) IBOutlet UILabel *GuanLiLab;
@property (weak, nonatomic) IBOutlet UILabel *KemuLab;

@end

@implementation SheTuanJianSheBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [KechengMedol requsetWithSheTuanJianShe:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        NSDictionary *dataDic=[responseDic objectForKey:@"data"];
        DataReauest *request=[[DataReauest alloc]initWithDictiory:dataDic];
        _NameLab.text=request.name;
        _TimeLab.text=request.create_time;
        _PeopleNumber.text=request.studentNum;
        _GuanLiLab.text=request.admin;
        _KemuLab.text=request.subjectNum;
    }];
    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clcik:(UIButton *)sender {
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
