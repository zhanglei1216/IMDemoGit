//
//  GroupModelHandle.h
//  IMDemo
//
//  Created by foreveross－bj on 14/12/4.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Group.h"
#import "Contact.h"
#import "IMHeader.h"

typedef void(^ GetUserGroupCompletion)(NSArray *);
typedef void(^ CreateGroupCompletion) (NSDictionary *);


@interface GroupModelHandle : NSObject <groupDelegate>
- (void)createGroupWithIds:(NSArray *)ids completion:(CreateGroupCompletion)completion;
- (void)getGroupModelWithOptId:(NSString *)optId completion:(GetUserGroupCompletion)completion;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (Group *)modelForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
