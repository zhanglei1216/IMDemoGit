//
//  AppDelegate.m
//  IMDemo
//
//  Created by foreveross－bj on 14-12-1.
//  Copyright (c) 2014年 foreveross－bj. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GroupListTableViewController.h"
#import "ChatViewController.h"

@interface AppDelegate ()
{
    LoginViewController *loginVC;
}

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *host;
@property (nonatomic) int port;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.socket = [[SocketStream alloc] initWithDelegate:self];
    
    loginVC = [[LoginViewController alloc] init];
    
    GroupListTableViewController *groupListVC = [[GroupListTableViewController alloc] init];
    
     UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:groupListVC];
    
    __weak AppDelegate *appDelegate = self;
    loginVC.completion = ^(NSDictionary *result){
        dispatch_sync(dispatch_get_main_queue(), ^{
            appDelegate.window.rootViewController = navigation;
        });
        appDelegate.host = result[@"host"];
        appDelegate.token = result[@"sessionToken"];
        appDelegate.port = [result[@"port"] intValue];
        [[NSUserDefaults standardUserDefaults] setObject:result[@"host"]forKey:@"host"];
        [[NSUserDefaults standardUserDefaults] setObject:result[@"port"]  forKey:@"port"];
        [[NSUserDefaults standardUserDefaults] setObject:result[@"sessionToken"] forKey:@"token"];
        [appDelegate.socket connectWithIp:appDelegate.host port:appDelegate.port];
    };
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
    if (kUserName) {
        self.window.rootViewController = navigation;
        [self.socket connectWithIp:kHost port:kPort];
    }else{
        self.window.rootViewController = loginVC;
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)connectWillBegin{
    NSLog(@"connectWillBegin");
}
- (void)connectDidSuccess{
    TokenRequestMessage *tokenMessage = [[TokenRequestMessage alloc] initWithId:[[NSUUID UUID] UUIDString] token:kToken];
    [_socket authorizeWithMessage:tokenMessage];
}
- (void)connectDidFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"connectDidFail %@", reason);
}
- (void)authorizeWillBegin{
    NSLog(@"authorizeWillBegin");
}
- (void)authorizeDidSuccess{
    NSLog(@"authorizeDidSuccess");
}
- (void)authorizeTimeout{
    NSLog(@"authorizeTimeout");
}
- (void)authorizeDidFailWithType:(int)type reason:(NSString *)reason{
    NSLog(@"authorizeDidFailWithType %d, %@", type, reason);
}
- (void)messageDidSendSuccess:(Message *)message{
    NSLog(@"messageDidSendSuccess");
}
- (void)messageDidSendFail:(Message *)message{
    NSLog(@"messageDidSendFail");
}
- (void)messageDidReceived:(Message *)message{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceivedMessage" object:message];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
