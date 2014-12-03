//
//  Keychain.h
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keychain : NSObject
/**
 * @param password
 **/
+(void)savePassWord:(NSString *)password;
/**
 * @return password
 **/
+(id)readPassWord;
/**
 * delete password in keychain
 **/
+(void)deletePassWord;
/**
 * @param UUID
 **/
+(void)saveUDID:(NSString *)UDID;
/**
 * @return UUID
 **/
+(id)readUDID;
/**
 * delete UDID in keychain
 **/
+(void)deleteUDID;
/**
 * @param appId
 **/
+(void)saveAppId:(NSString *)appId;
/**
 * @return appId
 **/
+(id)readAppId;
/**
 * delete UDID in keychain
 **/
+(void)deleteAppId;

@end
