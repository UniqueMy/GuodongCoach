//
//  QuestionContentModel.h
//  果动
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionContent : NSObject


@property (nonatomic,retain) NSString       *user_id;

@property (nonatomic,retain) NSString       *headImgString;
@property (nonatomic,retain) NSString       *nickName;
@property (nonatomic,retain) NSString       *content;
@property (nonatomic,retain) NSMutableArray *photoArray;
@property (nonatomic,retain) NSString       *timeString;
@property (nonatomic,retain) NSString       *talk_id;
@property (nonatomic,retain) NSString       *isClick;
@property (nonatomic,retain) NSString       *isCoach;
@property (nonatomic,retain) NSString       *comment_headimgString;
@property (nonatomic,retain) NSString       *comment_id;
@property (nonatomic,retain) NSString       *comment_userid;
@property (nonatomic,retain) NSString       *comment_content;
@property (nonatomic,retain) NSString       *comment_nickName;
@property (nonatomic,retain) NSDictionary   *commentdict;
@property (nonatomic,retain)   NSString       *comment_time;
@property (nonatomic,retain) NSMutableArray *replyArray;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
