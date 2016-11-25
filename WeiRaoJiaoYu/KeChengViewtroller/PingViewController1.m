//
//  PingFenViewController1.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/8.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "PingViewController1.h"
#import "MovieAddComment.h"
@interface PingViewController1 ()
@property (weak, nonatomic) IBOutlet UIView *Naview;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@end

@implementation PingViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
//    _Naview.backgroundColor=XN_COLOR_GREEN_MINT;
//    MovieAddComment *movie = [[MovieAddComment alloc] initWithFrame:CGRectMake(0, 100,  _view1.bounds.size.width, 200)];
//    movie.userInteractionEnabled=YES;
//    [self.view addSubview:movie];
    
    
    

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)TiJIao:(UIButton *)sender {
    MovieAddComment *movie = [[MovieAddComment alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/2)];
    [self.view addSubview:movie];
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
