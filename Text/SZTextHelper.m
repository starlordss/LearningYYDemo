//
//  SZTextHelper.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextHelper.h"
#import <YYKit.h>

static BOOL DebugEnabled = NO;

@implementation SZTextHelper

+ (void)addDebugOptionToViewController:(UIViewController *)vc {
    UISwitch *switcher = [UISwitch new];
    switcher.layer.transformScale = 0.8;
    [switcher setOn:DebugEnabled];
    [switcher addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *sender) {
        [self setDebug:sender.isOn];
    }];
    
    UIView *v = [UIView new];
    v.size = CGSizeMake(40, 44);
    [v addSubview:switcher];
    switcher.centerX = v.width * 0.5;
    switcher.centerY = v.height * 0.5;
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:v];
    
}

+ (void)setDebug:(BOOL)debug {
    YYTextDebugOption *debugOptions = [YYTextDebugOption new];
    if (debug) {
        debugOptions.baselineColor = [UIColor redColor];
        debugOptions.CTFrameBorderColor = [UIColor redColor];
        debugOptions.CTLineFillColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:0.180];
        debugOptions.CGGlyphBorderColor = [UIColor colorWithRed:1.000 green:0.524 blue:0.000 alpha:0.200];
    } else {
        [debugOptions clear];
    }
    
    [YYTextDebugOption setSharedDebugOption:debugOptions];
    DebugEnabled = debug;
}
+ (BOOL)isDebug {
    return DebugEnabled;
}
@end
