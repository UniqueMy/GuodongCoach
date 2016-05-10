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
   
}

- (instancetype)initWithFrame:(CGRect)frame trainClassArray:(NSMutableArray *)array coach_id:(NSString *)coach
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        trainClassArray      = [NSMutableArray array];
        trainClassArray      = array;
        self.coach_id        = coach;
        [self createUI];
        [self startRequest];
    }
    return self;
}

- (void)startRequest {
    
    NSString *url = [NSString stringWithFormat:@"%@/pad/?method=train.search_recard",BASEURL];
    
    NSString *type =  self.coach_id.length == 0 ? @"1" : @"2";
    
    NSDictionary *dict = @{@"type":type,@"coach_id":self.coach_id,@" filter_type ":@"all"};
    
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
    
    UIColor *baseColor = [UIColor colorWithRed:112/255.0
                                         green:199/255.0
                                          blue:243/255.0
                                         alpha:1];
    
    
    UILabel *trainClass  = [UILabel new];
    trainClass.frame     = CGRectMake(20, 30, 100, 20);
    trainClass.textColor = baseColor;
    trainClass.text          = @"培训课程";
    trainClass.font          = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    [self addSubview:trainClass];
    
    
    chooseClassView *chooseView = [[chooseClassView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(trainClass.frame) + 20, trainClass.frame.origin.y - 5, 360, 30) superView:self trainClassArray:trainClassArray];
    [self addSubview:chooseView];
    
    UIButton *checkHistoryRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkHistoryRecord.frame     = CGRectMake(CGRectGetMaxX(chooseView.frame) + 20,
                                              trainClass.frame.origin.y - 5,
                                              120,
                                              30);
    checkHistoryRecord.backgroundColor = baseColor;
    [checkHistoryRecord setTintColor:[UIColor whiteColor]];
    [checkHistoryRecord setTitle:@"查询" forState:UIControlStateNormal];
    [checkHistoryRecord addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkHistoryRecord];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20,
                                                               CGRectGetMaxY(trainClass.frame) + 40,
                                                               self.bounds.size.width - 40,
                                                               self.bounds.size.height - CGRectGetMaxY(trainClass.frame) - 40 - 20)
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
    
}
@end
