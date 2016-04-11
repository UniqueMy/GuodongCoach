//
//  dingdanComment.h
//  ipad
//
//  Created by mac on 15/3/29.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dingdanComment : NSObject
@property (nonatomic,retain)NSString *place;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *pre_time;
@property (nonatomic,retain)NSString *course;
@property (nonatomic,retain)NSString *number;
@property (nonatomic,retain)NSString *gender;
@property (nonatomic,retain)NSString *order_id;
@property (nonatomic,retain)NSString *process;
@property (nonatomic,retain)NSString *classStyle;
@property (nonatomic,retain)NSString *personNumber;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
