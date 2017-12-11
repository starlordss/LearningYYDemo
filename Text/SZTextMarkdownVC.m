//
//  SZTextMarkdownVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextMarkdownVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"

@interface SZTextMarkdownVC ()<YYTextViewDelegate>

@end

@implementation SZTextMarkdownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
     NSString *text = @"#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n";
    
    YYTextSimpleMarkdownParser *parser = [[YYTextSimpleMarkdownParser alloc] init];
    [parser setColorWithDarkTheme];
    
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:14];
    textView.textParser = parser;
    textView.size = self.view.size;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor colorWithWhite:0.134 alpha:1.000];
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later ? kStatusAndNavHeight : 0), 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    textView.selectedRange = NSMakeRange(text.length, 0);
    
}
- (void)edit:(UIBarButtonItem *)item {
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(YYTextView *)textView
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)textViewDidEndEditing:(YYTextView *)textView
{
    self.navigationItem.rightBarButtonItem = nil;
}
@end
