//
//  PracticeComment.m
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "PracticeComment.h"

@implementation PracticeComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
     //   NSLog(@"dict>>>>>>>>> %@",dictionary);
        
        self.train_type = [dictionary objectForKey:@"train_type"];
        self.plan = [dictionary objectForKey:@"plan"];
    }
    return self;
}
@end
