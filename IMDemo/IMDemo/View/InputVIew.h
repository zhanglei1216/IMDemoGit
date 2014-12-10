//
//  InputVIew.h
//  IMDemo
//
//  Created by foreveross－bj on 14/12/7.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputViewDelegate <NSObject>
- (void)showFaceView;
- (void)takePhoto;
- (void)sendMessage;
@end
@interface InputVIew : UIView

@property (strong, nonatomic) UITextField *inputTextField;
@property (assign, nonatomic) id<InputViewDelegate> delegate;

@end
