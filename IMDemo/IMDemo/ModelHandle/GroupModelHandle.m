//
//  GroupModelHandle.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/4.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "GroupModelHandle.h"

@interface GroupModelHandle ()

@property (nonatomic, strong) GroupHandle *groupHandle;
@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, copy) GetUserGroupCompletion getUserGroupCompletion;
@property (nonatomic, copy) CreateGroupCompletion createGroupCompletion;
@end

@implementation GroupModelHandle
- (id)init{
    self = [super init];
    if (self) {
        self.groupHandle = [[GroupHandle alloc] initWithUrl:kUrl Delegate:self];
        self.groupArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

#pragma mark -
#pragma mark - get data
- (void)createGroupWithIds:(NSArray *)ids completion:(CreateGroupCompletion)completion{
    [_groupHandle createGroupWithOptId:kUserName ids:ids];
    self.createGroupCompletion = completion;
}
- (void)getGroupModelWithOptId:(NSString *)optId completion:(GetUserGroupCompletion)completion{
    [_groupHandle getUserGroupsInfoWithOptId:optId];
    self.getUserGroupCompletion = completion;
}


#pragma mark -
#pragma mark - groupHandle delegate
- (void)groupWillCreateWithOptId:(NSString *)optId ids:(NSArray *)ids{
    NSLog(@"groupWillCreate");
}
- (void)groupDidCreateSuccessOptId:(NSString *)optId ids:(NSArray *)ids result:(NSDictionary *)result{
    if (_createGroupCompletion) {
        _createGroupCompletion(result);
    }
}
- (void)groupDidCreateFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"groupDidCreateFail %@", reason);
}
- (void)groupWillGetUserGroupsInfoWithOptId:(NSString *)optId{
    NSLog(@"groupWillGetUserGroupsInfo");
}
- (void)groupDidGetUserGroupsSuccessWithOptId:(NSString *)optId info:(NSArray *)info{
    [self.groupArray removeAllObjects];
    for (NSDictionary *dic in info) {@autoreleasepool{
        Group *group = [[Group alloc] init];
        [group setValuesForKeysWithDictionary:dic];
        [self.groupArray addObject:group];
    }
    }
    NSLog(@"%@", _groupArray);
    if (_getUserGroupCompletion) {
        _getUserGroupCompletion(_groupArray);
    }
}

- (void)groupDidGetUserGroupsInfoFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"groupDidGetUserGroupsInfoFail  %@", reason);
}


#pragma mark -
#pragma mark - data handle
- (NSInteger)numberOfSections{
    return 1;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [_groupArray count];
}
- (Group *)modelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_groupArray objectAtIndex:indexPath.row];
}

@end
