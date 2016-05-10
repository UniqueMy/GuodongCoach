//
//  showClassView.m
//  ipad
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "showClassView.h"
#import "ContentModel.h"
@interface showClassView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation showClassView
{
    UIColor *baseColor;
    UIView  *superClassView;
    NSMutableArray *trainClassArray;
    BOOL           isUp;
    NSInteger      myTag;
    UIImageView    *showImageView;
    UILabel        *showLabel;
    UITableView    *_tableView;
}

- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array superClass:(UIView *)superClass tag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        baseColor = [UIColor colorWithRed:158/255.0
                                    green:127/255.0
                                     blue:180/255.0
                                    alpha:1];
        
        superClassView       = superClass;
        self.backgroundColor = baseColor;
        trainClassArray      = [NSMutableArray array];
        trainClassArray      = array;
        myTag                = tag;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    showLabel                 = [UILabel new];
    showLabel.frame           = CGRectMake(3, 3, 200, 25);
    showLabel.backgroundColor = [UIColor whiteColor];
    showLabel.textAlignment   = 1;
    showLabel.font            = [UIFont fontWithName:FONT size:20];
    ContentModel *model       = trainClassArray[0];
    showLabel.text            = model.sectionName;
    [self addSubview:showLabel];
    
    showImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    showImageView.frame            = CGRectMake(CGRectGetMaxX(showLabel.frame) + 14, 8.7, 22.1, 13.65);
    [self addSubview:showImageView];
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showButton.frame  = CGRectMake(0,
                                   0,
                                   self.bounds.size.width,
                                   self.bounds.size.height);
    [showButton addTarget:self action:@selector(showButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showButton];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x,
                                                               CGRectGetMaxY(self.frame)-1,
                                                               206,
                                                               44*4)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    
   
    
    
}
#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return trainClassArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ContentModel *model = trainClassArray[indexPath.row];
    
    static NSString *cellidentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor     = baseColor;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font      = [UIFont fontWithName:FONT size:20];
        cell.textLabel.textAlignment = 1;
    }
    
    cell.textLabel.text = model.sectionName;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContentModel *model = trainClassArray[indexPath.row];
    showLabel.text      = model.sectionName;
    [_tableView removeFromSuperview];
    showImageView.image = [UIImage imageNamed:@"down"];
    isUp =! isUp;
    
    if (myTag == 200) {
        NSDictionary   *frame_idDict  = @{@"frame_id":model.sectionNumber};
        NSNotification *notification  = [NSNotification notificationWithName:@"frame_id" object:nil userInfo:frame_idDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } else {
        NSDictionary   *frame_idDict  = @{@"frame_id":model.sectionNumber};
        NSNotification *notification  = [NSNotification notificationWithName:@"historyFrame_id" object:nil userInfo:frame_idDict];
        
        //通过通知中心发送通知  显示教练姓名  更换显示页
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
   
}

- (void)showButtonClick:(UIButton *)button {
    if (!isUp) {
        showImageView.image = [UIImage imageNamed:@"up"];
        [superClassView addSubview:_tableView];
    } else {
        showImageView.image = [UIImage imageNamed:@"down"];
        [_tableView removeFromSuperview];
    }
    isUp =! isUp;
}

@end
