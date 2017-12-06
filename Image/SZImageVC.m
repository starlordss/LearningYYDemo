//
//  SZImageVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/6.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZImageVC.h"

@interface SZImageVC ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation SZImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCellWithTitle:@"动图" className:@"SZImageDisplayVC"];
    [self addCellWithTitle:@"进度图" className:@"SZImageProgressiveVC"];
    [self addCellWithTitle:@"网页图" className:@"SZWebImageVC"];
}

- (void)addCellWithTitle:(NSString *)title className:(NSString *)className
{
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rid=@"IMG_CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.textColor = [UIColor brownColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
