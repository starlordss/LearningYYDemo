//
//  SZTextTagVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextTagVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"

@interface SZTextTagVC ()<YYTextViewDelegate>
@property (nonatomic, assign) YYTextView *textView;
@end

@implementation SZTextTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSArray *tags = @[@"◉red", @"◉orange", @"◉yellow", @"◉green", @"◉blue", @"◉purple", @"◉gray"];
    NSArray *tagStrokeColors = @[
        UIColorHex(0xfa3f39),
        UIColorHex(0xf48f25),
        UIColorHex(0xf1c02c),
        UIColorHex(0x54bc2e),
        UIColorHex(0x29a9ee),
        UIColorHex(0xc171d8),
        UIColorHex(0x818e91)
    ];
    NSArray *tagFillColors = @[
        UIColorHex(0xfb6560),
        UIColorHex(0xf6a550),
        UIColorHex(0xf3cc56),
        UIColorHex(0x76c957),
        UIColorHex(0x53baf1),
        UIColorHex(0xcd8ddf),
        UIColorHex(0xa4a4a7)
    ];
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    for (int i = 0; i < tags.count; i++) {
        NSString *tag = tags[i];
        UIColor *tagStrokeColor = tagStrokeColors[i];
        UIColor *tagFillColor = tagFillColors[i];
        
        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tag];
        [tagText insertString:@"   " atIndex:0];
        [tagText appendString:@"   "];
        tagText.font = font;
        tagText.color = [UIColor whiteColor];
        [tagText setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagText.rangeOfAll];

        YYTextBorder *border = [YYTextBorder new];
        border.strokeWidth = 1.5;
        border.strokeColor = tagStrokeColor;
        border.fillColor = tagFillColor;
        border.cornerRadius = 100; // a huge value
        border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);

        [tagText setTextBackgroundBorder:border range:[tagText.string rangeOfString:tag]];
        [text appendAttributedString:tagText];
       
    }
    text.lineSpacing = 10;
    text.lineBreakMode = NSLineBreakByWordWrapping;
    
    [text appendString:@"\n"];
    [text appendAttributedString:text]; // 重复测试
    
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.size = self.view.size;
    textView.allowsPasteAttributedString = YES;
    textView.allowsCopyAttributedString = YES;
    textView.delegate = self;
    textView.textContainerInset = UIEdgeInsetsMake(10 + (kiOS7Later ? kStatusAndNavHeight : 0), 10, 10, 10);
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    } else {
        textView.height -= 64;
    }
    textView.scrollIndicatorInsets = textView.contentInset;
    textView.selectedRange = NSMakeRange(text.length, 0);
    [self.view addSubview:textView];
    self.textView = textView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [textView becomeFirstResponder];
    });
}
- (void)edit:(UIBarButtonItem *)item
{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    } else {
        [_textView becomeFirstResponder];
    }
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidBeginEditing:(YYTextView *)textView
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}
@end
