//
//  CenterViewController.h
//  LeftColumn
//
//  Created by Eternity° on 15/7/6.
//  Copyright (c) 2015年 Eternity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CenterViewController;
@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)centerViewController:(CenterViewController *)centerViewController didButton:(UIButton *)btn;
@end
@interface CenterViewController : UIViewController
@property (nonatomic, weak) id<CenterViewControllerDelegate> delegate;
@end
