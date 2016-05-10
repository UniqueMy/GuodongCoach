//
//  HistoryModel.m
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        
       
        self.trainClass     = [dictionary objectForKey:@"content"] ? [dictionary objectForKey:@"content"] : NULL;
        self.trainPerson    = [dictionary objectForKey:@"training_coach"] ? [dictionary objectForKey:@"training_coach"] : NULL;
        self.coachName      = [dictionary objectForKey:@"coach_name"] ? [dictionary objectForKey:@"coach_name"] : NULL;
        self.studentFeedback = [dictionary objectForKey:@"feedback"] ? [dictionary objectForKey:@"feedback"] : NULL;
        self.trainResult     = [dictionary objectForKey:@"result"] ? [dictionary objectForKey:@"result"] : NULL;
        self.completeCondition = [dictionary objectForKey:@"progress"] ? [dictionary objectForKey:@"progress"] : NULL;
        self.remark            = [dictionary objectForKey:@"remark"] ? [dictionary objectForKey:@"remark"] : NULL;
    }
    return self;
}
@end
