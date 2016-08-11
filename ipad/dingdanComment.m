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
        self.pre_time     = [dictionary objectForKey:@"pre_time"] ? [dictionary objectForKey:@"pre_time"] :NULL;
        self.course       = [dictionary objectForKey:@"course"] ? [dictionary objectForKey:@"course"] : NULL;
        self.place        = [dictionary objectForKey:@"place"] ? [dictionary objectForKey:@"place"] :NULL;
        self.name         = [dictionary objectForKey:@"name"] ? [dictionary objectForKey:@"name"] :NULL;
        self.number       = [dictionary objectForKey:@"number"] ? [dictionary objectForKey:@"number"] :NULL;
        self.gender       = [dictionary objectForKey:@"gender"] ? [dictionary objectForKey:@"gender"] :NULL;
        self.order_id     = [dictionary objectForKey:@"order_id"] ? [dictionary objectForKey:@"order_id"] : NULL;
        self.process      = [dictionary objectForKey:@"process"] ? [dictionary objectForKey:@"process"] :NULL;
        self.classStyle   = [dictionary objectForKey:@"order_type"];
        self.personNumber = [dictionary objectForKey:@"course_number"] ? [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"course_number"]] : NULL;
      
      //  NSLog(@"pre_time  %@course  %@place   %@name  %@number  %@gender  %@  order_id  %@ ",self.pre_time,self.course,self.place,self.name,self.number,self.gender,self.order_id);
    }
    return self;
}

@end
