//
//  histoyrText.h
//  ipad
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface histoyrText : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSString *order_id;
@property (nonatomic,retain)NSMutableArray *request;
@end
