
//
//  SZTextAsyncVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/11.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextAsyncVC.h"

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rid];
    [self.view addSubview:self.tableView];
    
    NSMutableArray *strings = [NSMutableArray new];
    NSMutableArray *layouts = [NSMutableArray new];
    for (int i = 0; i < 300; i++) {
        NSString *str = [NSString stringWithFormat:@"%d 异步加载测试 ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        
    }
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"teeee-%ld",indexPath.row + 1];
    return cell;
}

@end
