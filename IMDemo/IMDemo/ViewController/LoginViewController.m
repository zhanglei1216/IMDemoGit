//
//  LoginViewController.m
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "LoginViewController.h"
#import "Tools.h"
#import "Keychain.h"
#import "MessageHeader.h"


@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) DoRegister *doRegister;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [_loginLabel addGestureRecognizer:tapGesture];
    self.doRegister = [[DoRegister alloc] initWithDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardWillHide:)];
    [self.view addGestureRecognizer:viewTapGesture];
}
- (void)keyBoardWillShow:(NSNotification *)notification{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        if (keyboardBounds.origin.y < _loginLabel.frame.origin.y + 30) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y - (_loginLabel.frame.origin.y - keyboardBounds.origin.y + 60));
            } completion:nil];
        }else{
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                 self.view.center = self.view.window.center;
            } completion:nil];
        }
    }
    
}
- (void)keyBoardWillHide:(NSNotification *)notification{
    [_userTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.view.center = self.view.window.center;
    } completion:nil];
}
- (void)login{
    [self loginWithUserName:_userTextField.text password:_passwordTextField.text];
    [self keyBoardWillHide:nil];
}
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password{
    self.userName = userName;
    self.password = password;
    NSString *appId = nil;
    if ([Keychain readAppId]) {
        appId = [Keychain readAppId];
    }else{
        appId = [[NSUUID UUID] UUIDString];
        [Keychain saveAppId:appId];
    }
    NSString *UDID = nil;
    if ([Keychain readUDID]) {
        UDID = [Keychain readUDID];
    }else{
        UDID = [[NSUUID UUID] UUIDString];
        [Keychain saveUDID:UDID];
    }
    
    NSString *JSONParam = [NSString stringWithFormat:@"{ \"appId\": \"MYAPPID\", \"deviceId\": \"%@\", \"secret\":\"MYSECRET\",\"devicePlatform\":\"iOS\",\"ssl\":\"true\",\"username\": \"%@\", \"password\":\"%@\", \"encryption\": \"true\"}", UDID, userName, [Tools encode:password]];
    [_doRegister registerWithURL:[NSString stringWithFormat:@"%@%@", kUrl, @"/api/client/register"] jsonParam:JSONParam];
}

- (void)registerWillBegin{
    NSLog(@"registerWillBegin");
}
- (void)registerDidSuccessWithResult:(NSString *)result{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:@"password"];
    if (_completion) {
        _completion(dic);
    }
}
- (void)registerDidFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"%d %@", type, reason);
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
