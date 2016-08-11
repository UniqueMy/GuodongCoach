//
//  HistoryTrainView.m
//  ipad
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "HistoryTrainView.h"
#import "chooseClassView.h"
#import "HistoryTableViewCell.h"
#import "HistoryModel.h"
@interface HistoryTrainView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HistoryTrainView {
    NSMutableArray *trainClassArray;
    UITableView    *_tableView;
    NSMutableArray *dataArray;
    NSMutableArray *cellArray;
    NSString       *content_id;
    
}

- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach content_id:(NSString *)contend
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        trainClassArray      = [NSMutableArray array];
        trainClassArray      = array;
        self.coach_id        = coach;
        content_id           = contend;
        [self createUI];
        [self startRequest];
    }
    return self;
}
//#pragma mark - 接收content_id
//- (void)resultContent_id:(NSNotification *)notification {
//    
//    content_id = notification.userInfo[@"content_id"];
//}
- (void)startRequest {
    
    NSString *url = [NSString stringWithFormat:@"%@/pad/?method=train.search_recard",BASEURL];
    
    NSString *type =  self.coach_id.length == 0 ? @"1" : @"2";
    
    NSDictionary *dict = @{@"type":type,@"coach_id":self.coach_id,@"filter_type":@"content",@"filter_id":content_id};
    NSLog(@"dict %@",dict);
    [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
        dataArray = [NSMutableArray array];
        cellArray = [NSMutableArray array];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            HistoryModel *history      = [[HistoryModel alloc] initWithDictionary:dict];
            HistoryTableViewCell *cell = [HistoryTableViewCell new];
            [dataArray addObject:history];
            [cellArray addObject:cell];
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {}];
}

- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               self.bounds.size.width ,
                                                               self.bounds.size.height)
                                              style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource     = self;
    _tableView.delegate       = self;
    [self addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cell";
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[HistoryTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HistoryModel *history = [dataArray objectAtIndex:indexPath.row];
    cell.historyComment   = history;
    
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
    HistoryTableViewCell *cell = cellArray[indexPath.row];
    cell.historyComment        = dataArray[indexPath.row];
    return cell.height;
    
}

- (void)check:(UIButton *)button {
    [self startRequest];
}
@end
