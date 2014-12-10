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

- (void)getGroupModelWithOptId:(NSString *)optId Completion:(GetUserGroupCompletion)completion{
    [_groupHandle getUserGroupsInfoWithOptId:optId];
    self.getUserGroupCompletion = completion;
}

- (void)groupWillGetUserGroupsInfoWithOptId:(NSString *)optId{
    NSLog(@"groupWillGetUserGroupsInfoWithOptId");
}
- (void)groupDidGetUserGroupsSuccessWithOptId:(NSString *)optId Info:(NSArray *)info{
    [self.groupArray removeAllObjects];
    for (NSDictionary *dic in info) {@autoreleasepool{
        Group *group = [[Group alloc] init];
        [group setValuesForKeysWithDictionary:dic];
        [self.groupArray addObject:group];
    }
    }
    if (_getUserGroupCompletion) {
        _getUserGroupCompletion(_groupArray);
    }
}


- (void)groupDidGetUserGroupsInfoFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"groupDidGetUserGroupsInfoFail  %@", reason);
}
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
