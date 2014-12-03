//
//  LoginViewController.h
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoRegister.h"
#import "ConnectSocket.h"

@interface LoginViewController : UIViewController <registerDelegate, SocketDelegate>
@property (nonatomic, copy) void (^ completion)(void);

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;

@end
