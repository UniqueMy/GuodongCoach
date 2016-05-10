//
//  AllCoachView.m
//  ipad
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "AllCoachView.h"
#import "AllCoachModel.h"
#import "AllCoachTableViewCell.h"
@interface AllCoachView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView    *sanjiaoImageView;
    NSMutableArray *allCoachArray;
    UITableView    *_tableView;
    NSString       *coach_id;
    NSDictionary   *coachDict;
    NSString       *classtype;
}
@end

@implementation AllCoachView

- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        [self startRequest];
        classtype = type;
    }
    return self;
}

- (void)startRequest {
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=train.allcoach",BASEURL];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        allCoachArray = [NSMutableArray array];
     
        NSDictionary *FirstDict = @{@"username":@"所有教练",@"uid":@""};
        
        AllCoachModel *coachModel = [[AllCoachModel alloc] initWithDictionary:FirstDict];
        
        [allCoachArray addObject:coachModel];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            
            AllCoachModel *coachModel = [[AllCoachModel alloc] initWithDictionary:dict];
            [allCoachArray addObject:coachModel];
            
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {}];
}

- (void)createUI {
    
    
    
    
    sanjiaoImageView       = [[UIImageView alloc] init];
    sanjiaoImageView.image = [UIImage imageNamed:@"sanjiao"];
    sanjiaoImageView.frame = CGRectMake(-10,25, 19.2, 39.2);

    [self addSubview:sanjiaoImageView];
    
    
    // 所有教练数组

    
    _tableView = [[UITableView alloc] initWithFrame:
                               CGRectMake(10,
                                          10,
                                          self.bounds.size.width - 20,
                                          self.bounds.size.height - 20)
                                                           style:UITableViewStylePlain];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allCoachArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllCoachModel *coachModel = allCoachArray[indexPath.row];
    
    static NSString *cellidentifier = @"cell";
    
    AllCoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[AllCoachTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    cell.contentLabel.text = coachModel.userName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     AllCoachModel *coachModel = allCoachArray[indexPath.row];
   
   
    coachDict    = @{@"coachName":coachModel.userName,@"coach_id":coachModel.uid};
   
    
    
      NSNotification *notification = [NSNotification notificationWithName:classtype object:nil userInfo:coachDict];
    
    //通过通知中心发送通知  显示教练姓名  更换显示页
      [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

@end
