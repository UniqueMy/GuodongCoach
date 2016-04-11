//
//  contentComment.m
//  ipad
//
//  Created by mac on 15/5/5.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "contentComment.h"

@implementation contentComment
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        //    NSLog(@"dict>>>>>>>>> %@",dictionary);
        self.content = [dictionary objectForKey:@"content"];
        self.level_name = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"level_name"]];
        
    }
    return self;
}

@end
