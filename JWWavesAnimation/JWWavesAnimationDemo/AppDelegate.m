//
//  AppDelegate.m
//  JWWavesAnimationDemo
//
//  Created by jasonwang on 2017/5/19.
//  Copyright © 2017年 JasonWang. All rights reserved.
//

#import "AppDelegate.h"
#import "JWWavesAnimationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    JWWavesAnimationViewController *VC = [JWWavesAnimationViewController new];
    [self.window setRootViewController:VC];

    //  第一步 设置 mask 蒙版 和动画
    CALayer *maskLayer = [CALayer layer];
    [maskLayer setFrame:CGRectMake(0, 0, 200, 120)];
    maskLayer.contents = (id)[UIImage imageNamed:@"123456"].CGImage;
    VC.view.layer.mask = maskLayer;
    maskLayer.position = VC.view.center;
    CAKeyframeAnimation *transAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    transAnimation.duration = 1;
    transAnimation.beginTime = CACurrentMediaTime() + 1;
    CGRect firstBounds = VC.view.layer.mask.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 400, 240);
    CGRect finalBounds = CGRectMake(0, 0, 20000, 20000);
    
    [transAnimation setValues:@[[NSValue valueWithCGRect:firstBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]]];
    
    transAnimation.keyTimes = @[@0,@0.5,@1];
    transAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    transAnimation.removedOnCompletion = NO;
    transAnimation.fillMode = kCAFillModeForwards;
    
    [VC.view.layer.mask addAnimation:transAnimation forKey:@"maskAnimation"];
    // 第二步 设置 NavigationController的view的形变动画
    CAKeyframeAnimation *viewTransAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    viewTransAnimation.duration = 0.6;
    viewTransAnimation.keyTimes = @[@0,@0.5,@1];
    viewTransAnimation.beginTime = CACurrentMediaTime() + 1.1;
    [viewTransAnimation setValues:@[[NSValue valueWithCATransform3D:CATransform3DIdentity],[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)],[NSValue valueWithCATransform3D:CATransform3DIdentity]]];
    
    [VC.view.layer addAnimation:viewTransAnimation forKey:@"viewAnimation"];
    VC.view.layer.transform = CATransform3DIdentity;
    //  第三步 添加白色遮罩
    UIView *whiteView = [[UIView alloc] initWithFrame:VC.view.bounds];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [VC.view addSubview:whiteView];
    
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        whiteView.alpha = 0;
    } completion:^(BOOL finished) {
        [whiteView removeFromSuperview];
        VC.view.layer.mask = nil;
    }];

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
