//
//  contentComment.h
//  ipad
//
//  Created by mac on 15/5/5.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contentComment : NSObject
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *level_name;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
