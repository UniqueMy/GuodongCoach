//
//  AllCoachModel.m
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "AllCoachModel.h"

@implementation AllCoachModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.uid      = [dictionary objectForKey:@"uid"] ? [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]] : NULL;
        
        self.userName = [dictionary objectForKey:@"username"] ? [dictionary objectForKey:@"username"] : NULL;
       
    }
    return self;
}
@end
