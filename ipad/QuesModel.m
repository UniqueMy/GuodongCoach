//
//  QuesModel.m
//  ipad
//
//  Created by mac on 15/11/10.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "QuesModel.h"

@implementation QuesModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.answerArray = [dict objectForKey:@"answer"];
        self.issue = [dict objectForKey:@"issue"];
        self.number = [NSString stringWithFormat:@"%@",[dict objectForKey:@"number"]];
        self.issue_type = [dict objectForKey:@"issue_type"];
        self.ques_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        
    }
    return self;
}
@end
