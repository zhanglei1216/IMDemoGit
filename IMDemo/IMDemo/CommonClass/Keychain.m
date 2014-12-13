//
//  Keychain.m
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "Keychain.h"

static NSString *const KEY_PASSWORD_IN_KEYCHAIN = @"com.lasebeike.app.passwordInfo";
static NSString *const KEY_PASSWORD = @"com.lansebeike.app.password";
static NSString *const KEY_UDID_IN_KEYCHAIN = @"com.lansebeike.app.UDIDInfo";
static NSString *const KEY_UDID = @"com.lansebeike.app.UDID";
static NSString *const KEY_APP_ID_IN_KEYCHAIN = @"com.lansebeike.app.appIdInfo";
static NSString *const KEY_APP_ID = @"com.lansebeike.app.appId";

@implementation Keychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}


+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [self save:KEY_PASSWORD_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[self load:KEY_PASSWORD_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [self delete:KEY_PASSWORD_IN_KEYCHAIN];
}
+(void)saveUDID:(NSString *)UDID
{
    NSMutableDictionary *UUIDKVPairs = [NSMutableDictionary dictionary];
    [UUIDKVPairs setObject:UDID forKey:KEY_UDID];
    [self save:KEY_UDID_IN_KEYCHAIN data:UUIDKVPairs];
}

+(id)readUDID
{
    NSMutableDictionary *UUIDKVPairs = (NSMutableDictionary *)[self load:KEY_UDID_IN_KEYCHAIN];
    return [UUIDKVPairs objectForKey:KEY_UDID];
}

+(void)deleteUDID
{
    [self delete:KEY_UDID_IN_KEYCHAIN];
}
+(void)saveAppId:(NSString *)appId
{
    NSMutableDictionary *appIdKVPairs = [NSMutableDictionary dictionary];
    [appIdKVPairs setObject:appId forKey:KEY_APP_ID];
    [self save:KEY_APP_ID_IN_KEYCHAIN data:appIdKVPairs];
}

+(id)readAppId
{
    NSMutableDictionary *appIdKVPairs = (NSMutableDictionary *)[self load:KEY_APP_ID_IN_KEYCHAIN];
    return [appIdKVPairs objectForKey:KEY_APP_ID];
}

+(void)deleteAppId
{
    [self delete:KEY_APP_ID_IN_KEYCHAIN];
}


@end
