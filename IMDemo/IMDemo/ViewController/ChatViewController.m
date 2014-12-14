//
//  ChatViewController.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/6.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "ChatViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "JKFaceView.h"
#import "InputVIew.h"
#import "IMHeader.h"
#import "AppDelegate.h"
#import "LeftCellView.h"
#import "rightCellView.h"

#define kFaceViewHeight 150
#define kInputViewHeight 44

@interface ChatViewController ()
{
    BOOL isFaceViewShow;
}

@property (strong, nonatomic) InputVIew *inputView;
@property (strong, nonatomic) JKFaceView *faceView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) NSMutableArray *messageArray;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kInputViewHeight)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addGestureRecognizer:tapGesture];
    [self.view addSubview:_tableView];
    
    self.inputView = [[InputVIew alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kInputViewHeight, self.view.frame.size.width, kInputViewHeight)];
    _inputView.delegate = self;
    [self.view addSubview:_inputView];
    
    _faceView = [[JKFaceView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width,kFaceViewHeight)];
    _faceView.bindView = _inputView.inputTextField;
    [self.view addSubview:_faceView];
    isFaceViewShow = NO;
    _inputView.inputTextField.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:@"didReceivedMessage" object:nil];
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
    self.messageArray = [NSMutableArray arrayWithCapacity:10];
}
- (void)showFaceView{
    isFaceViewShow = YES;
    [_inputView.inputTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _faceView.frame = CGRectMake(0, self.view.frame.size.height - kFaceViewHeight, self.view.frame.size.width, kFaceViewHeight);
        _inputView.frame = CGRectMake(0, _faceView.frame.origin.y - kInputViewHeight, self.view.frame.size.width, kInputViewHeight);
    } completion:nil];
}
- (void)hiddenFaceView{
    [UIView animateWithDuration:0.3 animations:^{
        _faceView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width,kFaceViewHeight);
    } completion:nil];
}
- (void)changeInputViewFrame:(CGRect)frame{
    [UIView animateWithDuration:0.3 animations:^{
        _inputView.frame = frame;
    } completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_inputView.inputTextField resignFirstResponder];
    return YES;
}
- (void)takePhoto{
    [self hiddenKeyboard];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选取照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.showsCameraControls = YES;
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        _imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        _imagePicker.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
        //        imagePicker.allowsEditing = YES;
        //        imagePicker.showsCameraControls = YES;
        
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取照片的原图
    UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
//    //获取图片裁剪后剩下的图
//    UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];
    //获取图片的url
    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    //获取图片的metadata数据信息
    NSDictionary* metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
    //如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
    UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    
    NSLog(@"saved..");
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_messageArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    ChatMessage *message = [_messageArray objectAtIndex:indexPath.row];
    if ([message.from isEqualToString:[NSString stringWithFormat:@"T#%@", kUserName]]) {
        static NSString *identifier = @"rightCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[rightCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [(rightCellView *)cell setValueWithMessage:message];
    }else{
        static NSString *identifier = @"leftCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LeftCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [(LeftCellView *)cell setValueWithMessage:message];
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [CellLabelFrame rect:[(TextChatMessage *)[_messageArray objectAtIndex:indexPath.row] content]].size.height;
    if (height < 60) {
        return 80;
    }else{
        return height + 30;
    }
}
- (void)sendMessage{
    TextChatMessage *textMessage = [[TextChatMessage alloc] initWithId:[[NSUUID UUID]  UUIDString] to:[NSString stringWithFormat:@"T#%@", _accountId] from:[NSString stringWithFormat:@"T#%@", kUserName] timestap:[[NSDate date] timeIntervalSince1970]];
    NSLog(@"%@", textMessage.to);
    textMessage.content = _inputView.inputTextField.text;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.socket sendMessage:textMessage];
    [_messageArray addObject:textMessage];
    [self.tableView reloadData];
}
- (void)didReceiveMessage:(NSNotification *)notification{
    ChatMessage *message = notification.object;
    if ([message.from isEqualToString:[NSString stringWithFormat:@"T#%@", _accountId]]) {
        [_messageArray addObject:message];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
}
- (void)hiddenKeyboard{
    [_inputView.inputTextField resignFirstResponder];
    if (isFaceViewShow == YES) {
        [self hiddenFaceView];
    }
    [self  changeInputViewFrame:CGRectMake(0, self.view.frame.size.height - kInputViewHeight, self.view.frame.size.width, kInputViewHeight)];
}
- (void)keyBoardWillShow:(NSNotification *)notification{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        [self changeInputViewFrame:CGRectMake(keyboardBounds.origin.x, keyboardBounds.origin.y - kInputViewHeight, self.view.frame.size.width, kInputViewHeight)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
