//
//  SZFeedListVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/12.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZFeedListVC.h"
#import <YYKit.h>

@interface SZFeedListVC ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation SZFeedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    self.images = @[].mutableCopy;
    
    [self addCell:@"Twitter" class:@"TWTimelineItemsVC" image:@"Twitter.jpg"];
    [self addCell:@"微博" class:@"WBTimelineItemsVC" image:@"Weibo.jpg"];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Feed List Demo";
}

- (void)addCell:(NSString *)title class:(NSString *)className image:(NSString *)imageName {
    [self.titles addObject:title];
    [self.classNames addObject:className];
    [self.images addObject:[UIImage imageNamed:imageName]];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rid = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.imageView.image = _images[indexPath.row];
    cell.imageView.layer.cornerRadius = 50 * 0.5;
    cell.imageView.layer.masksToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = _titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
