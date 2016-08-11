//
//  DairyViewController.m
//  ipad
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "DairyViewController.h"
#import "PhotoManager.h"
@interface DairyViewController ()<UITextViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UITextView *_textView;
    UIButton   *addButton;
    UILabel    *line;
    NSMutableArray *photoArray;
    NSMutableArray *showPhotoArray;
    BOOL       isFirstRequesst;
    BOOL       isFirstFrame;
    NSInteger  imageNumber;
    NSInteger  showImageNumber;
    UIButton   *saveButton;
    UIButton   *removeButton;
    UIProgressView* progressView;
    NSString   *dairy_id;
    NSString   *types;
    
}
@end

@implementation DairyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (isFirstRequesst == NO) {
        
        addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addButton.frame     = CGRectMake(15,
                                         CGRectGetMaxY(progressView.frame) + 15,
                                         (viewWidth - 105) / 6,
                                         (viewWidth - 105) / 6);
        [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [addButton setBackgroundImage:[UIImage imageNamed:@"find_addImage"] forState:UIControlStateNormal];
        [self.view addSubview:addButton];
        
        isFirstRequesst = YES;
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=diary.getdiary&order_id=%@",BASEURL,_order_id];
        [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
            
            
            NSDictionary *dataDict = [responseObject objectForKey:@"data"];
            showPhotoArray         = [NSMutableArray array];
            
            types    = [dataDict count] != 0 ? @"update" : @"add";
            dairy_id = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"id"]];
            
            
            _textView.text = [[dataDict objectForKey:@"coach_content"] length] != 0 ? [dataDict objectForKey:@"coach_content"] : @"说点什么...";
            
            CGRect buttonframe = addButton.frame;
            for (int a = 0; a < [[dataDict objectForKey:@"photo_list"] count]; a++) {
                
                [showPhotoArray addObject:[dataDict objectForKey:@"photo_list"][a]];
                
                UIImageView *imageView = [UIImageView new];
                imageView.contentMode  = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                imageView.tag          = [[[dataDict objectForKey:@"photo_list"][a] objectForKey:@"img_id"] intValue];
                if (a > 5 && a < 8) {
                    
                    imageView.frame        = CGRectMake(15 + ((a %6) *((viewWidth - 105) / 6 + 15)),
                                                        CGRectGetMaxY(progressView.frame) + 15 + ((viewWidth - 105) / 6) ,
                                                        (viewWidth - 105) / 6,
                                                        (viewWidth - 105) / 6);
                    buttonframe.origin.x = CGRectGetMaxX(imageView.frame) + (15);
                    buttonframe.origin.y = CGRectGetMaxY(progressView.frame) + 15 + ((viewWidth - 105) / 6) ;
                    
                } else if (a == 5){
                    imageView.frame        = CGRectMake(15 + (a *((viewWidth - 105) / 6 + 15)),
                                                        CGRectGetMaxY(progressView.frame) + 15 ,
                                                        (viewWidth - 105) / 6,
                                                        (viewWidth - 105) / 6);
                    buttonframe.origin.x = 15;
                    buttonframe.origin.y = CGRectGetMaxY(progressView.frame) + 15 + ((viewWidth - 105) / 6) ;
                    
                    
                } else if (a == 8) {
                    
                    imageView.frame        = CGRectMake(15 + ((a %6) *((viewWidth - 105) / 6 + 15)),
                                                        CGRectGetMaxY(progressView.frame) + 15 + ((viewWidth - 105) / 6) ,
                                                        (viewWidth - 105) / 6,
                                                        (viewWidth - 105) / 6);
                    buttonframe.origin.x = viewWidth;
                    
                    
                } else {
                    imageView.frame        = CGRectMake(15 + (a *((viewWidth - 105) / 6 + 15)),
                                                        CGRectGetMaxY(progressView.frame) + 15 ,
                                                        (viewWidth - 105) / 6,
                                                        (viewWidth - 105) / 6);
                    buttonframe.origin.x = CGRectGetMaxX(imageView.frame) + (15);
                }
                
                
                NSDictionary *photoDict = [dataDict objectForKey:@"photo_list"][a];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[photoDict objectForKey:@"img"]]];
                [self.view addSubview:imageView];
                
                
            }
            addButton.frame = buttonframe;
        } fail:^(NSError *error) {
            
        }];
    }
}


