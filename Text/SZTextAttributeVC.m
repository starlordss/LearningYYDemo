//
//  SZTextAttributeVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextAttributeVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
#import "SZTextHelper.h"

@interface SZTextAttributeVC ()

@end

@implementation SZTextAttributeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SZTextHelper addDebugOptionToViewController:self];
    __weak typeof(self) _self = self;
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    {
        // 可变富文本
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
        // 富文本字体
        one.font = [UIFont boldSystemFontOfSize:30];
        // 富文本颜色
        one.color = [UIColor whiteColor];
        // 阴影
        YYTextShadow *shadow = [YYTextShadow new];
        // 阴影偏移量
        shadow.offset = CGSizeMake(0, 4);
//        shadow.radius = 5;
        shadow.color = [UIColor darkGrayColor];
        one.textShadow = shadow;
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
        aStr.font = [UIFont boldSystemFontOfSize:35];
        aStr.color = [UIColor whiteColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius  = 1;
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        aStr.textInnerShadow = shadow;
        [text appendAttributedString:aStr];
        [text appendAttributedString:self.padding];
        
    }
    {
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:@"Multiple Shadows"];
        aStr.font = [UIFont boldSystemFontOfSize:30];
        aStr.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
        // 阴影
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow.offset = CGSizeMake(0, -1);
        shadow.radius = 1.5;
        // 子阴影
        YYTextShadow *subShadow = [YYTextShadow new];
        subShadow.color = [UIColor colorWithWhite:1 alpha:0.99];
        subShadow.offset = CGSizeMake(0, 1);
        subShadow.radius = 1.5;
        shadow.subShadow = subShadow;
        aStr.textShadow = shadow;
        // 内阴影
        YYTextShadow *innerShadow = [YYTextShadow new];
        innerShadow.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow.offset = CGSizeMake(0, 1);
        innerShadow.radius = 1;
        aStr.textInnerShadow = innerShadow;
        
        [text appendAttributedString:aStr];
        [text appendAttributedString:self.padding];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
        one.font = [UIFont boldSystemFontOfSize:30];
        CGSize size = CGSizeMake(20, 20);
        // 绘制 20 * 20的图片
        UIImage *bgImage = [UIImage imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
            UIColor *c0 = [UIColor whiteColor];
            UIColor *c1 = [UIColor purpleColor];
            [c0 setFill];
            // 绘制矩形
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
            [c1 setStroke];
            CGContextSetLineWidth(context, 2);
            // 绘制线条
            for (int i = 0; i < size.width * 2; i += 4) {
                CGContextMoveToPoint(context, i, -2);
                CGContextAddLineToPoint(context, i - size.height, size.height + 2);
            }
            CGContextStrokePath(context);
        }];
        
        one.color = [UIColor colorWithPatternImage:bgImage];
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithCyan:0.9 magenta:0.5 yellow:0.4 black:0.3 alpha:1.0];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        border.strokeWidth = 3;
        border.cornerRadius = 5;
        border.lineStyle = YYTextLineStylePatternCircleDot;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        one.textBorder = border;
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.underlineStyle = NSUnderlineStyleSingle;
        
        // 方式一
//        YYTextBorder *border = [YYTextBorder new];
//        border.cornerRadius = 3;
//        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
//        border.fillColor = [UIColor colorWithWhite:0.000 alpha:0.220];
//
//        YYTextHighlight *highlight = [YYTextHighlight new];
//        [highlight setBorder:border];
//        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//        };
//        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        // 方式二
        [one setTextHighlightRange:one.rangeOfAll
                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                             [_self showMessage:[NSString stringWithFormat:@"Top:%@",[text.string substringWithRange:range]]];
                         }];
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];

    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor redColor];
        // 边框
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 50;
        border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        border.strokeWidth = 1;
        border.strokeColor = one.color;
        border.lineStyle = YYTextLineStyleDouble;
        one.textBackgroundBorder = border;
        // 高亮边框
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = one.color;
        highlightBorder.fillColor = one.color;
        // 文本高亮
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor whiteColor];
        // 阴影
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        // 阴影
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        // 阴影
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        // 阴影
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        // 文本高亮
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
    }
    
    // 设置label
    YYLabel *lbl = [YYLabel new];
    lbl.attributedText = text;
    lbl.width = self.view.width;
    lbl.height = self.view.height - (kiOS7Later ? kStatusAndNavHeight : 44);
    lbl.top = kiOS7Later ? kStatusAndNavHeight : 0;
    lbl.numberOfLines = 0;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    lbl.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:lbl];
}
- (void)showMessage:(NSString *)msg
{
    CGFloat padding = 10;
    YYLabel *lbl = [YYLabel new];
    lbl.text = msg;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.width = self.view.width;
    lbl.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    lbl.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    lbl.height = [msg heightForFont:lbl.font width:lbl.width] + 2 * padding;
    lbl.bottom = kiOS7Later ? kStatusAndNavHeight : 0;
    
    [self.view addSubview:lbl];
    [UIView animateWithDuration:0.3 animations:^{
        lbl.top = (kiOS7Later ? kStatusAndNavHeight : 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            lbl.bottom = (kiOS7Later ? kStatusAndNavHeight : 0);
        } completion:^(BOOL finished) {
            [lbl removeFromSuperview];
        }];
    }];
}

- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}
@end
