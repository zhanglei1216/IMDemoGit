//
//  ContactModelHandle.h
//  IMDemo
//
//  Created by foreveross－bj on 14/12/5.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GroupHandle.h"
#import "Contact.h"

typedef void (^getGroupDetailCompletion)(NSArray *);

@interface ContactModelHandle : NSObject<groupDelegate>
- (void)getGroupDetailInforWithGroupId:(NSString *)groupId completion:(getGroupDetailCompletion)competion;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (Contact *)modelForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
