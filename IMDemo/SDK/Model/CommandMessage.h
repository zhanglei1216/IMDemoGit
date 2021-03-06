//
//  CommandMessage.h
//  IMSDK
//
//  Created by foreveross－bj on 14-10-30.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "Message.h"
/**
 * @author zhanglei
 *
 * @Date 2014月10月30日
 *
 * @Version 1.0
 *
 **/
@interface CommandMessage : Message

#pragma mark -
#pragma mark - attribute
@property (nonatomic, assign) Byte commType;

#pragma mark -
#pragma mark - Initialized and Creating
/**
 * @param commType
 **/
- (id)initWithCommType:(Byte)commType;

@end

