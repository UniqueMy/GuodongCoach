//
//  HttpTool.m
//  ipad
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "HttpTool.h"
#import "UIImageView+WebCache.h"
#import "QCheckBox.h"
@implementation HttpTool


#pragma mark Http的multipart的POST请求
+ (void)multipartPostWithUrl:(NSString *)urlStr params:(NSDictionary *)params fileDatas:(NSArray *)datas contentType:(NSString *)type success:(SuccessBlock)success fail:(FailBlock)fail {
    // 1.创建Http请求操作管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
   // manager.requestSerializer.timeoutInterval = 2;
    // 2.设置返回类型
    if (type) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    }
    // 3.创建Http请求操作对象
    
    AFHTTPRequestOperation *op = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传多张图片
        for (NSDictionary *dict in datas) {
            NSString *name = [dict allKeys][0];
          //  NSLog(@"内部   %@",name);
            [formData appendPartWithFileData:dict[name] name:name fileName:@"upload.jpg" mimeType:@"image/jpg"];
            
            
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];

    // 4.Http请求操作对象开始请求
    [op start];
}


+ (void)postWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type success:(SuccessBlock)success fail:(FailBlock)fail {
    // 1.创建Http请求操作管理器
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    // 2.设置返回类型
    if (type) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    }
    // 3.创建Http请求操作对象
    
   
    AFHTTPRequestOperation *op = [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) { //success不为空
            NSLog(@"res %@%@",urlStr,responseObject);
            //   [self connection:manager didReceiveResponse:responseObject];
            
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) { //fail不为空
            fail(error);
        }
    }];
    // 4.发送请求
    [op start];
}

+(UIView *)daohangViewsetTitle:(NSString *)title
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.daohangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    //  app.daohangView.backgroundColor = [UIColor redColor];
    [app.window addSubview:app.daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:app.daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [app.daohangView addSubview:daohangImage];
    
    app.titlelabel=[[UILabel alloc]init];
    app.titlelabel.text=title;
    app.titlelabel.font=[UIFont fontWithName:FONT size:36];
    app.titlelabel.frame=CGRectMake(380, 17, 300, 30);
    [app.titlelabel setTextColor:[UIColor whiteColor]];
    app.titlelabel.textAlignment=NSTextAlignmentCenter;
    [app.daohangView addSubview:app.titlelabel];
    return app.daohangView;
}
+(void)setappTitle:(NSString *)text
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.titlelabel.text = text;
    
}
//解析数据到name这一层
+(NSString *)wenQuestionNameWithDict:(NSDictionary *)dict key:(NSString *)key
{
  //  NSLog(@"key %@",key);
    NSDictionary *nameDict = [dict objectForKey:key];
    
    NSString *name = [nameDict objectForKey:@"issue"];
    return name;
}
//解析数据到options这一层
+(NSMutableArray *)xuanQuestionNameWithDict:(NSDictionary *)dict
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *array = [dict objectForKey:@"options"];
    for (NSDictionary *optionsDict in array) {
        NSString *name = [optionsDict objectForKey:@"options"];
        [mutableArray addObject:name];
    }
    return mutableArray;
}
//健康问卷UILabel的设置方法
+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor whiteColor];
    label.text = title;
    label.font = [UIFont fontWithName:FONT size:27];
    
    return label;
}
//健康问卷下划线的设置方法
+(UIImageView *)underLineWithFrame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.userInteractionEnabled = YES;
    return imageView;
}
//健康问卷输入框的设置方法
+(UITextField *)textFieldWithFrame:(CGRect)frame tag:(NSInteger)tag
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textAlignment = 1;
    textField.tag = tag;
    textField.textColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont fontWithName:FONT size:27];
    
    
    return textField;
}
//健康问卷问答题的设置方法
+(UIView *)wenViewWithFrame:(CGRect)labelFrame textFieldWidth:(CGFloat)width  questionDict:(NSDictionary *)quesDict numberWithKey:(NSString *)key
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelFrame.origin.x, labelFrame.origin.y, labelFrame.size.width + width, labelFrame.size.height)];
    view.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelFrame.size.width, labelFrame.size.height)];
    label.textColor = [UIColor whiteColor];
    label.text = [HttpTool wenQuestionNameWithDict:quesDict key:key];
    label.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(label.frame), width, .5)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), width, label.bounds.size.height)];
    textField.textAlignment = 1;
    if ([[[quesDict objectForKey:key] objectForKey:@"answer"] count] > 0) {
         textField.text = [[quesDict objectForKey:key] objectForKey:@"answer"][0];
    }else{
        textField.text = @"";
    }
    textField.tag = [key integerValue];
    textField.textColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont fontWithName:FONT size:27];
    [view addSubview:textField];
    
    return view;
    
}

@end
