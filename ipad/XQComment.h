//
//  XQComment.h
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQComment : NSObject
@property (nonatomic,retain)NSMutableArray *remarkArray;
@property (nonatomic,retain)NSString *coach;
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *heart_rate;
@property (nonatomic,retain)NSString *time;
@property (nonatomic,retain)NSString *date;
@property (nonatomic,retain)NSString *enthusiasm;
@property (nonatomic,retain)NSString *expression;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
