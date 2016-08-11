//
//  QuestionReplyModel.h
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionReply : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic,retain) NSString *sourceHeadImg;
@property (nonatomic,retain) NSString *sourceName;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *targetName;
@property (nonatomic,retain) NSString *isClick;
@property (nonatomic,retain) NSString *reply_id;
@property (nonatomic,retain) NSString *timeString;
@property (nonatomic,retain) NSString *isCoach;
@end
