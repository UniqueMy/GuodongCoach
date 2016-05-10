//
//  KPIModel.m
//  ipad
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "KPIModel.h"

@implementation KPIModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.user_name = [dict objectForKey:@"user_name"] ? [dict objectForKey:@"user_name"] : NULL;
        self.time      = [dict objectForKey:@"time"] ? [dict objectForKey:@"time"] : NULL;
        self.course_name  = [dict objectForKey:@"course_name"] ? [dict objectForKey:@"course_name"] : NULL;
        self.pay_count    = [NSString stringWithFormat:@"%@",[dict objectForKey:@"pay_amount"]] ? [NSString stringWithFormat:@"%@",[dict objectForKey:@"pay_amount"]] : NULL;
        self.obtain_money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"obtain_money"]] ? [NSString stringWithFormat:@"%@",[dict objectForKey:@"obtain_money"]] : NULL;
        
    }
    return self;
}

@end
