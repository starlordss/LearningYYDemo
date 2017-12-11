//
//  AppDelegate.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/5.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#pragma mark - SZNavBar
@interface SZNavBar : UINavigationBar
@end


@implementation SZNavBar {
    CGSize _preSize;
}
// 会计算出最优的 size 但是不会改变 自己的 size
- (CGSize)sizeThatFits:(CGSize)size
{
    size = [super sizeThatFits:size];
    if ([UIApplication sharedApplication].statusBarHidden) { // 隐藏状态栏
        size.height = 64;
    }
    return size;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    if (!CGSizeEqualToSize(self.bounds.size, _preSize)) { // 和上一次的size不相等
//        _preSize = self.bounds.size;
//        [self.layer removeAllAnimations]; // 移除动画
//        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeAllAnimations)];
//    }
//}

@end


#pragma mark - SZNavigationController

@interface SZNavigationController : UINavigationController
@end

@implementation SZNavigationController

// 是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end


#pragma mark - AppDelegate
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController *vc = [ViewController new];
    SZNavigationController *nav = [[SZNavigationController alloc] initWithNavigationBarClass:[SZNavBar class] toolbarClass:[UIToolbar class]];
    if ([nav respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        nav.automaticallyAdjustsScrollViewInsets = NO;
    }
    [nav pushViewController:vc animated:NO];
    self.rootViewController = nav;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
