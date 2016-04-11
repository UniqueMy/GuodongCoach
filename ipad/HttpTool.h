//
//  HttpTool.h
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "QCheckBox.h"
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailBlock)(NSError *error);

@interface HttpTool : NSObject<QCheckBoxDelegate>
+ (void)postWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type success:(SuccessBlock)success fail:(FailBlock)fail;

/**
 * Http的multipart的POST请求（上传文件用）
 */

+ (void)multipartPostWithUrl:(NSString *)urlStr params:(NSDictionary *)params fileDatas:(NSArray *)datas contentType:(NSString *)type success:(SuccessBlock)success fail:(FailBlock)fail;

+(UIView *)daohangViewsetTitle:(NSString *)title;
+(void)setappTitle:(NSString *)text;

//解析数据到name这一层
+(NSString *)wenQuestionNameWithDict:(NSDictionary *)dict key:(NSString *)key;

//解析数据到options这一层
+(NSMutableArray *)xuanQuestionNameWithDict:(NSDictionary *)dict;

//健康问卷UILabel的设置方法
+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title;

//健康问卷下划线的设置方法
+(UIImageView *)underLineWithFrame:(CGRect)frame;

//健康问卷输入框的设置方法
+(UITextField *)textFieldWithFrame:(CGRect)frame tag:(NSInteger)tag;

//健康问卷问答题的设置方法
+(UIView *)wenViewWithFrame:(CGRect)labelFrame textFieldWidth:(CGFloat)width  questionDict:(NSDictionary *)quesDict numberWithKey:(NSString *)key;


@end
