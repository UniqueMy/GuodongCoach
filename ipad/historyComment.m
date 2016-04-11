//
//  historyComment.m
//  ipad
//
//  Created by mac on 15/4/2.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "historyComment.h"

@implementation historyComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSLog(@"dict>>>>>>>>> %@",dictionary);
        self.test_time = [dictionary objectForKey:@"test_time"];
        self.coach_name = [dictionary objectForKey:@"coach_name"];
        self.order_id = [dictionary objectForKey:@"order_id"];
    }
    return self;
}
@end
