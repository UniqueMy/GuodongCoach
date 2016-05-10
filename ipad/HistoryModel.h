//
//  HistoryModel.h
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject


@property (nonatomic,retain) NSString *trainClass;
@property (nonatomic,retain) NSString *trainPerson;
@property (nonatomic,retain) NSString *coachName;
@property (nonatomic,retain) NSString *studentFeedback;
@property (nonatomic,retain) NSString *trainResult;
@property (nonatomic,retain) NSString *completeCondition;
@property (nonatomic,retain) NSString *remark;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
