//
//  ContactModelHandle.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/5.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "ContactModelHandle.h"
#import "GroupHandle.h"


@interface ContactModelHandle ()

@property (nonatomic, strong) GroupHandle *groupHandle;
@property (nonatomic, copy) getGroupDetailCompletion getGroupDetailCompletion;
@property (nonatomic, strong) NSMutableArray *contactArray;

@end
@implementation ContactModelHandle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.groupHandle = [[GroupHandle alloc] initWithUrl:kUrl Delegate:self];
        self.contactArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)getGroupDetailInforWithGroupId:(NSString *)groupId completion:(getGroupDetailCompletion)competion{
    [_groupHandle getGroupDetailInfoWithGroupId:groupId];
    self.getGroupDetailCompletion = competion;
}
- (void)groupWillGetGroupDetailInfoWithGroupId:(NSString *)groupId{
    NSLog(@"groupWillGetGroupDetailInfo");
}
- (void)groupDidGetGroupDetailInfoSuccessWithGroupId:(NSString *)groupId detailInfo:(NSDictionary *)detailInfo{
    NSArray *members = [detailInfo objectForKey:@"members"];
    for (NSDictionary *dic in members) {
        Contact *contact = [[Contact alloc] init];
        [contact setValuesForKeysWithDictionary:dic];
        [_contactArray addObject:contact];
    }
    if (_getGroupDetailCompletion) {
        _getGroupDetailCompletion(_contactArray);
    }
}
- (void)groupDidGetGroupDetailInfoFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"groupDidGetGroupDetailInfoFail  %@", reason);
    
}

- (NSInteger)numberOfSections{
    return 1;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [_contactArray count];
}
- (Contact *)modelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_contactArray objectAtIndex:indexPath.row];
}

@end
