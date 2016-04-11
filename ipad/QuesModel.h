//
//  QuesModel.h
//  ipad
//
//  Created by mac on 15/11/10.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuesModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic,retain) NSArray  *answerArray;
@property (nonatomic,retain) NSString *issue;
@property (nonatomic,retain) NSString *number;
@property (nonatomic,retain) NSString *issue_type;
@property (nonatomic,retain) NSString *ques_id;
@end