- (void)remoViewImageClick:(UIButton *)button {
    
    NSString *url = [NSString stringWithFormat:@"%@pad/?method=diary.delimg&id=%d",BASEURL,(int)button.tag / 10];
    [HttpTool postWithUrl:url params:nil contentType:CONTENTTYPE success:^(id responseObject) {
        
        [button.superview removeFromSuperview];
        
    } fail:^(NSError *error) {}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    photoArray   = [NSMutableArray array]; // 初始化照片数组
    isFirstFrame = YES;                    // 确认是第一次位置
    
    
    UIView *daohangView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    daohangView.backgroundColor = [UIColor redColor];
    [self.view addSubview:daohangView];
    
    UIImageView *daohangImage = [[UIImageView alloc] initWithFrame:daohangView.frame];
    daohangImage.image = [UIImage imageNamed:@"daohang"];
    daohangImage.userInteractionEnabled = YES;
    [daohangView addSubview:daohangImage];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text     = @"健身日记";
    titlelabel.font     = [UIFont fontWithName:FONT size:36];
    titlelabel.frame    = CGRectMake(380, 17, 300, 30);
    [titlelabel setTextColor:[UIColor whiteColor]];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [daohangView addSubview:titlelabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(50, 7, 100, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [daohangView addSubview:backButton];
    
    
    saveButton       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(viewWidth - 113, 7, 100, 50);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTintColor:UIColorFromRGB(0x7f7f7f)];
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.userInteractionEnabled = NO;
    saveButton.titleLabel.font = [UIFont fontWithName:FONT size:(16)];
    
    [daohangView addSubview:saveButton];
    
    
    
    [self createUI];
}

- (void)createUI {
    
    _textView = [UITextView new];
    _textView.frame = CGRectMake(20,
                                 84,
                                 viewWidth - 40,
                                 150);
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor grayColor];
    
    _textView.font      = [UIFont fontWithName:FONT size:15];
    _textView.text      = @"说点什么...";
    _textView.delegate  = self;
    [self.view addSubview:_textView];
    
    
    
    
    progressView       = [UIProgressView  new];
    progressView.frame = CGRectMake(0,
                                    CGRectGetMaxY(_textView.frame) + 5,
                                    viewWidth,
                                    1);
    progressView.trackTintColor    = [UIColor grayColor];
    progressView.progressTintColor = [UIColor orangeColor];
    [self.view addSubview:progressView];
    
    
    
}



- (void)addButtonClick:(UIButton *)button {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择获取方式" delegate:self cancelButtonTitle:nil otherButtonTitles:@"从相册选取",@"照相",@"取消", nil];
    
    [alert show];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 111) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        if (buttonIndex == 2) return;
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        
        if (buttonIndex == 0) {
            // 从相册选取
            [[PhotoManager getInstance] setShuping];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            // 拍照
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        // 2.允许编辑
        //  imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
    
}
#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 添加照片到数组
    
    NSData *photoData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 1);
    NSDictionary *photoDict = @{@"img_list":photoData};
    
    [photoArray addObject:photoDict];
    
    [self setImageViewFrameWith:info[UIImagePickerControllerOriginalImage]];
    [[PhotoManager getInstance] setHengping];
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[PhotoManager getInstance] setHengping];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}

#pragma mark - 布置图片显示位置
- (void)setImageViewFrameWith:(UIImage *)image  {
    
    imageNumber++;
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame        = addButton.frame;
    imageView.image        = image;
    
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
    
    if (imageNumber < 9) {
        CGRect buttonframe = addButton.frame;
        if (imageNumber %6 == 0 && isFirstFrame == NO) {
            
            buttonframe.origin.x =  15;
            buttonframe.origin.y = CGRectGetMaxY(imageView.frame) + (15);
        } else {
            
            buttonframe.origin.x = CGRectGetMaxX(imageView.frame) + (15);
            isFirstFrame = NO;
        }
        addButton.frame    = buttonframe;
    } else {
        [addButton removeFromSuperview];
    }
}

- (void)saveButtonClick:(UIButton *)button {
    
    if ([types isEqualToString:@"add"]) {
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=diary.add",BASEURL];
        NSDictionary *dict = @{@"order_id":_order_id,
                               @"content":_textView.text};
        
        
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url
                                                                       parameters:dict
                                                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                            
                                                            for (NSDictionary *dict in photoArray) {
                                                                NSString *name = [dict allKeys][0];
                                                                
                                                                [formData appendPartWithFileData:dict[name] name:name fileName:@"upload.jpg" mimeType:@"image/jpg"];
                                                            }
                                                        }];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *op =
        [manager HTTPRequestOperationWithRequest:request
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             NSLog(@"Success %@", responseObject);
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                             alert.tag = 111;
                                             [alert show];
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Failure %@", error);
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器错误，正在排查中..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                             [alert show];
                                         }];
        
        [op setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                     long long totalBytesWritten,
                                     long long totalBytesExpectedToWrite) {
            
            
            progressView.progress = totalBytesWritten / totalBytesExpectedToWrite;
        }];
        [op start];
    } else {
        
        NSString *url = [NSString stringWithFormat:@"%@pad/?method=diary.update",BASEURL];
        NSDictionary *dict = @{@"id":dairy_id,
                               @"content":_textView.text};
        
        NSLog(@"url %@",url);
        [HttpTool postWithUrl:url params:dict contentType:CONTENTTYPE success:^(id responseObject) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alert.tag = 111;
            [alert show];
            
        } fail:^(NSError *error) {}];
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    NSMutableString * changedString = [[NSMutableString alloc]initWithString:textView.text];
    [changedString replaceCharactersInRange:range withString:text];
    
    if (changedString.length!=0) {
        
        [saveButton setTintColor:[UIColor whiteColor]];
        saveButton.userInteractionEnabled = YES;
        
    } else {
        [saveButton setTintColor:UIColorFromRGB(0x7f7f7f)];
        saveButton.userInteractionEnabled = NO;
        
    }
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"说点什么..."]) {
        textView.text = @"";
    }
    
}

-(void)goback:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [removeButton removeFromSuperview];
}

@end
