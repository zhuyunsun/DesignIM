//
//  AppDelegate.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/23.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController =  na;
    return YES;
}
@end
/*
 NO plan,NO rule,maybe NO future.
 */
