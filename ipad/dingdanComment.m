//
//  dingdanComment.m
//  ipad
//
//  Created by mac on 15/3/29.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "dingdanComment.h"

@implementation dingdanComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
     //   NSLog(@"dict>>>>>>>>> %@",dictionary);
        self.pre_time     = [dictionary objectForKey:@"pre_time"];
        self.course       = [dictionary objectForKey:@"course"];
        self.place        = [dictionary objectForKey:@"place"];
        self.name         = [dictionary objectForKey:@"name"];
        self.number       = [dictionary objectForKey:@"number"];
        self.gender       = [dictionary objectForKey:@"gender"];
        self.order_id     = [dictionary objectForKey:@"order_id"];
        self.process      = [dictionary objectForKey:@"process"];
        self.classStyle   = [dictionary objectForKey:@"order_type"];
        self.personNumber = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"course_number"]];
      
      //  NSLog(@"pre_time  %@course  %@place   %@name  %@number  %@gender  %@  order_id  %@ ",self.pre_time,self.course,self.place,self.name,self.number,self.gender,self.order_id);
    }
    return self;
}

@end
