//
//  Content.m
//  ipad
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "Content.h"
#import "SectionHeader.h"
#import "IndexTableViewCell.h"
#import "ContentTableViewCell.h"
#import "ContentModel.h"
#import "Content_Row_Model.h"
@interface Content ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_contentTableView;
    UITableView    *_indexTableView;
    NSMutableArray *content_sectionArray;
   
}
@end
@implementation Content

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createTableView];
        [self startRequest];
        
    }
    return self;
}

- (void)startRequest {
    // 内容请求
    NSString *contentURL = [NSString stringWithFormat:@"%@pad/?method=train.all_content",BASEURL];
    [HttpTool postWithUrl:contentURL params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        // 遍历数组取出字典
        content_sectionArray = [NSMutableArray array];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            
            
            ContentModel *model = [[ContentModel alloc] initWithDictionary:dict];
            [content_sectionArray addObject:model]; // 字典装于数组 判断区数
            
        }
        [_indexTableView reloadData];
        [_contentTableView reloadData];
        
        NSDictionary   *trainClassDict = @{@"trainClass":content_sectionArray};
        NSNotification *notification   = [NSNotification notificationWithName:@"trainClass" object:nil userInfo:trainClassDict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } fail:^(NSError *error) {}];
    
}


#pragma mark - UITableView - Delegate - Datasouce
- (void)createTableView {
    
    
    
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      self.bounds.size.width - 100,
                                                                      self.bounds.size.height - 20)
                                                     style:UITableViewStylePlain];
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.delegate     = self;
    _contentTableView.tag          = 10;
    _contentTableView.dataSource   = self;
    _contentTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_contentTableView];
    NSLog(@"table  %f",_contentTableView.bounds.size.width);
    
    // 设置索引tableView
    _indexTableView = [[UITableView alloc]
                       initWithFrame:CGRectMake(CGRectGetMaxX(_contentTableView.frame), 0, 100, self.bounds.size.height - 20)
                       style:UITableViewStylePlain];
    _indexTableView.delegate   = self;
    _indexTableView.tag        = 20;
    _indexTableView.dataSource = self;
    _indexTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _indexTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:_indexTableView];
    
}

// 设置有多少区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return content_sectionArray.count;
}
//区头高度
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return  60;
    } else {
        return 40;
    }
}

// 自定义区头的标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ContentModel *model = [content_sectionArray objectAtIndex:section];
    if (tableView.tag == 10) {
        CGRect rect = CGRectMake(30,
                                 0,
                                 tableView.bounds.size.width - 60,
                                 60);
        
        SectionHeader *headView    = [[SectionHeader alloc] initWithFrame:rect];
        headView.sectionLabel.text = [NSString stringWithFormat:@"【%@】%@",model.sectionName,model.sectionString];
        return headView;
    } else {
        
        UIView *indexView         = [UIView new];
        indexView.backgroundColor = [UIColor whiteColor];
        indexView.frame           = CGRectMake(0, 0, 100, 40);
        
        UIImageView *indexImageView = [UIImageView new];
        indexImageView.image        = [UIImage imageNamed:@"round"];
        indexImageView.frame        = CGRectMake(10, 12, 28, 28);
        [indexView addSubview:indexImageView];
        
        return indexView;
    }
}
// 设置有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ContentModel *model = content_sectionArray[section];
    return model.rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentModel *model         = content_sectionArray[indexPath.section];
    Content_Row_Model *rowModel = model.rowArray[indexPath.row];
    
    if (tableView.tag == 10) {
        
        static NSString *cellidentifier = @"contentCell";
        
        ContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!contentCell)
        {
            contentCell = [[ContentTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        }
        contentCell.contentRowModel = model.rowArray[indexPath.row];
        return contentCell;
    } else {
        
        static NSString *cellidentifier = @"indexCell";
        
        IndexTableViewCell *indexCell   = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!indexCell)
        {
            indexCell = [[IndexTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        }
        indexCell.indexLabel.text =  rowModel.rowName;
        return indexCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 10) {
       
    } else {
       
        // 获取所点目录对应的indexPath值
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        
        // 让table滚动到对应的indexPath位置
        [_contentTableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 10) {
        ContentModel *model        = content_sectionArray[indexPath.section];
        ContentTableViewCell *cell = model.cellRowArray[indexPath.row];
        cell.contentRowModel       = model.rowArray[indexPath.row];
        
        return cell.height;
    } else {
        return 25;
    }
}

@end
