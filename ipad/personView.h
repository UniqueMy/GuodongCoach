//
//  personView.h
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personView : UIViewController

+ (instancetype)sharedViewControllerManager;
@property (nonatomic,retain)NSMutableArray *request;
@property (nonatomic,retain)UILabel *addressLabel,*classLabel,*idLabel,*nameLabel;
@property (nonatomic,retain) UIImageView *imageView,*yanImage;
@property (nonatomic,retain)UIButton *statusButton;
@end
/*
 UIImageView *imageView;
 UIImageView *yanImage;*/