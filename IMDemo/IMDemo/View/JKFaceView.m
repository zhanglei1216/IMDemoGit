//
//  JKFaceView.m
//  HanYuanCXSHS
//
//  Created by jack.luo on 13-12-15.
//  Copyright (c) 2013年 machair. All rights reserved.
//

#import "JKFaceView.h"

@implementation JKFaceView
@synthesize bindView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadView];
    }
    return self;
}


-(void) loadView{
    CGRect rect = [[UIScreen mainScreen]bounds];
    if (scrollView==nil) {
        scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 150)];
        [scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"facesBack"]]];
        for (int k=0; k<5; k++) {
            UIView *v = [self createPageView:k];
            [scrollView addSubview:v];
            [v release];
        }
    }
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    scrollView.contentSize=CGSizeMake(rect.size.width*5, 150);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    [self addSubview:scrollView];
    [scrollView release];
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(158, 130, 0, 0)];
    [pageControl setCurrentPage:0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:158 / 255.0 green:130 / 255.0 blue:0 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:195 / 255.0 green:104 / 255.0 blue:77 / 255.0 alpha:1];
    pageControl.numberOfPages = 5;//指定页面个数
    pageControl.hidden=NO;
    [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    [pageControl release];
}

- (UIView*) createPageView:(int)page {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12 + [[UIScreen mainScreen]bounds].size.width*page, 15,
                                                           [[UIScreen mainScreen]bounds].size.width, 100)];
    for (int i=0; i<3; i++) {
        for (int y=0; y<9; y++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setFrame:CGRectMake(y*33, i*33, 29, 29)];
            NSString *imagename = nil;
//            if (page * 27 + i*9 + y > 9){
////                if( page * 27 + i*9 + y + 1 > 23)
////                    break;
//                imagename = [NSString stringWithFormat:@"emoji_%d.png",page * 27 + i*9 + y + 1];
//            }
//            else if(page * 27 + i*9 + y +1 == 10){
//                imagename = @"emoji_117.png";

           // }
//            else {
//                imagename = [NSString stringWithFormat:@"emo0%d.png",page * 27 + i*9 + y + 1];
//
//            }
            if( page * 27 + i*9 + y + 1 > 27*(page+1))
                break;
            imagename = [NSString stringWithFormat:@"emoji_%d.png",page * 27 + i*9 + y + 1];
            //NSLog(@"%@", imagename);
            if (i==2&&y==8) {
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            button.tag = page * 27 + i*9 + y;
            [view addSubview:button];
        }
    }
    //NSLog(@"view --%@ \n",view);
    
    return view;
}

- (void)selected:(UIButton *)sender{
        int k = sender.tag;
        k++;
        NSString *imagename = [NSString stringWithFormat:@"emoji_%d",k];
   
        
        NSDictionary *dic  = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]];
        NSString *value = [dic objectForKey:imagename];
        if ([self.bindView isKindOfClass:[UITextField class]]) {
            UITextField *input = (UITextField *)self.bindView;
            NSString *t = nil;
            if (input.text) {
                t  = [NSString stringWithFormat:@"%@%@",input.text,value];
            } else {
                t = value;
            }
            input.text = t;
        } else if ([self.bindView isKindOfClass:[UITextView class]]){
            UITextView *input = (UITextView *)self.bindView;
            NSString *t = nil;
            if (input.text) {
                t  = [NSString stringWithFormat:@"%@%@",input.text,value];
            } else {
                t = value;
            }
            input.text = t;
        }
}

- (void)delete:(UIButton*)sender{
    NSDictionary *dic  = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]];

    if (self.bindView) {
        if ([self.bindView isKindOfClass:[UITextField class]]) {
            UITextField *input = (UITextField *)self.bindView;
            NSString *inputString;
            inputString = input.text;
            NSString *string = nil;
            NSInteger stringLength = inputString.length;
            if (stringLength > 0) {
                if ([@"[" isEqualToString:[[inputString substringFromIndex:stringLength-4] substringToIndex:1]]) {
                    if ([[dic allValues] containsObject:[inputString substringFromIndex:stringLength-4]]) {
                        string = [inputString substringToIndex:stringLength - 4];
                    }
                } else {
                    string = [inputString substringToIndex:stringLength - 1];
                }
            }
            input.text = string;
        }
//        else if ([self.bindView isKindOfClass:[UITextView class]]){
//            UITextView *input = (UITextView *)self.bindView;
//            NSString *inputString;
//            inputString = input.text;
//            NSString *string = nil;
//            NSInteger stringLength = inputString.length;
//            if (stringLength > 0) {
//                if ([@"/" isEqualToString:[[inputString substringFromIndex:stringLength-3] substringToIndex:1]]) {
//                    if ([[dic allValues] containsObject:[inputString substringFromIndex:stringLength-3]]) {
//                        string = [inputString substringToIndex:stringLength - 3];
//                    }
//                } else {
//                    string = [inputString substringToIndex:stringLength - 1];
//                }
//            }
//            input.text = string;
//        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    int page = scrollView.contentOffset.x / [[UIScreen mainScreen]bounds].size.width;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
}

- (IBAction)changePage:(id)sender
{
    int page = (int)pageControl.currentPage;//获取当前pagecontroll的值
    [scrollView setContentOffset:CGPointMake([[UIScreen mainScreen]bounds].size.width * page, 0)];
}


@end
