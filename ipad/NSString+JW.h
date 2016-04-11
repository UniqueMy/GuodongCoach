//
//  NSString+JW.h
//  果动
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JW)

#pragma mark 字符串后面追加内容
- (NSString *)fileAppend:(NSString *)append;
//去掉字符串的空格
- (NSString *)trimString;
//是否是空字符串
- (BOOL)isEmptyString;

- (NSString *)md5:(NSString *)str ;

-(BOOL)isValidateEmail:(NSString *)email;

@end
