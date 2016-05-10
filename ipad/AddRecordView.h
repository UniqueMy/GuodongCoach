//
//  AddRecordView.h
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecordView : UIView
//@property (nonatomic,assign) void(^pushHistoryTrainBlock)(NSString *coach_id);
- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach;
@end
