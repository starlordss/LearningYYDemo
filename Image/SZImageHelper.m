//
//  SZImageHelper.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/6.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZImageHelper.h"


@implementation SZImageHelper

+ (void)addTapControlToAnimatedImageView:(YYAnimatedImageView *)view
{
    if (!view) return;
    view.userInteractionEnabled = YES;
    __weak typeof(view) _view = view;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        // 正在动画 则：停止动画
        if (_view.isAnimating) [_view stopAnimating];
        // 否则：开始动画
        else [_view startAnimating];
        
        // 添加 bounce 动画
        UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
        [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
            _view.layer.transformScale = 0.97;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
                _view.layer.transformScale = 1;
            } completion:NULL];
        }];
    }];
    [view addGestureRecognizer:tap];
}

+ (void)addPanControlToAnimatedImageView:(YYAnimatedImageView *)view
{
    if (!view) return;
    view.userInteractionEnabled = YES;
    __weak typeof(view) _view = view;
    __block BOOL previousIsPlaying;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        UIImage<YYAnimatedImage> *image = (id)_view.image;
        // 图片没有遵守YYAnimatedImage协议
        if (![image conformsToProtocol:@protocol(YYAnimatedImage)]) return;
        UIPanGestureRecognizer *gesture = sender;
        // 接触view的位置
        CGPoint p = [gesture locationInView:gesture.view];
        // 进度
        CGFloat progerss = p.x / gesture.view.width;
        if (gesture.state == UIGestureRecognizerStateBegan) { // 开始
            previousIsPlaying = [_view isAnimating];
            [_view stopAnimating];
            _view.currentAnimatedImageIndex = image.animatedImageFrameCount * progerss;
        } else if (gesture.state == UIGestureRecognizerStateEnded ||
                   gesture.state == UIGestureRecognizerStateCancelled) { // 结束或者取消
            if (previousIsPlaying) [_view startAnimating];
        } else {
            _view.currentAnimatedImageIndex = image.animatedImageFrameCount * progerss;
        }
    }];
    [view addGestureRecognizer:pan];
}
@end
