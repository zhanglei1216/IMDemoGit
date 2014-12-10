//
//  InputVIew.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/7.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "InputVIew.h"

#define kBLong 34
#define kTWidth 175
#define kTHeight 30
#define kLRSpace 8
#define kTopSpace 5

@interface InputVIew ()

@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *sendButton;

@end
@implementation InputVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backImageView.image = [UIImage imageNamed:@"lt_bg"];
    [self addSubview:backImageView];
    self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _faceButton.frame = CGRectMake(kLRSpace, kTopSpace, kBLong, kBLong);
    [_faceButton addTarget:self action:@selector(showFaceView) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"bq_nor"] forState:UIControlStateNormal];
    [self addSubview:_faceButton];
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.frame = CGRectMake(kLRSpace * 2 + kBLong , kTopSpace, kBLong, kBLong);
    [_photoButton setBackgroundImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_photoButton];
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLRSpace * 3 + kBLong * 2, kTopSpace + 2, kTWidth, kTHeight)];
    _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_inputTextField];
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(kLRSpace * 4 + kBLong * 2 + kTWidth, kTopSpace, kBLong, kBLong);
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [self addSubview:_sendButton];
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineImageView];
    
}
- (void)showFaceView{
    if (_delegate && [_delegate respondsToSelector:@selector(showFaceView)]) {
        [_delegate showFaceView];
    }
}
- (void)takePhoto{
    if (_delegate && [_delegate respondsToSelector:@selector(takePhoto)]) {
        [_delegate takePhoto];
    }
}

- (void)sendMessage{
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage)]) {
        [_delegate sendMessage];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
