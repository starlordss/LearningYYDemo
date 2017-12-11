//
//  SZTextEmoticonVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextEmoticonVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"

@interface SZTextEmoticonVC ()<YYTextViewDelegate>
@property (nonatomic,weak) YYTextView *textView;
@end

@implementation SZTextEmoticonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSMutableDictionary *mapper = [NSMutableDictionary dictionary];
    mapper[@":smile:"] = [self imageWithName:@"002"];
    mapper[@":cool:"] = [self imageWithName:@"013"];
    mapper[@":biggrin:"] = [self imageWithName:@"047"];
    mapper[@":arrow:"] = [self imageWithName:@"007"];
    mapper[@":confused:"] = [self imageWithName:@"041"];
    mapper[@":cry:"] = [self imageWithName:@"010"];
    mapper[@":wink:"] = [self imageWithName:@"085"];
    
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    
    YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
    mod.fixedLineHeight =22;
    
    YYTextView *textView = [YYTextView new];
    textView.text = @"Hahahah:smile:, it\'s emoticons::cool::arrow::cry::wink:\n\nYou can input \":\" + \"smile\" + \":\" to display smile emoticon, or you can copy and paste these emoticons.\n\nSee \'YYTextEmoticonExample.m\' for example.";
    textView.font = [UIFont systemFontOfSize:17];
    textView.textParser = parser;
    textView.size = self.view.size;
    textView.linePositionModifier = mod;
    textView.textContainerInset =  UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    // 文本的内容间距
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later ? kStatusAndNavHeight : 0), 0, 0, 0);
    // 滚动指示器间距
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
    self.textView = textView;
    [self.textView becomeFirstResponder];
    
}

- (UIImage *)imageWithName:(NSString *)name {
    // 获取emoticon bundle
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    // 获取文件路径
    NSString *path = [bundle pathForScaledResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    // 预先加载所有帧将会降低CPU成本
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}

- (void)edit:(UIBarButtonItem *)item {
    [self.view endEditing:YES];
}
#pragma mark - text view delegate
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
