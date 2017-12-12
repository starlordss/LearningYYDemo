
//
//  SZTextAsyncVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextAsyncVC.h"
#import <YYKit.h>
#import "MacroDefinition.h"
#import "SZFPSLabel.h"

#define kCellHeight  50



@interface SZTextAsynCell : UITableViewCell
// 是否异步
@property (nonatomic, assign, getter=isAsync) BOOL async;
// 设置异步文本
- (void)setAsyncText:(NSAttributedString *)text;
@end

@implementation SZTextAsynCell {
    UILabel *_uiLbl;
    YYLabel *_yyLbl;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _uiLbl = [UILabel new];
    _uiLbl.font = [UIFont systemFontOfSize:8];
    _uiLbl.numberOfLines = 0;
    _uiLbl.size = CGSizeMake(kScreenWidth, kCellHeight);
    
    _yyLbl = [YYLabel new];
    _yyLbl.font = _uiLbl.font;
    _yyLbl.numberOfLines = 0;
    _yyLbl.size = _uiLbl.size;
    // 开启异步绘制
    _yyLbl.displaysAsynchronously = YES;
    _yyLbl.hidden = YES;
    
    [self.contentView addSubview:_uiLbl];
    [self.contentView addSubview:_yyLbl];
    return self;
}

- (void)setAsync:(BOOL)async {
    if (_async == async) return;
    _async = async;
    _uiLbl.hidden = async;
    _yyLbl.hidden = !async;
    
}
- (void)setAsyncText:(id)text
{
    if (_async) {
        _yyLbl.layer.contents = nil;
        _yyLbl.textLayout = text;
    } else {
        _uiLbl.attributedText = text;
    }
}
@end


@interface SZTextAsyncVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL async;
@property (nonatomic, strong) NSArray *strings;
@property (nonatomic, strong) NSArray *layouts;
@property (nonatomic, strong) UITableView *tableView;
@end
static  NSString *rid = @"CELL";
@implementation SZTextAsyncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SZTextAsynCell class] forCellReuseIdentifier:rid];
    [self.view addSubview:self.tableView];
    
    NSMutableArray *strings = [NSMutableArray new];
    NSMutableArray *layouts = [NSMutableArray new];
    for (int i = 0; i < 300; i++) {
        NSString *str = [NSString stringWithFormat:@"%d 异步加载测试 ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        text.font = [UIFont systemFontOfSize:10];
        text.strokeColor = [UIColor redColor];
        text.strokeWidth = @(-3);
        text.maximumLineHeight = 12;
        text.minimumLineHeight = 12;
        text.lineSpacing = 0;
        text.lineHeightMultiple = 1;
        
        NSShadow *shadow = [NSShadow new];
        shadow.shadowBlurRadius = 1;
        shadow.shadowColor = [UIColor redColor];
        shadow.shadowOffset = CGSizeMake(0, 1);
//        text.shadow = shadow;
        [strings addObject:text];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kScreenHeight)];
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        [layouts addObject:layout];
    }
    self.layouts = layouts;
    self.strings = strings;
    
    UIVisualEffectView *toolbar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    toolbar.size = CGSizeMake(kScreenWidth, 40);
    toolbar.top = kiOS7Later ? kStatusAndNavHeight : 0;
    [self.view addSubview:toolbar];
    
    SZFPSLabel *fpsLbl = [SZFPSLabel new];
    fpsLbl.centerY = toolbar.height * 0.5;
    fpsLbl.left = 5;
    [toolbar.contentView addSubview:fpsLbl];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"UILabel/YYLabel(Async): ";
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    label.centerY = toolbar.height / 2;
    label.left = fpsLbl.right + 10;
    [toolbar.contentView addSubview:label];
    
    UISwitch *switcher = [UISwitch new];
    [switcher sizeToFit];
    switcher.centerY = toolbar.height / 2;
    switcher.left = label.right + (kiOS7Later ? 10 : -10);
    switcher.layer.transformScale = 0.7;
    @weakify(self);
    [switcher addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *switcher) {
        @strongify(self);
        if (!self) return;
        [self setAsync:switcher.isOn];
    }];
    [toolbar.contentView addSubview:switcher];

}

- (void)setAsync:(BOOL)async {
    _async = async;
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(SZTextAsynCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.async = _async;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (_async) {
            [cell setAsyncText:_layouts[indexPath.row]];
        } else {
            [cell setAsyncText:_strings[indexPath.row]];
        }
        
    }];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _strings.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZTextAsynCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    cell.async = _async;
    if (_async) {
        [cell setAsyncText:self.layouts[indexPath.row]];
    } else {
        [cell setAsyncText:self.strings[indexPath.row]];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
