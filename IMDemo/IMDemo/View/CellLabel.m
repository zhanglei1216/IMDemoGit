 //
//  CellLabel.m
//  HelloWorld
//
//  Created by foreveross－bj on 14-8-29.
//
//

#import "CellLabel.h"
#define BEGIN_FLAG @"["
#define END_FLAG @"]"
#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH 150
#define LINESPACE 18
@implementation CellLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame chatText:(NSString *)chatText
{
    self = [self initWithFrame:frame];
    if (self) {
        self.chatText = chatText;
        self.frame = [self rect:chatText];
    }
    return self;
}

- (NSString *)ChatImageNameWithNameKey:(NSString *)key
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"faceMap_ch1" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic[key];
}

-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
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
- (CGRect)rect:(NSString *) message
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
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
-(void)assembleMessageAtIndex : (NSString *) message
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    NSString *totalStr = @"";
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
                NSString *imageName=[self ChatImageNameWithNameKey:str];
                UIImage *img = [UIImage imageNamed:imageName];
                CGRect rect = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [img drawInRect:rect];
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH) X = upX;
                
                
            }else
            {
                totalStr = [totalStr stringByAppendingString:str];
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
                    [self drawText:temp rect:CGRectMake(upX,upY,size.width,size.height)];
                    upX=upX+size.width;
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                }
            }
        }
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self assembleMessageAtIndex:_chatText];
    
}


- (void)drawText:(NSString *)text rect:(CGRect)rect
{
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    [text drawInRect:rect withFont:fon];
}



@end
