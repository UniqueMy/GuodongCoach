//
//  SearchComment.h
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchComment : NSObject
@property (nonatomic,retain)NSString *age;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *area;
@property (nonatomic,retain)NSString *order_id;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
