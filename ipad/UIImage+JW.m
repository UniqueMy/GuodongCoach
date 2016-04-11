//
//  UIImage+JW.m
//  果动
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 梁先森. All rights reserved.
//

#import "UIImage+JW.h"

#import "NSString+JW.h"

@implementation UIImage (JW)

#pragma mark 加载全屏图片

+(UIImage *)fullScreenImage:(NSString *)image
{
    
    if ([UIScreen mainScreen].bounds.size.height == 480 )
    {
        image = [image fileAppend:@""];
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 568 )
    {
        image = [image fileAppend:@""];
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 667 && [UIScreen mainScreen].bounds.size.width == 375)
    {
        image = [image fileAppend:@""];
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 960 && [UIScreen mainScreen].bounds.size.width == 540)
    {
        image = [image fileAppend:@""];
    }
    
    return [self imageNamed:image];
    
}
#pragma mark 拉伸图片
+ (UIImage *)resizedImage:(NSString *)name {
    
    UIImage *image = [UIImage imageNamed:name];
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:
        UIImageResizingModeStretch];
    
}

#pragma mark 压缩图片

+ (UIImage *)zipImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
