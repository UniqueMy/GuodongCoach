//
//  PlanComment.m
//  ipad
//
//  Created by mac on 15/5/5.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "PlanComment.h"

@implementation PlanComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
    //    NSLog(@"dict>>>>>>>>> %@",dictionary);
        self.plan_name = [dictionary objectForKey:@"plan_name"];
        self.ID = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"id"]];
        
    }
    return self;
}

@end
