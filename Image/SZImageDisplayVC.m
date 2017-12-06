
//
//  SZImageDisplayVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/6.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZImageDisplayVC.h"
#import <YYKit.h>
#import "SZImageHelper.h"

@interface SZImageDisplayVC ()<UIGestureRecognizerDelegate>

@end

@implementation SZImageDisplayVC {
    UIScrollView *_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
    // 滚动容器
    _scrollView = [UIScrollView new];
    _scrollView.frame = self.view.bounds;
    if (kiOS7Later) {
        _scrollView.height -= 44;
    }
    [self.view addSubview:_scrollView];
    // 顶部标题
    UILabel *lbl = [UILabel new];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.size = CGSizeMake(kScreenWidth, 60);
    lbl.top = 20;
    lbl.text = @"点击图像暂停/播放";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    [_scrollView addSubview:lbl];
    // 添加图片
    [self addImageWithName:@"niconiconi" text:@"GIF"];
    [self addImageWithName:@"wall-e" text:@"WEBP"];
    [self addImageWithName:@"pia" text:@"PNG"];
    [self addFrameImageWithText:@"Frame Image"];
    [self addSpriteSheetImageWithText:@"Sprite Sheet" name:@"fav02l-sheet@2x.png"];
    [self addSpriteSheetImageWithText:@"Sprite Sheet" name:@"fav02c-sheet@2x.png"];
    [self addImageWithName:@"niconiconi" text:@"GIF"];
}

#pragma mark - 添加图片
// 添加精灵表单（一张巨大的图片,里面放着许许多多的图片）
- (void)addSpriteSheetImageWithText:(NSString *)text name:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"ResourceTwitter.bundle/%@",name]];
    UIImage *sheet = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path] scale:2.f];
    // 图片容器
    NSMutableArray *contentRects = [NSMutableArray array];
    // 间隔容器
    NSMutableArray *durations = [NSMutableArray array];
    // 8 * 12 | Sprite的size
    CGSize size = CGSizeMake(sheet.size.width / 8, sheet.size.height / 12);
    for (int j = 0; j < 12; j ++) { // 12行
        for (int i = 0; i < 8; i++) { // 8列
            CGRect rect;
            rect.size = size;
            rect.origin.x = sheet.size.width / 8 * i;
            rect.origin.y = sheet.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1/60)];
        }
    }
    YYSpriteSheetImage *sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:sheet
                                                                         contentRects:contentRects
                                                                       frameDurations:durations
                                                                            loopCount:0];
    [self addImage:sprite size:size text:text];
    
}

// 使用文本添加帧图像
- (void)addFrameImageWithText:(NSString *)text {
    // 基地址
    NSString *basePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"EmoticonWeibo.bundle/com.sina.default"];
    // 路径容器
    NSMutableArray *paths = [NSMutableArray array];
    // 添加容器
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_aini@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_baibai@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chanzui@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chijing@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_dahaqi@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_dahaqi@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haha@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haixiu@3x.png"]];
    
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths oneFrameDuration:0.25 loopCount:0];
    [self addImage:image size:CGSizeZero text:text];
}

// 普通格式的动图
- (void)addImageWithName:(NSString *)name text:(NSString *)text {
    // 支持GIF ... 图片格式
    YYImage *img = [YYImage imageNamed:name];
    [self addImage:img size:CGSizeZero text:text];
}
- (void)addImage:(UIImage *)image size:(CGSize)size text:(NSString *)text
{
    // 动画图片视图：可以图片继续动画
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    // 图片不为空 赋值为原始图片大小
    if (size.width > 0 && size.height > 0) imageView.size = size;
    imageView.centerX = self.view.width * 0.5;
    imageView.top = [_scrollView.subviews lastObject].bottom + 30;
    [_scrollView addSubview:imageView];
    // 手势： 点击暂停/播放
    [SZImageHelper addTapControlToAnimatedImageView:imageView];
    // 手势: 拖动
    [SZImageHelper addPanControlToAnimatedImageView:imageView];
    // 设置手势代理 解决手势冲突
    for (UIGestureRecognizer *g in imageView.gestureRecognizers) {
        g.delegate = self;
    }
    // 图片文本描述
    UILabel *imageLbl = [UILabel new];
    imageLbl.frame = CGRectMake(0, 0, self.view.width, 20);
    imageLbl.top = imageView.bottom + 10;
    imageLbl.text = text;
    imageLbl.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:imageLbl];
    // 设置滚动范围
    _scrollView.contentSize = CGSizeMake(self.view.width, imageLbl.bottom + 20);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
