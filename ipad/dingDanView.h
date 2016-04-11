//
//  dingDanView.h
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^daohangBlock)(NSString *string);
@interface dingDanView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,copy)daohangBlock daohangBlock, daohangBlock1,daohangBlock2;
@property (nonatomic,copy)void(^block)(NSString *name,NSString *string);
@property (nonatomic,retain)NSMutableArray *request,*orderArray;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIButton *dingdanButton;
+ (instancetype)sharedViewControllerManager;
@property (nonatomic,retain)NSString *coachName;
@end
