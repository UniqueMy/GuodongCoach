//
//  XQTableViewCell.h
//  ipad
//
//  Created by mac on 15/4/6.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQComment;
@interface XQTableViewCell : UITableViewCell

@property (nonatomic,strong)XQComment *xqcomment;
@property (nonatomic,retain)UILabel *dateLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *jiaolianLabel;
@property (nonatomic,retain)UILabel *contentLabel;
@property (nonatomic,retain)UILabel *xinlvLabel;
@property (nonatomic,retain)UILabel *biaoxianLabel;
@property (nonatomic,retain)UILabel *reqingLabel;
@property (nonatomic,retain)UILabel *remark;
@property (nonatomic,assign)CGSize textSize;
@property (nonatomic ,assign) CGFloat height;


@property (nonatomic,retain) UILabel *jibinLabel;
@property (nonatomic,retain) UILabel *likeLabel;
@property (nonatomic,retain) UILabel *jinjiLabel;
@property (nonatomic,retain) UILabel *neirongLabel;
@property (nonatomic,retain) UILabel *yinshiLabel;
@property (nonatomic,retain) UILabel *nextLabel;
@property (nonatomic,retain) UILabel *danyouLabel;
@property (nonatomic,retain) UILabel *bianhuaLabel;
@property (nonatomic,retain) UILabel *remarkLabel;
@property (nonatomic,retain) NSMutableArray *labelArray;

@end
