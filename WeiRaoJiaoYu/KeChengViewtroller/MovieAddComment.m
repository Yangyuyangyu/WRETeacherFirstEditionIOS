//
//  MovieAddComment.m
//  qukan43
//
//  Created by yang on 15/12/3.
//  Copyright © 2015年 ReNew. All rights reserved.
//

#import "MovieAddComment.h"

@implementation MovieAddComment

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MovieAddComment1"
                                                       owner:self
                                                     options:nil];
        
        self.v_addcomment = [array objectAtIndex:0];
        self.v_addcomment.frame = self.bounds;
        [self addSubview:self.v_addcomment];

        
//        self.v_count.layer.cornerRadius = self.v_count.frame.size.height/2;
//        self.v_count.layer.borderWidth = 1.0;
//        
//        self.v_count.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0].CGColor;
        self.count = -1;
        
 

    }
    return self;
}

-(IBAction)hidKeyboard:(id)sender{
    [self endEditing:YES];
    
}

-(void)cleamCount{
//    self.v_count.hidden = YES;
//    self.lbl_counttext.text = @"请滑动星星评分";
    self.count = -1;
    
    [self.img_star1 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star2 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star3 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star4 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star5 setImage:[UIImage imageNamed:@"StarUnSelect"]];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.v_star];
    if((point.x>0 && point.x<self.v_star.frame.size.width)&&(point.y>0 && point.y<self.v_star.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint:point];

    }else{
        self.canAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.v_star];
        [self changeStarForegroundViewWithPoint:point];
    
    }
   

    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.v_star];
        [self changeStarForegroundViewWithPoint:point];
        
    }
    
    self.canAddStar = NO;
    return;
}


-(void)changeStarForegroundViewWithPoint:(CGPoint)point{

    float count = 0;
    count = count + [self changeImg:point.x image:self.img_star1];
    count = count + [self changeImg:point.x image:self.img_star2];
    count = count + [self changeImg:point.x image:self.img_star3];
    count = count + [self changeImg:point.x image:self.img_star4];
    count = count + [self changeImg:point.x image:self.img_star5];
    if(count==0){
        count = 1;
        [self.img_star1 setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
    }
    self.count = count;
   
    if(count==10){
        self.ScoreLab.text = @"5.0";
    }else{
        self.ScoreLab.text = [NSString stringWithFormat:@"%.1f",count/2];
    }
    [[NSUserDefaults standardUserDefaults]setObject:self.ScoreLab.text forKey:@"soreLab"];
}



-(float)changeImg:(float)x image:(UIImageView*)img{
    if(x> img.frame.origin.x + img.frame.size.width/2){
        [img setImage:[UIImage imageNamed:@"StarSelected"]];
        return 2;
    }else if(x> img.frame.origin.x){
        [img setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
        return 1;
//        [self setImageAnimation:img];
    }else{
        [img setImage:[UIImage imageNamed:@"StarUnSelect"]];
        return 0;
    }
}

-(void)setImageAnimation:(UIView *)v{
    CGRect rec = v.frame;
    [UIView animateWithDuration:0.1 animations:^{
        v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y -3, v.frame.size.width, v.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            v.frame = rec;
        } completion:^(BOOL finished) {
            v.frame = rec;
        }];
    }];
}


-(IBAction)closeView:(id)sender{
    [self removeFromSuperview];
}


@end
