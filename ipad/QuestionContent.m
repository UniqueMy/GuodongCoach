//
//  QuestionContentModel.m
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "QuestionContent.h"
#import "QuestionReply.h"

@implementation QuestionContent

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
         _user_id = [dict objectForKey:@"uid"];
        _headImgString = [dict objectForKey:@"headimg"] ? [dict objectForKey:@"headimg"] : NULL;
        _nickName = [dict objectForKey:@"nickname"] ? [dict objectForKey:@"nickname"] : NULL;
        _content  = [dict objectForKey:@"content"] ? [dict objectForKey:@"content"] : NULL;
        _photoArray = [dict objectForKey:@"photos"] ? [dict objectForKey:@"photos"] : NULL;
        _timeString =  [dict objectForKey:@"time"] ?  [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]]: NULL;
        _talk_id   = [NSString stringWithFormat:@"%@",[dict objectForKey:@"talkid"]];
        
        
        _commentdict = [dict objectForKey:@"comments"];
        
        if (_commentdict.count != 0) {
            
            _isClick = [NSString stringWithFormat:@"%@",[_commentdict objectForKey:@"operation"]];
            _isCoach  = [NSString stringWithFormat:@"%@",[_commentdict objectForKey:@"type"]];
            _comment_id            = [_commentdict objectForKey:@"id"];
            _comment_headimgString = [_commentdict objectForKey:@"headimg"];
            _comment_nickName      = [_commentdict objectForKey:@"nickname"];
            _comment_content       = [_commentdict objectForKey:@"content"];
            _comment_time          = [_commentdict objectForKey:@"time"];
            _comment_userid        = [_commentdict objectForKey:@"uid"];
            
            _replyArray = [NSMutableArray array];
            NSDictionary *replyListDict = [_commentdict objectForKey:@"replay_list"];
            if (replyListDict) {
                for (NSDictionary *replyDict in replyListDict)
                {
                    QuestionReply *replyModel = [[QuestionReply alloc]
                                                 initWithDictionary:replyDict];
                    [_replyArray addObject:replyModel];
                    
                }
            }
            
        }
        
    }
    return self;
}


@end
