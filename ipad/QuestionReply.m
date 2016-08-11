//
//  QuestionReplyModel.m
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "QuestionReply.h"

@implementation QuestionReply

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        _content    = [dict objectForKey:@"content"] ? [dict objectForKey:@"content"] : NULL;
        _timeString = [dict objectForKey:@"time"] ? [dict objectForKey:@"time"] : NULL;
        _sourceName = [[dict objectForKey:@"source_user"] objectForKey:@"nickname"];
        _sourceHeadImg = [[dict objectForKey:@"source_user"] objectForKey:@"headimg"];
        _isCoach       = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"source_user"] objectForKey:@"type"]];
        _targetName    = [[dict objectForKey:@"target_user"] objectForKey:@"nickname"];
        _isClick       = [NSString stringWithFormat:@"%@",[dict objectForKey:@"operation"]];
        _reply_id      = [NSString stringWithFormat:@"%@",[dict objectForKey:@"replay_id"]];
    }
    return self;
}


@end
