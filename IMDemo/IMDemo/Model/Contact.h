//
//  Contact.h
//  IMDemo
//
//  Created by foreveross－bj on 14-12-2.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *accountUid;
@property (nonatomic, strong) NSString *nicename;
@property (nonatomic, strong) NSNumber *addDate;
@property (nonatomic, strong) NSString *groupUid;
@property (nonatomic, strong) NSString *inviteAccountUid;
@property (nonatomic) BOOL     isMsgNotity;
@property (nonatomic) BOOL     isSave;
@property (nonatomic) BOOL     isShowMemberNicename;
@property (nonatomic) BOOL     isTop;

@end
