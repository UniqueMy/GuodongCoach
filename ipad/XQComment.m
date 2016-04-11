//
//  XQComment.m
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "XQComment.h"

@implementation XQComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
       // NSLog(@"XQdict>>>>>>>>> %@",dictionary);
        self.remarkArray = [dictionary objectForKey:@"recard_remark"];
        NSDictionary *base = [dictionary objectForKey:@"base"];
        self.coach = [base objectForKey:@"coach"];
        self.content = [base objectForKey:@"content"];
        self.heart_rate = [NSString stringWithFormat:@"%@",[base objectForKey:@"heart_rate"]];
        self.time = [base objectForKey:@"time"];
        self.date = [base objectForKey:@"date"];
        self.enthusiasm = [base objectForKey:@"enthusiasm"];//会员热情度
        self.expression = [base objectForKey:@"expression"];
       // NSLog(@"self.remarkArray %@",self.remarkArray);
    }
    return self;
}

@end
