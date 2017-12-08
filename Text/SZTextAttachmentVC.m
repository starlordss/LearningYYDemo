//
//  SZTextAttachmentVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextAttachmentVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
#import "SZTextHelper.h"
#import "SZImageHelper.h"

@interface SZTextAttachmentVC ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) YYLabel *label;
@end

@implementation SZTextAttachmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SZTextHelper addDebugOptionToViewController:self];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    {
        NSString *title = @"展示图片附件";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        
        UIImage *img = [UIImage imageNamed:@"dribbble64_imageio"];
        img = [UIImage imageWithCGImage:img.CGImage scale:2 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:img                                              contentMode:UIViewContentModeCenter attachmentSize:img.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    {
        NSString *title = @"这是一个UIView附件";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        
        UISwitch *switcher = [UISwitch new];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:switcher contentMode:UIViewContentModeCenter attachmentSize:switcher.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    {
        NSString *title = @"这是一个动图附件";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        
        NSArray *names = @[@"001", @"022", @"019",@"056",@"085"];
        for (NSString *name in names) {
            NSString *path = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            YYImage *img = [YYImage imageWithData:data scale:2];
            img.preloadAllAnimatedImageFrames = YES;
            YYAnimatedImageView *imgView = [[YYAnimatedImageView alloc] initWithImage:img];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imgView contentMode:UIViewContentModeCenter attachmentSize:img.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
            
        }
        
        YYImage *img = [YYImage imageNamed:@"wall-e.webp"];
        img.preloadAllAnimatedImageFrames = YES;
        
        YYAnimatedImageView *imgView = [[YYAnimatedImageView alloc] initWithImage:img];
        imgView.autoPlayAnimatedImage = NO;
        [imgView startAnimating];
        
        [SZImageHelper addTapControlToAnimatedImageView:imgView];
        [SZImageHelper addPanControlToAnimatedImageView:imgView];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imgView contentMode:UIViewContentModeCenter attachmentSize:imgView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
    }
    
    text.font = font;
    _label = [YYLabel new];
    _label.userInteractionEnabled = YES;
    _label.attributedText = text;
    _label.size = CGSizeMake(333, 333);
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _label.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 - (kiOS7Later ? kStatusAndNavHeight : 32));
    _label.numberOfLines = 0;
    _label.layer.borderWidth = CGFloatFromPixel(1);
    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
    [self.view addSubview:_label];
    [self addSeeMoreButton];
    
    __weak typeof(_label) weakLabel = _label;
    UIView *dot = [self dotView];
    dot.center = CGPointMake(_label.width, _label.height);
    dot.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [_label addSubview:dot];
    
    YYGestureRecognizer *gesture = [YYGestureRecognizer new];
    gesture.action = ^(YYGestureRecognizer * _Nonnull gesture, YYGestureRecognizerState state) {
        if (state != YYGestureRecognizerStateMoved) return;
        CGFloat width = gesture.currentPoint.x;
        CGFloat height = gesture.currentPoint.y;
        weakLabel.width = width < 30 ? 30 : width;
        weakLabel.height = height < 30 ? 30 : height;
    };
    gesture.delegate = self;
    [_label addGestureRecognizer:gesture];
    
}
- (void)addSeeMoreButton {
    __weak typeof(self) _self = self;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...更多"];
    
    YYTextHighlight *h = [YYTextHighlight new];
    [h setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    h.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        YYLabel *lbl = _self.label;
        [lbl sizeToFit];
    };
    
    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"更多"]];
    [text setTextHighlight:h range:[text.string rangeOfString:@"更多"]];
    text.font = _label.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSMutableAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    _label.truncationToken = truncationToken;
    
}

- (UIView *)dotView {
    UIView *v = [UIView new];
    v.size = CGSizeMake(50, 50);
    
    UIView *dot = [UIView new];
    dot.size = CGSizeMake(10, 10);
    dot.backgroundColor = [UIColor purpleColor];
    dot.clipsToBounds = YES;
    dot.layer.cornerRadius = dot.width * 0.5;
    dot.center = CGPointMake(v.width * 0.5, v.height * 0.5);
    [v addSubview:dot];
    return v;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:_label];
    if (p.x < _label.width - 20) return NO;
    if (p.y < _label.height - 20) return NO;
    return YES;
}
@end
