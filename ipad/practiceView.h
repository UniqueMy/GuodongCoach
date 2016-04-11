//
//  practiceView.h
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface practiceView : UIViewController

@property (nonatomic,retain)NSMutableArray *request;
@property (nonatomic,retain)NSMutableArray *planArray;
@property (nonatomic,retain)NSMutableArray *contentArray;
@property (nonatomic,retain)UIButton *forbutton;
@property (nonatomic,copy)void(^block)(int height);
+ (instancetype)sharedViewControllerManager;
@end
