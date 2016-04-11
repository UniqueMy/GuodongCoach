//
//  PlanComment.h
//  ipad
//
//  Created by mac on 15/5/5.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanComment : NSObject
@property (nonatomic,retain)NSString *plan_name;
@property (nonatomic,retain)NSString *ID;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
