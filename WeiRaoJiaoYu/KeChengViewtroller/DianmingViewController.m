//
//  DianmingViewController.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/5/4.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "DianmingViewController.h"
#import "CollectionViewCell.h"
#import "KechengMedol.h"
#import "DataReauest.h"
#import "Repair.h"

@interface DianmingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    // NSArray *DataArry;
    NSArray *dataArry;
    NSString *couseid;
    NSMutableArray *Presentarry;
    NSMutableArray *Absentarry;
    
    NSMutableArray *backArray;
    
}
@property (weak, nonatomic) IBOutlet UIView *NaView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectview;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong)Repair *repair;

@end

@implementation DianmingViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)automaticLogin1
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Presentarry=[[NSMutableArray alloc]init];
    
    Absentarry=[[NSMutableArray alloc]init];
    
    backArray = [NSMutableArray array];
    
    
    
    if (_recordId.length == 0) {
        NSString *Id=[[NSUserDefaults standardUserDefaults]objectForKey:@"DianMingkid"];
        [KechengMedol AllstudentRequest:Id];
    }else{
        _repair = [[Repair alloc] init];
        NSLog(@"%@",_recordId);
        [_repair recallInfoList:_recordId];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recall:) name:@"recallInfoList"object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(automaticLogin:) name:@"AllstudentRequest"object:nil];
    NSNotificationCenter *fictionCenter=[NSNotificationCenter defaultCenter];
    [fictionCenter addObserver:self selector:@selector(automaticLogin1) name:@"dianmin" object:nil];
    self.tabBarController.tabBar.hidden=YES;
    _collectview.backgroundColor=[UIColor whiteColor];
    [_collectview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    _NaView.backgroundColor=XN_COLOR_GREEN_MINT;
    
    // Do any additional setup after loading the view from its nib.
    
}
//补点名
- (void)recall:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]) {
        couseid=[bitice.userInfo objectForKey:@"courseId"];
        NSLog(@"课程id %@",couseid);
        dataArry=[bitice.userInfo objectForKey:@"data"];
        
        for (int i = 0; i < dataArry.count; i ++) {
            [backArray insertObject:@"ss" atIndex:i];
        }
        
        _collectview.delegate=self;
        _collectview.dataSource=self;
    }
}
//点名
- (void)automaticLogin:(NSNotification *)bitice
{
    //    NSLog(@"所有学生是%@",bitice.userInfo);
    couseid=[bitice.userInfo objectForKey:@"courseId"];
    NSLog(@"课程id %@",couseid);
    dataArry=[bitice.userInfo objectForKey:@"data"];
    
    for (int i = 0; i < dataArry.count; i ++) {
        [backArray insertObject:@"" atIndex:i];
    }
    
    _collectview.delegate=self;
    _collectview.dataSource=self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArry.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dic=[dataArry objectAtIndex:indexPath.row];
    DataReauest *dataRequest=[[DataReauest alloc]initWithDictiory:dic];
    NSLog(@"%@%@",dataRequest.name,dataRequest.sex);
    NSLog(@"%d",dataRequest.HdID);
    if ([dataRequest.sex isEqual:@"1"])
    {
        cell.Sexlab.text=@"男";
    }
    else
    {
        cell.Sexlab.text=@"女";
    }
    cell.Namelab.text=dataRequest.name;
    [cell.TouXiang sd_setImageWithURL:[NSURL URLWithString:dataRequest.head] placeholderImage:[UIImage imageNamed:@"head.png"]];
    cell.TouXiang.layer.masksToBounds=YES;
    cell.TouXiang.layer.cornerRadius=cell.TouXiang.frame.size.height/2;
    cell.TouXiang.layer.borderWidth=1;
    cell.TouXiang.layer.borderColor=[[UIColor grayColor] CGColor];
    NSString *ID = dic[@"id"];
    
    NSString *str = backArray[indexPath.row];
    //到场学生
    if (str.length == 0) {
        if (_recordId.length == 0) {//修改选中颜色为绿色(原白色)
            cell.backView.backgroundColor = [UIColor whiteColor];
        }else{//修改未选中颜色为白色(原灰色)
            cell.backView.backgroundColor = [UIColor colorWithRed:0.401 green:0.798 blue:1.000 alpha:1.000];
        }
        
        [Presentarry addObject:dic[@"id"]];
        NSArray *array = [[NSSet setWithArray:Presentarry] allObjects];
        [Presentarry removeAllObjects];
        for (int i = 0; i < array.count; i ++) {
            [Presentarry addObject:array[i]];
        }
        for (int i = 0; i < Absentarry.count; i ++) {
            NSString *ab = Absentarry[i];
            if ([ab isEqualToString:ID]) {
                [Absentarry removeObject:ID];
            }
        }
    }
    //缺席学生
    else{
        if (_recordId.length == 0) {//修改选中颜色为绿色(原白色)
            cell.backView.backgroundColor = [UIColor colorWithRed:0.401 green:0.798 blue:1.000 alpha:1.000];
        }else{//修改未选中颜色为白色(原灰色)
            cell.backView.backgroundColor = [UIColor whiteColor];
        }
        
        [Absentarry addObject:dic[@"id"]];
        NSArray *array = [[NSSet setWithArray:Absentarry] allObjects];
        [Absentarry removeAllObjects];
        for (int i = 0; i < array.count; i ++) {
            [Absentarry addObject:array[i]];
        }
        
        for (int i = 0; i < Presentarry.count; i ++) {
            NSString *ab = Presentarry[i];
            if ([ab isEqualToString:ID]) {
                [Presentarry removeObject:ID];
            }
        }
    }
    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 5, 15);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < dataArry.count; i ++) {
        if (indexPath.row == i) {
            NSString *str = backArray[i];
            if (str.length == 0) {
                [backArray removeObjectAtIndex:indexPath.row];
                [backArray insertObject:@"ss" atIndex:i];
                [_collectview reloadData];
            }else{
                [backArray removeObjectAtIndex:indexPath.row];
                [backArray insertObject:@"" atIndex:i];
                [_collectview reloadData];
            }
            return;
        }
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH/4, 150);
}
- (IBAction)Tijiao:(UIButton *)sender
{
    //    NSArray *arry=@[@"12",@"13"];
    //    NSArray *arry1=[[NSArray alloc]init];
    [[NSUserDefaults standardUserDefaults]setObject:Absentarry forKey:@"absent"];
    if (_recordId.length == 0) {
        [KechengMedol BaoCunStuentRequest:couseid Presrnt:Absentarry Absent:Presentarry];
    }else{
        [KechengMedol BaoCunStuentRequest:couseid Presrnt:Presentarry Absent:Absentarry];
    }
    
}
- (IBAction)Fanhui:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
