//
//  NSString+JW.m
//  果动
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSString+JW.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JW)

#pragma mark 在字符串后面追加内容

- (NSString *)fileAppend:(NSString *)append
{
    
    NSString *imageStr = nil;
    
    NSString *ext = [self pathExtension];
    
    if (![@"" isEqualToString:ext])
        
    {
        
        imageStr = [self stringByDeletingPathExtension];
        
        imageStr = [imageStr stringByAppendingString:append];
        
        imageStr = [imageStr stringByAppendingPathExtension:ext];
        
    }
    
    else
        
    {
        
        imageStr = [self stringByAppendingString:append];
        
    }
    
    return imageStr;
    
}


- (NSString *)trimString
{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

- (BOOL)isEmptyString
{
    
    return (self.length == 0);
    
}


- (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[32];
    
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}


-(BOOL)isValidateEmail:(NSString *)email

{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


@end
