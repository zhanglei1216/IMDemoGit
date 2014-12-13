//
//  LeftCellView.h
//  IMDemo
//
//  Created by foreveross－bj on 14/12/12.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellLabel.h"
#import "IMHeader.h"
#import "CellLabelFrame.h"

@interface LeftCellView : UITableViewCell


@property (strong, nonatomic) UIImageView *headerImageView;

- (void)setValueWithMessage:(Message *)message;
+ (CGFloat)heightForCellLabelWithMessage:(Message *)message;


@end
