//
//  UIImage+JW.h
//  果动
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 梁先森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JW)
#pragma mark 全屏图片
+(UIImage *)fullScreenImage:(NSString *)image;
/**
 * 拉伸图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
/**
 * 压缩图片
 */
+ (UIImage *)zipImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
