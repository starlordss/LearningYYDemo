//
//  SZTextRubyVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextRubyVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
@interface SZTextRubyVC ()

@end

@implementation SZTextRubyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    if (kSystemVersion < 8) {
        [text appendString:@"Only support iOS8 Later"];
        text.font = [UIFont systemFontOfSize:30];
        
    } else {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"这是用汉语写的一段文字。"];
        one.font = [UIFont boldSystemFontOfSize:30];
        
        YYTextRubyAnnotation *ruby;
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"hàn yŭ";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"汉语"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"wén";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"文"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"zì";
        ruby.alignment = kCTRubyAlignmentCenter;
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"字"]];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
        
        
        
        one = [[NSMutableAttributedString alloc] initWithString:@"日本語で書いた作文です。"];
        one.font = [UIFont boldSystemFontOfSize:30];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"に";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"日"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"ほん";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"本"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"ご";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"語"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"か";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"書"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"さく";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"作"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"ぶん";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"文"]];
        
        [text appendAttributedString:one];
    }
    
    
    YYLabel *label = [YYLabel new];
    label.attributedText = text;
    label.width = self.view.width - 60;
    label.centerX = self.view.width / 2;
    label.height = self.view.height - (kiOS7Later ? kStatusAndNavHeight : 44) - 60;
    label.top = (kiOS7Later ? kStatusAndNavHeight : 0) + 30;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:label];
    
}


- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:30];
    return pad;
}
@end
