//
//  JKFaceView.h
//  HanYuanCXSHS
//
//  Created by jack.luo on 13-12-15.
//  Copyright (c) 2013年 machair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKFaceView : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrollView;//表情滚动视图
    
    UIPageControl *pageControl;
}

@property (nonatomic, retain) UIView *bindView;
@end
