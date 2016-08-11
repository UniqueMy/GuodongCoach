//
//  QuestionView.m
//  ipad
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 Unique. All rights reserved.
//
#import "AppDelegate.h"
#import "QuestionReplyCell.h"
#import "QuestionCommentCell.h"
#import "QuestionContentCell.h"
#import "QuestionContent.h"
#import "QuestionReply.h"
#import "QuestionView.h"

@interface QuestionView ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>
{
    int page;
    UITableView    *_tableView;
    NSMutableArray *contentArray;
    NSString       *talk_id;
    NSString       *reply_id;
    NSString       *comment_id;
    NSString       *types;
    TextFieldView  *textView;
}
@end

@implementation QuestionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        page = 2;
        contentArray  = [NSMutableArray array];
        [self createUI];
        // 2.集成刷新控件
        [self setupRefresh];
    }
    return self;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    NSString *URL = [NSString stringWithFormat:@"%@pad/?method=questions.index",BASEURL];
    
    [HttpTool postWithUrl:URL params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        NSDictionary *data = [responseObject objectForKey:@"data"];
        [contentArray removeAllObjects];
        
        if ([[data objectForKey:@"data_list"] count] != 0) {
            for (NSDictionary *dict in [data objectForKey:@"data_list"]) {
                
                QuestionContent *contentModel = [[QuestionContent alloc]
                                                 initWithDictionary:dict];
                [contentArray addObject:contentModel];
            }
            [_tableView reloadData];
        }
        // 结束刷新状态
        [_tableView headerEndRefreshing];
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)footerRereshing
{
    NSString *URL = [NSString stringWithFormat:@"%@pad/?method=questions.index&page=%d",BASEURL,page];
    
    [HttpTool postWithUrl:URL params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        
        if ([[data objectForKey:@"data_list"] count] != 0) {
            for (NSDictionary *dict in [data objectForKey:@"data_list"]) {
                
                QuestionContent *contentModel = [[QuestionContent alloc]
                                                 initWithDictionary:dict];
                [contentArray addObject:contentModel];
            }
            [_tableView reloadData];
            page++;
        } else {
            _tableView.footerRefreshingText = @"没有新的数据了...";
        }
        // 结束刷新状态
        [_tableView footerEndRefreshing];
    } fail:^(NSError *error) {}];
    
    
}


- (void)createUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    textView = [[TextFieldView alloc] initWithFrame:CGRectMake(0, viewHeight - 64, viewWidth, (42))];
    [textView.publishButton addTarget:self action:@selector(CommentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    textView.backgroundColor = [UIColor colorWithRed:201/255.0
                                               green:205/255.0
                                                blue:211/255.0
                                               alpha:1];
    textView.textField.backgroundColor = [UIColor colorWithRed:187/255.0
                                                         green:194/255.0
                                                          blue:201/255.0
                                                         alpha:1];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //  _tableView.backgroundColor = BASECOLOR;
    
    [self addSubview:_tableView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return contentArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QuestionContent *contentModel = contentArray[section];
    // 内容 + 评论 + 回复数组长度
    NSInteger length;
    
    if ([contentModel.commentdict count] == 0) {
        length = 1 ;
    } else if (contentModel.replyArray.count == 0) {
        length = 2 ;
    } else {
        length = 1 + 1 + contentModel.replyArray.count;
    }
    return length;
    
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    return blackView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        // 答疑的内容cell
        QuestionContent *content = contentArray[indexPath.section];
        static NSString *cellidentifier    = @"contentcell";
        
        QuestionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (cell == nil)
        {
            cell = [[QuestionContentCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.contentModel = content;
        
        return cell;
    } else if (indexPath.row == 1) {
        
        // 答疑的评论cell
        static NSString *cellidentifier = @"commentcell";
        
        QuestionCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (cell == nil)
        {
            cell = [[QuestionCommentCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        QuestionContent *content = contentArray[indexPath.section];
        cell.contentModel = content;
        
        return cell;
        
    } else  {
        // 答疑的回复cell
        
        
        static NSString *cellidentifier = @"replycell";
        
        QuestionReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (cell == nil)
        {
            cell = [[QuestionReplyCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        QuestionContent *content  = contentArray[indexPath.section];
        QuestionReply *replyModel = content.replyArray[indexPath.row - 2];
        cell.reply                = replyModel;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /**
     *  判断哪一行能点击  第一行不能点  教练评论行 通过值判断  行数大于二 通过值判断
     */
    QuestionContent *content = contentArray[indexPath.section];
    if (indexPath.row == 0) {
        
        [textView.textField becomeFirstResponder];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        [app.window addSubview:textView];
        
        talk_id = content.talk_id;
        types   = @"content";
        
    }
    
    if (indexPath.row == 1) {
        
        comment_id = content.comment_id;
        
        NSLog(@"[HttpTool getUser_id] %@ content.user_id  %@",[HttpTool getUser_id],content.comment_userid);
            if ([[HttpTool getUser_id] isEqualToString:content.comment_userid]) {
        
                [textView.textField becomeFirstResponder];
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                
                [app.window addSubview:textView];
                
                talk_id = content.talk_id;
                types   = @"modify";
               
                
            }

    }
    
    if (indexPath.row > 2 ) {
         QuestionReply   *reply   = content.replyArray[indexPath.row - 2];
        
        if ([reply.isClick isEqualToString:@"1"]) {
            [textView.textField becomeFirstResponder];
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            
            [app.window addSubview:textView];
            
            reply_id = reply.reply_id;
            types    = @"2";
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        QuestionContentCell *contentCell = (QuestionContentCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return contentCell.frame.size.height;
    } else if (indexPath.row == 1){
        QuestionCommentCell *commentCell = (QuestionCommentCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return commentCell.frame.size.height;
    } else  {
        QuestionReplyCell *replyCell = (QuestionReplyCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return replyCell.frame.size.height;
    }
}

#pragma mark - 回复按钮点击事件
- (void)CommentButtonClick:(UIButton *)button
{
    [textView.textField resignFirstResponder];
    
    NSDictionary *dict;
    NSString     *Url;
    if ([types isEqualToString:@"content"]) {
        dict = @{@"talkid":talk_id,
                 @"info":textView.textField.text};
        Url = [NSString stringWithFormat:@"%@pad/?method=coach.comments",BASEURL];
    } else if ([types isEqualToString:@"modify"]) {
        
        dict = @{@"id":comment_id,
                 @"info":textView.textField.text};
        Url = [NSString stringWithFormat:@"%@pad/?method=coach.modify_comments",BASEURL];
        
    } else {
        dict = @{@"rid":reply_id,
                 @"types":types,
                 @"content":textView.textField.text};
        Url = [NSString stringWithFormat:@"%@pad/?method=questions.replay",BASEURL];

    }
    NSLog(@"dict %@",dict);
    [HttpTool postWithUrl:Url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //重新请求数据
        textView.textField.text = @"";
        [self headerRereshing];
    }
    
}
//表随键盘高度变化
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    textView.frame = CGRectMake(0, viewHeight - 62 - deltaY , viewWidth, 42);
    
}
-(void)keyboardHide:(NSNotification *)note
{
    [textView.textField resignFirstResponder];
    textView.frame = CGRectMake(0, viewHeight - 64, viewWidth, 42);
    [textView removeFromSuperview];
}

@end
