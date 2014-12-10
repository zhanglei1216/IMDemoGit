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

typedef void(^GetUserGroupCompletion)(NSArray *);



@interface GroupModelHandle : NSObject <groupDelegate>

- (void)getGroupModelWithOptId:(NSString *)optId Completion:(GetUserGroupCompletion)completion;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (Group *)modelForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
