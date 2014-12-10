//
//  Group.h
//  IMDemo
//
//  Created by foreveross－bj on 14-12-2.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, strong) NSString *accountUid;
@property (nonatomic, strong) NSNumber *createDate;
@property (nonatomic, strong) NSString *modifyDate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSNumber *userCount;
@property (nonatomic) BOOL isOpen;
@end
