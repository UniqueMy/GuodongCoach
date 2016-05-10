//
//  HistoryTrainView.h
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTrainView : UIView

@property (nonatomic,retain) NSString *coach_id;
- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach;
@end
