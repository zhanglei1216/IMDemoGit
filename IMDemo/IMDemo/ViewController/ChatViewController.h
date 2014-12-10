//
//  ChatViewController.h
//  IMDemo
//
//  Created by foreveross－bj on 14/12/6.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputVIew.h"

@interface ChatViewController : UIViewController<UITextFieldDelegate, InputViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *accountId;

@end
