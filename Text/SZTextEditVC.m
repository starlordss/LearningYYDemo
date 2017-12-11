//
//  SZTextEditVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextEditVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
#import "SZTextHelper.h"

@interface SZTextEditVC ()<YYTextViewDelegate, YYTextKeyboardObserver>
@property (nonatomic, assign) YYTextView *textView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UISwitch *verticalSwitch;
@property (nonatomic, strong) UISwitch *debugSwitch;
@property (nonatomic, strong) UISwitch *exclusionSwitch;
@end

@implementation SZTextEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self initImageView];
    
    // 添加特殊效果
    UIVisualEffectView *toolBar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    toolBar.size = CGSizeMake(kScreenWidth, 40);
    toolBar.top = kiOS7Later ? kStatusAndNavHeight : 0;
    [self.view addSubview:toolBar];
        
    
    // 富文本
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the season of light, it was the season of darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us. We were all going direct to heaven, we were all going direct the other way.\n\n这是最好的时代，这是最坏的时代；这是智慧的时代，这是愚蠢的时代；这是信仰的时期，这是怀疑的时期；这是光明的季节，这是黑暗的季节；这是希望之春，这是失望之冬；人们面前有着各样事物，人们面前一无所有；人们正在直登天堂，人们正在直下地狱。"];
    text.font = [UIFont fontWithName:@"Times New Roman" size:20];
    // 行间距
    text.lineSpacing = 4;
    // 段落缩进
    text.firstLineHeadIndent = 20;
    
    // label
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.size = self.view.size;
    // 文本容器间距
    textView.textContainerInset =UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    } else {
        textView.height -= 64;
    }
    // 内容间距
    textView.contentInset = UIEdgeInsetsMake(toolBar.bottom, 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    textView.selectedRange = NSMakeRange(text.length, 0);
    self.textView = textView;
    [self.view insertSubview:textView belowSubview:toolBar];
    
    //弹出键盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [textView becomeFirstResponder];
    });
    
    // ToolBar上标签：Vertical
    UILabel *lbl;
    lbl = [UILabel new];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"Vertical:";
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.size = CGSizeMake([lbl.text widthForFont:lbl.font], toolBar.height);
    lbl.left = 10;
    [toolBar.contentView addSubview:lbl];
    
    // 切换垂直显示
    _verticalSwitch = [UISwitch new];
    [_verticalSwitch sizeToFit];
    _verticalSwitch.centerY = toolBar.height * 0.5;
    _verticalSwitch.left = lbl.right - 8;
    _verticalSwitch.layer.transformScale = 0.5;
    __weak typeof(self) _self = self;
    [_verticalSwitch addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *switcher) {
        [_self.textView endEditing:YES];
        if (switcher.isOn) { // 开
            [_self setExclusionPathEnabled:NO];
            _self.exclusionSwitch.on = NO;
        }
        _self.exclusionSwitch.enabled = !switcher.isOn;
        _self.textView.verticalForm = switcher.isOn;
    }];
    [toolBar.contentView addSubview:_verticalSwitch];
    
    // ToolBar上标签：Debug
    lbl = [UILabel new];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.text = @"Debug:";
    lbl.size = CGSizeMake([lbl.text widthForFont:lbl.font] + 2, toolBar.height);
    lbl.left = _verticalSwitch.right + 5;
    [toolBar.contentView addSubview:lbl];
    
    _debugSwitch = [UISwitch new];
    [_debugSwitch sizeToFit];
    _debugSwitch.on = [SZTextHelper isDebug];
    _debugSwitch.left = lbl.right - 5;
    _debugSwitch.centerY = toolBar.height * 0.5;
    _debugSwitch.layer.transformScale = 0.5;
    [_debugSwitch addBlockForControlEvents:UIControlEventTouchUpInside block:^(UISwitch *switcher) {
        [SZTextHelper setDebug:switcher.isOn];
    }];
    [toolBar.contentView addSubview:_debugSwitch];
    
    // ToolBar上标签：Exclusion
    lbl = [UILabel new];
    lbl.text = @"Exclusion:";
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.size = CGSizeMake([lbl.text widthForFont:lbl.font], toolBar.height);
    lbl.left = _debugSwitch.right + 5;;
    [toolBar.contentView addSubview:lbl];
    
    _exclusionSwitch = [UISwitch new];
    [_exclusionSwitch sizeToFit];
    _exclusionSwitch.centerY = toolBar.height * 0.5;
    _exclusionSwitch.left = lbl.right - 5;
    _exclusionSwitch.layer.transformScale = 0.5;
    [_exclusionSwitch addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *switcher) {
        [_self setExclusionPathEnabled:switcher.isOn];
    }];
    [toolBar.contentView addSubview:_exclusionSwitch];
    
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    
}

- (void)setExclusionPathEnabled:(BOOL)enabled {
    if (enabled) {
        [self.textView addSubview:self.imageView];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.imageView.frame
                                                        cornerRadius:self.imageView.layer.cornerRadius];
        self.textView.exclusionPaths = @[path];
    } else {
        [self.imageView removeFromSuperview];
        self.textView.exclusionPaths = nil;
    }
}

- (void)initImageView {
    NSData *data = [NSData dataNamed:@"dribbble256_imageio.png"];
    UIImage *img = [[UIImage alloc] initWithData:data scale:2];
    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:img];
    imageView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = imageView.height * 0.5;
    imageView.clipsToBounds = YES;
    self.imageView = imageView;
    
    @weakify(self);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer *pan) {
        @strongify(self);
        if (!self) return;
        CGPoint p = [pan locationInView:self.textView];
        self.imageView.center = p;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.imageView.frame         cornerRadius:self.imageView.layer.cornerRadius];
        self.textView.exclusionPaths = @[path];
    }];
    [imageView addGestureRecognizer:pan];
}

- (void)dealloc
{
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}

#pragma mark - text view
- (void)textViewDidBeginEditing:(YYTextView *)textView
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - UI EVENT
- (void)edit:(UIBarButtonItem *)item {
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    } else {
        [_textView becomeFirstResponder];
    }
}
#pragma mark - keyboard
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition
{
    BOOL clipped = NO;
    if (_textView.isVerticalForm && transition.toVisible) {
        CGRect rect = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
        if (CGRectGetMaxY(rect) == self.view.height) {
            CGRect textFrame = self.view.bounds;
            textFrame.size.height -= rect.size.height;
            _textView.frame = textFrame;
            clipped = YES;
        }
    }

    if (!clipped) {
        _textView.frame = self.view.bounds;
    }
}
@end
