//
//  SZWebImageVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/7.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZWebImageVC.h"
#import <YYKit.h>

#define kCellHeight ceil((kScreenWidth) * 3.0 / 4.0)
#define klineHeight  4

@interface SZWebImageCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView     *webImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) CAShapeLayer            *progressLayer;
@property (nonatomic, strong) UILabel                 *label;
@end

@implementation SZWebImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.size = CGSizeMake(kScreenWidth, kCellHeight);
    self.backgroundColor = [UIColor clearColor];
    self.contentView.size = self.size;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.webImageView];
    [self.contentView addSubview:self.label];
    __weak typeof(self) _self = self;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        [_self setImageURL:_self.webImageView.imageURL];
    }];
    [_label addGestureRecognizer:g];
    return self;
}

- (YYAnimatedImageView *)webImageView{
    if (!_webImageView) {
        _webImageView = [YYAnimatedImageView new];
        _webImageView.size = self.size;
        _webImageView.clipsToBounds = YES;
        _webImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_webImageView.layer addSublayer:self.progressLayer];
    }
    return _webImageView;
}
- (UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        _indicator.hidden = YES;
    }
    return _indicator;
}
- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.size = CGSizeMake(_webImageView.width, klineHeight);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, _progressLayer.height * 0.5)];
        [path addLineToPoint:CGPointMake(_webImageView.width, _progressLayer.height * 0.5)];
        _progressLayer.lineWidth = klineHeight;
        _progressLayer.path = path.CGPath;
        _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
        _progressLayer.lineCap = kCALineCapButt;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        
    }
    return _progressLayer;
}
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.size = self.size;
        _label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        _label.hidden = YES;
        _label.userInteractionEnabled = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"加载失败,点击刷新";
        
    }
    return _label;
}

- (void)setImageURL:(NSURL *)url {
    self.label.hidden = YES;
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    __weak typeof(self) _self = self;
    // 开启事务
    [CATransaction begin];
    // 设置禁用操作
    [CATransaction setDisableActions:YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    // 提交事务
    [CATransaction commit];
    
    [_webImageView setImageWithURL:url
                       placeholder:nil
                           options:YYWebImageOptionProgressiveBlur |
                               YYWebImageOptionShowNetworkActivity |
                         YYWebImageOptionSetImageWithFadeAnimation
                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                              if (expectedSize > 0 && receivedSize > 0) {
                                  CGFloat progress = (CGFloat)receivedSize / expectedSize;
                                  progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                                  if (_self.progressLayer.hidden) _self.progressLayer.hidden = NO;
                                  _self.progressLayer.strokeEnd = progress;
                              }
                       } transform:nil
                        completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                            if (stage == YYWebImageStageFinished) {
                                _self.progressLayer.hidden = YES;
                                [_self.indicator stopAnimating];
                                _self.indicator.hidden = YES;
                                if (!image) _self.label.hidden = NO;
                            }
                       }];
}
@end



@implementation SZWebImageVC {
    NSArray *_imgLinks;
}
static  NSString *rid = @"CELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    self.view.backgroundColor = [UIColor colorWithWhite:0.217 alpha:1.000];
    [self.tableView registerClass:[SZWebImageCell class] forCellReuseIdentifier:rid];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSArray *links = @[
                       /*
                        You can add your image url here.
                        */
                       
                       // progressive jpeg
                       @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                       
                       // animated gif: http://cinemagraphs.com/
                       @"http://i.imgur.com/uoBwCLj.gif",
                       @"http://i.imgur.com/8KHKhxI.gif",
                       @"http://i.imgur.com/WXJaqof.gif",
                       
                       // animated gif: https://dribbble.com/markpear
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                       
                       // animaged gif: https://dribbble.com/jonadinges
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                       
                       // jpg: https://dribbble.com/snootyfox
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       @"http://littlesvr.ca/apng/images/Contact.webp",
                       ];
    
    _imgLinks = links;
    [self.tableView reloadData];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (kiOS7Later) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (kiOS7Later) {
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.tintColor = nil;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)refresh {
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{}];
    [self.tableView performSelector:@selector(reloadData) afterDelay:0.1];
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imgLinks.count * 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZWebImageCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    [cell setImageURL:[NSURL URLWithString:_imgLinks[indexPath.row % _imgLinks.count]]];
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (SZWebImageCell *cell in self.tableView.visibleCells) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight * 0.5;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        if (kiOS8Later) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:NULL];
        } else {
            cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
    
}
@end
