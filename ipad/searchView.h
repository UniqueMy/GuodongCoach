//
//  searchView.h
//  ipad
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^daohangBlock)(NSString *order_id);

@interface searchView : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,copy)daohangBlock daohangBlock;
+ (instancetype)sharedViewControllerManager;
@property (nonatomic,retain)NSMutableArray *request;
@property (nonatomic,retain)NSString *order_id;
@end
