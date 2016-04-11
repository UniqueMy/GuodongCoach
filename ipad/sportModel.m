//
//  sportModel.m
//  ipad
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "sportModel.h"

@implementation sportModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.content  = [dictionary objectForKey:@"content"];
        self.title    = [dictionary objectForKey:@"title"];
        self.title_id = [dictionary objectForKey:@"title_id"];
    }
    return self;
}

@end
