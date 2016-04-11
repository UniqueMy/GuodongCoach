//
//  ingamendViewController.h
//  ipad
//
//  Created by mac on 15/3/17.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ingamendViewController : UIViewController<UIAlertViewDelegate>
@property (nonatomic,retain)NSString *strTime;
@property (nonatomic,retain)NSString *order_id ;
@property (nonatomic,retain)NSString *coachName;
@property (nonatomic,retain)UILabel *timeLabel;
+ (instancetype)sharedViewControllerManager;
@end
