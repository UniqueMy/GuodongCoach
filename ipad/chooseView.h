//
//  chooseView.h
//  ipad
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chooseView : UIView

@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) UILabel  *showLabel;
@property (nonatomic,retain) NSObject *dataModel;

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView *)supView
                      viewTag:(NSInteger)tag;

@end
