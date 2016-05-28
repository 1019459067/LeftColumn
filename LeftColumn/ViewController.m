//
//  ViewController.m
//  LeftColumn
//
//  Created by Eternity° on 15/7/6.
//  Copyleft (c) 2015年 Eternity. All lefts reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "UIView+ET.h"

#define SideWidth 150

@interface ViewController ()<CenterViewControllerDelegate>
@property (nonatomic, weak) LeftViewController *left;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //左边
    LeftViewController *left = [[LeftViewController alloc]init];
    left.view.width = SideWidth;
    left.view.x = 0;
    left.view.y = 0;
    [self.view addSubview:left.view];
    self.left = left;
    [self addChildViewController:left];
    
    //中间
    CenterViewController *center = [[CenterViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:center];
    center.delegate = self;
    center.view.frame = self.view.bounds;
    [self.view addSubview:center.view];
    [self addChildViewController:nav];
    
    //手势 拖拽
    [center.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panChange:)]];
    //手势 点击
    [center.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapChange:)]];
}
#pragma mark - 手势 点击
- (void)tapChange:(UITapGestureRecognizer *)tap
{
    if (tap.view.origin.x == SideWidth) {
        [UIView animateWithDuration:0.5 animations:^{
            tap.view.transform = CGAffineTransformIdentity;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"显示"];
        }];
    }
}
#pragma mark - 手势 拖拽
- (void)panChange:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    if (pan.state == UIGestureRecognizerStateCancelled||pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.x >= SideWidth*0.5) {
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformMakeTranslation(SideWidth, 0);
            }];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"隐藏"];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"显示"];
        }
    }else{//正在拖拽
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
        if (pan.view.x >= SideWidth) {
            pan.view.transform = CGAffineTransformMakeTranslation(SideWidth, 0);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"隐藏"];
        }else if (pan.view.x<0){
            pan.view.transform = CGAffineTransformIdentity;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"显示"];
        }
        
    }
}

- (void)centerViewController:(CenterViewController *)centerViewController didButton:(UIButton *)btn
{
    
    if(btn.superview.origin.x == 0){
        [UIView animateWithDuration:0.5 animations:^{
            btn.superview.transform = CGAffineTransformMakeTranslation(SideWidth, 0);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"隐藏"];
        }];
    }else if (btn.superview.origin.x == SideWidth) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.superview.transform = CGAffineTransformIdentity;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonNameChange" object:@"显示"];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
