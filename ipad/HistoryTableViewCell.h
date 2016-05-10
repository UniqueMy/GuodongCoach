//
//  HistoryTableViewCell.h
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"
@class HistoryModel;
@interface HistoryTableViewCell : UITableViewCell

@property (nonatomic,strong) HistoryModel *historyComment;
@property (nonatomic,assign) CGFloat       height;

@end
