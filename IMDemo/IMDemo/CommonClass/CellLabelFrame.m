//
//  CellLabelFrame.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/12.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "CellLabelFrame.h"

#define BEGIN_FLAG @"["
#define END_FLAG @"]"
#define KFacialSizeWidth  24
#define KFacialSizeHeight 24
#define MAX_WIDTH 150
#define LINESPACE 24

@implementation CellLabelFrame
+ (void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}
+ (CGRect)rect:(NSString *) message
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:18.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH - 9)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH) X = upX;
                
                
            }else
            {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MAX_WIDTH - 9)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 40)];
                    upX=upX+size.width;
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                }
            }
        }
    }
    return CGRectMake(0,0, X, Y + 18); //@ 需要将该view的尺寸记下，方便以后使用
}
@end
