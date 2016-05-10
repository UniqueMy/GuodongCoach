//
//  Content_Row_Model.h
//  ipad
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Content_Row_Model : NSObject

@property (nonatomic,retain) NSString *row_number;
@property (nonatomic,retain) NSString *rowName;
@property (nonatomic,retain) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
