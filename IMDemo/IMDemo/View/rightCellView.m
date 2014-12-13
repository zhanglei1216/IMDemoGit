//
//  LeftCellView.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/12.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "rightCellView.h"
#import "CellLabelFrame.h"

#define kHTopSpace 8
#define kHLeftSpace 282
#define kHLong 30
#define kLRSpace 10
#define kCLeftSpace 230
#define kCTopSpace 15
#define kCWidth 60
#define kCHeight 46
#define kLWidth 44
#define kLHeight 44
#define kEdgeInsets UIEdgeInsetsMake(20,25,20,25)

@interface rightCellView ()

@property (strong, nonatomic) UIImageView *chatBoxright;
@property (strong, nonatomic) CellLabel *textCellLabel;

@end
@implementation rightCellView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHLeftSpace, kHTopSpace, kHLong, kHLong)];
    self.headerImageView.image = [UIImage imageNamed:@"right.jpg"];
    [self addSubview:_headerImageView];
    self.chatBoxright = [[UIImageView alloc] initWithFrame:CGRectMake(kCLeftSpace, kCTopSpace, kCWidth, kCHeight)];
    self.chatBoxright.image = [[UIImage imageNamed:@"chat_box_right"] resizableImageWithCapInsets:kEdgeInsets];
    [self addSubview:_chatBoxright];
    
    self.textCellLabel = [[CellLabel alloc] initWithFrame:CGRectMake(_chatBoxright.frame.origin.x + 10, kCTopSpace + 7, kLWidth, kLHeight)];
    [self addSubview:_textCellLabel];
    
}
- (void)setValueWithMessage:(Message *)message{
    [[self.textCellLabel subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([message isKindOfClass:[TextChatMessage class]]) {
        TextChatMessage *textChatMessage = (TextChatMessage *)message;
        CGRect rect = [CellLabelFrame rect:textChatMessage.content];
        self.textCellLabel.chatText = textChatMessage.content;
        self.textCellLabel.frame = CGRectMake(kHLeftSpace - kLRSpace * 2 - rect.size.width, self.textCellLabel.frame.origin.y, rect.size.width, rect.size.height);
        self.chatBoxright.frame = CGRectMake(kHLeftSpace - kLRSpace - rect.size.width - 20, _chatBoxright.frame.origin.y, rect.size.width + 20, rect.size.height + 20);
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCellLabelWithMessage:(Message *)message{
    if ([message isKindOfClass:[TextChatMessage class]]) {
        return [CellLabelFrame rect:[(TextChatMessage *)message content]].size.height;
    }else{
        return 60;
    }
}

@end
