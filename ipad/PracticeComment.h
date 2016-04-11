//
//  PracticeComment.h
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PracticeComment : NSObject

@property (nonatomic,retain)NSString *train_type;
@property (nonatomic,retain)NSMutableArray *plan;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
