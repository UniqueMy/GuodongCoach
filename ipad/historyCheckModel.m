//
//  historyCheckModel.m
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "historyCheckModel.h"

@implementation historyCheckModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.className    = [dict objectForKey:@"name"] ? [dict objectForKey:@"name"] : NULL;
        self.invigilation = [dict objectForKey:@"invigilation"] ? [dict objectForKey:@"invigilation"] : NULL;
        self.time         = [dict objectForKey:@"time"] ? [dict objectForKey:@"time"] : NULL;
        self.coachName    = [dict objectForKey:@"coachName"] ? [dict objectForKey:@"coachName"] : NULL;
        self.remark       = [dict objectForKey:@"remark"] ? [dict objectForKey:@"remark"] : NULL;
        self.result       = [dict objectForKey:@"result"] ? [dict objectForKey:@"result"] : NULL;
    }
    return self;
}

@end
