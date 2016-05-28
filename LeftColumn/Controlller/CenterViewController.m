//
//  CenterViewController.m
//  LeftColumn
//
//  Created by Eternity° on 15/7/6.
//  Copyright (c) 2015年 Eternity. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation CenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_preview"]];
    [self resgisterNoti];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 60, 40);
    [btn setTitle:@"显示" forState:UIControlStateNormal];
    [btn setTitle:@"隐藏" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    btn.layer.borderWidth = 2;
}
- (void)resgisterNoti
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonNameChange:) name:@"buttonNameChange" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"buttonNameChange" object:nil];;
}
- (void)buttonNameChange:(NSNotification *)noti
{
    NSString *name = [noti object];
    self.btn.titleLabel.text = name;
}
- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(centerViewController:didButton:)]) {
        [self.delegate centerViewController:self didButton:btn];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
