//
//  historyCheckModel.h
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface historyCheckModel : NSObject

@property (nonatomic,retain) NSString *className;
@property (nonatomic,retain) NSString *invigilation;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSString *coachName;
@property (nonatomic,retain) NSString *result;
@property (nonatomic,retain) NSString *remark;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
