//
//  CreatGroupViewController.m
//  IMDemo
//
//  Created by foreveross－bj on 14/12/11.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "CreatGroupViewController.h"
#import "GroupModelHandle.h"

@interface CreatGroupViewController ()

@property (strong, nonatomic) IBOutlet UITextField *firstTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdTextField;
@property (strong, nonatomic) GroupModelHandle *groupModelHandle;

@end

@implementation CreatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.groupModelHandle = [[GroupModelHandle alloc] init];
}
- (IBAction)CreateGroup:(id)sender {
    [_groupModelHandle createGroupWithIds:@[_firstTextField.text, _secondTextField.text, _thirdTextField.text] completion:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if (_createCompletion) {
            _createCompletion();
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
