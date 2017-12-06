//
//  SZImageHelper.h
//  LearningYYDemo
//
//  Created by starz on 2017/12/6.
//  Copyright © 2017年 starz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>
@interface SZImageHelper : NSObject

/// 点击播放暂停
+ (void)addTapControlToAnimatedImageView:(YYAnimatedImageView *)view;
/// 拖动图片向前/向后
+ (void)addPanControlToAnimatedImageView:(YYAnimatedImageView *)view;

@end
