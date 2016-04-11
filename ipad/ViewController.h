//
//  ViewController.h
//  ipad
//
//  Created by mac on 15/3/14.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>

@property (nonatomic,retain)NSString *isdingdan;
@property (nonatomic,copy)void(^block)(void);
@property (nonatomic,copy)void(^timeblock)(NSString *time);
@property (nonatomic,retain) NSString *idnew_order;
@property (nonatomic,assign) BOOL isPush;
+ (instancetype)sharedViewControllerManager;
@end

