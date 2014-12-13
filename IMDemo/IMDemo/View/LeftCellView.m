//
//  LeftCellView.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/12.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "LeftCellView.h"

#define kHTopSpace 8
#define kHLeftSpace 8
#define kHLong 30
#define kLRSpace 10
#define kCTopSpace 15
#define kCWidth 60
#define kCHeight 46
#define kLWidth 44
#define kLHeight 44
#define kEdgeInsets UIEdgeInsetsMake(20,25,20,25)

@interface LeftCellView ()

@property (strong, nonatomic) CellLabel *textCellLabel;
@property (strong, nonatomic) UIImageView *chatBoxLeft;

@end
@implementation LeftCellView
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
    self.headerImageView.image = [UIImage imageNamed:@"left.jpg"];
    [self addSubview:_headerImageView];
    self.chatBoxLeft = [[UIImageView alloc] initWithFrame:CGRectMake(kHLeftSpace + kHLong + kLRSpace, kCTopSpace, kCWidth, kCHeight)];
    self.chatBoxLeft.image = [[UIImage imageNamed:@"chat_box_left"] resizableImageWithCapInsets:kEdgeInsets];
    [self addSubview:_chatBoxLeft];
    
    self.textCellLabel = [[CellLabel alloc] initWithFrame:CGRectMake(_chatBoxLeft.frame.origin.x + 12, kCTopSpace + 7, kLWidth, kLHeight)];
    [self addSubview:_textCellLabel];
    
}
- (void)setValueWithMessage:(Message *)message{
    [[self.textCellLabel subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([message isKindOfClass:[TextChatMessage class]]) {
        TextChatMessage *textChatMessage = (TextChatMessage *)message;
        CGRect rect = [CellLabelFrame rect:textChatMessage.content];
        self.textCellLabel.chatText = textChatMessage.content;
        self.textCellLabel.frame = CGRectMake(self.textCellLabel.frame.origin.x, self.textCellLabel.frame.origin.y, rect.size.width, rect.size.height);
        self.chatBoxLeft.frame = CGRectMake(_chatBoxLeft.frame.origin.x, _chatBoxLeft.frame.origin.y, rect.size.width + 20, rect.size.height + 20);
    }
}

+ (CGFloat)heightForCellLabelWithMessage:(Message *)message{
    if ([message isKindOfClass:[TextChatMessage class]]) {
        return [CellLabelFrame rect:[(TextChatMessage *)message content]].size.height;
    }else{
        return 60;
    }
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
