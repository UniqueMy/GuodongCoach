//
//  historyCheckView.m
//  ipad
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "historyCheckView.h"
#import "historyCheckModel.h"
#import "HistoryCheckTableViewCell.h"
@interface historyCheckView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    NSMutableArray *cellArray;
    UITableView *_tableView;
    NSString    *coach_type;
    NSString    *coach_id;
    NSString    *historyFrame_id;
}
@end

@implementation historyCheckView

- (instancetype)initWithFrame:(CGRect)frame coach_id:(NSString *)coach frame_id:(NSString *)historyFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        coach_id             = coach;
        historyFrame_id      = historyFrame;
        
        if ([coach_id isEqual:@""]) {
            coach_type = @"1";
        } else {
            coach_type = @"2";
        }
        [self startRequest];
        [self createUI];
    }
    return self;
}

- (void)startRequest {
    
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=train.examine_recard",BASEURL];
    
    NSDictionary *dataDict = @{@"filter_type":@"framework",
                               @"type":coach_type,
                               @"coach_id":coach_id,
                               @"filter_id":historyFrame_id
                               };
    
    [HttpTool postWithUrl:url params:dataDict contentType:CONTENTTYPE success:^(id responseObject) {
        dataArray = [NSMutableArray array];
        cellArray = [NSMutableArray array];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            historyCheckModel *model   = [[historyCheckModel alloc] initWithDictionary:dict];
            HistoryCheckTableViewCell *cell = [[HistoryCheckTableViewCell alloc] init];
            [cellArray addObject:cell];
            [dataArray addObject:model];
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {}];
}

- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(40,
                                                               40,
                                                               self.bounds.size.width - 80,
                                                               self.bounds.size.height - 80)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    [self addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    historyCheckModel *model = dataArray[indexPath.row];
    static NSString *cellidentifier = @"cell";
    
    HistoryCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[HistoryCheckTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    cell.historyModel = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 重新设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCheckTableViewCell *cell = cellArray[indexPath.row];
    cell.historyModel        = dataArray[indexPath.row];
    return cell.height;
    
}

@end
