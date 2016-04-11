//
//  historyComment.h
//  ipad
//
//  Created by mac on 15/4/2.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface historyComment : NSObject
@property (nonatomic,retain)NSString *test_time,*coach_name,*order_id;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
