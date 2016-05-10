//
//  AllCoachModel.h
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllCoachModel : NSObject

@property (nonatomic,retain) NSString *uid;
@property (nonatomic,retain) NSString *userName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
