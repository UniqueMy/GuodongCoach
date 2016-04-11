//
//  XQViewController.h
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSString *order_id;
@property (nonatomic,retain)NSMutableArray *request,*cellArray;
@property (nonatomic,assign)CGSize textSize;
@end
