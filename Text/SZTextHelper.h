//
//  SZTextHelper.h
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTextHelper : NSObject
+ (void)addDebugOptionToViewController:(UIViewController *)vc;
+ (BOOL)isDebug;
+ (void)setDebug:(BOOL)debug;
@end
