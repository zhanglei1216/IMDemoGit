//
//  CellLabel.h
//  HelloWorld
//
//  Created by foreveross－bj on 14-8-29.
//
//

#import <UIKit/UIKit.h>

@interface CellLabel : UILabel
{
    BOOL isDo;
}
@property (nonatomic, strong) NSString *chatText;

- (id)initWithFrame:(CGRect)frame chatText:(NSString *)chatText;

@end
