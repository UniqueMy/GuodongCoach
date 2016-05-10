//
//  KPIModel.h
//  ipad
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPIModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic,retain) NSString *user_name;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSString *course_name;
@property (nonatomic,retain) NSString *pay_count;
@property (nonatomic,retain) NSString *obtain_money;

@end
