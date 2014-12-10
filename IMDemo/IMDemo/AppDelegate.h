//
//  AppDelegate.h
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMHeader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SocketDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SocketStream *socket;

@end

