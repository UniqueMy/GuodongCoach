//
//  HistoryCheckTableViewCell.h
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
@class historyCheckModel;
@interface HistoryCheckTableViewCell : UITableViewCell

@property (nonatomic,strong) historyCheckModel *historyModel;
@property (nonatomic,assign) CGFloat  height;

@end
