//
//  SearchComment.m
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "SearchComment.h"

@implementation SearchComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSLog(@"dict>>>>>>>>> %@",dictionary);
        self.age = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"age"]];
        self.name = [dictionary objectForKey:@"name"];
        self.area = [dictionary objectForKey:@"area"];
        self.order_id = [dictionary objectForKey:@"id"];
        
    }
    return self;
}

@end
