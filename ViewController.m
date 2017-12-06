//
//  ViewController.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/5.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LearningYYDemo";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCellWithTitle:@"Model" className:@"SZModelVC"];
    [self addCellWithTitle:@"Image" className:@"SZImageVC"];
    [self addCellWithTitle:@"Text" className:@"SZTextVC"];
    [self addCellWithTitle:@"Feed list" className:@"SZFeedListVC"];
    [self.tableView reloadData];
    
}

- (void)addCellWithTitle:(NSString *)title className:(NSString *)className
{
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加indexPth 会crash
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _classNames[indexPath.row];
    UIViewController *vc = [NSClassFromString(className) new];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
