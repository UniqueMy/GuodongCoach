//
//  Content_Row_Model.m
//  ipad
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "Content_Row_Model.h"

@implementation Content_Row_Model

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        NSString *number = [dictionary objectForKey:@"id"] ? [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"id"]] : NULL;
        
        self.row_number = number;
        self.rowName    = [dictionary objectForKey:@"name"] ? [dictionary objectForKey:@"name"] : NULL;
        self.content    = [dictionary objectForKey:@"content"] ? [dictionary objectForKey:@"content"] : NULL;
           }
    return self;
}

@end
