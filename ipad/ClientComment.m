//
//  ClientComment.m
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "ClientComment.h"

@implementation ClientComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSLog(@"dict>>>>>>>>> %@",dictionary);
        
        
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"address"];
        self.number = [dictionary objectForKey:@"number"];
        self.age =[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"age"]];
        self.sex = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"sex"]];
        
        self.remark = [dictionary objectForKey:@"remark"];
        self.coach = [dictionary objectForKey:@"coach"];
        self.time = [dictionary objectForKey:@"time"];
        self.heart_rate = [dictionary objectForKey:@"heart_rate"];
        self.enthusiasm = [dictionary objectForKey:@"enthusiasm"];
        self.expression = [dictionary objectForKey:@"expression"];
        self.content = [dictionary objectForKey:@"content"];
        self.date = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"date"]];
        
        
        self.apparatu = [dictionary objectForKey:@"apparatu"];
        self.xggd = [dictionary objectForKey:@"xggd"];
        self.area = [dictionary objectForKey:@"area"];
        NSLog(@" self.date   %@", self.date);
    }
    return self;
}
@end
