

//
//  SZTextUndoRedoVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextUndoRedoVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
@interface SZTextUndoRedoVC ()<YYTextViewDelegate>
@property (nonatomic,weak) YYTextView *textView;
@end

@implementation SZTextUndoRedoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSString *text = @"你可以摇动设备来撤销和重做";
    
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.size = self.view.size;
    textView.font = [UIFont systemFontOfSize:17];
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.allowsUndoAndRedo = YES;
    textView.delegate = self;
    textView.maximumUndoLevel = 10;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later ? kStatusAndNavHeight : 0), 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
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

