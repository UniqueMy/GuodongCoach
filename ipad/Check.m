//
//  Check.m
//  ipad
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "Check.h"
#import "AllCoachView.h"
#import "addCheckView.h"
@implementation Check
{
    AllCoachView *coachView;
    NSMutableArray *trainClassArray;
}
- (instancetype)initWithFrame:(CGRect)frame AllCoachOrigin_Y:(CGFloat)originY trainClassArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWithOrigin_Y:originY];
        trainClassArray      = [NSMutableArray array];
        trainClassArray      = array;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createUIWithOrigin_Y:(CGFloat )originY {
    
    UIColor *colorC = [UIColor colorWithRed:158/255.0
                                      green:127/255.0
                                       blue:180/255.0
                                      alpha:1];
    
    coachView = [[AllCoachView alloc] initWithFrame:CGRectMake(-1,
                                                               originY,
                                                               150,
                                                               320) type:@"checkCoachName"];
    coachView.backgroundColor = colorC;
    // -1 遮盖灰色分割线
    [self addSubview:coachView];
    
    // 接收通知  更换显示页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultCoachName:) name:@"checkCoachName" object:nil];
    
}

- (void)addMainViewWithCoach_id:(NSString *)coach {
    
    addCheckView *addView = [[addCheckView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20) trainClassArray:trainClassArray coach_id:coach];
    [self addSubview:addView];

    
}
#pragma mark - 接收通知
// 更换显示页
- (void)resultCoachName:(NSNotification *)notification {
    [coachView removeFromSuperview];
    [self addMainViewWithCoach_id:[notification.userInfo objectForKey:@"coach_id"]];
}
@end
