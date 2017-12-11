//
//  SZTextCopyPasteVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextCopyPasteVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"

@interface SZTextCopyPasteVC ()<YYTextViewDelegate>
@property (nonatomic,weak) YYTextView *textView;
@end

@implementation SZTextCopyPasteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSString *text = @"你可以从浏览器或相册复制图像，然后粘贴到这里。它支持GIF动画和APNG。\n\n还可以从其他YYTextView复制带属性的字符串。";
    
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:17];
    textView.size = self.view.size;
    textView.delegate = self;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 允许复制图片
    textView.allowsPasteImage = YES;
    // 复制文本属性
    textView.allowsPasteAttributedString = YES;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later ? kStatusAndNavHeight : 0), 0, 0, 0);
    
    [self.view addSubview:textView];
    self.textView = textView;
    textView.selectedRange = NSMakeRange(text.length, 0);
    [textView becomeFirstResponder];
    
}
- (void)edit:(UIBarButtonItem *)item {
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    } else {
        [_textView becomeFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(YYTextView *)textView {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

@end
