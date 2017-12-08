//
//  SZTextVC.m
//  LearningYYDemo
//
//  Created by starz on 2017/12/8.
//  Copyright © 2017年 starz. All rights reserved.
//

#import "SZTextVC.h"
#import <YYKit.h>

@interface SZTextVC ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

static  NSString *rid = @"CELL";
@implementation SZTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray array];
    self.classNames = [NSMutableArray array];
    [self addCell:@"Text Attributes 1" class:@"SZTextAttributeVC"];
    [self addCell:@"Text Attributes 2" class:@"SZTextTagVC"];
    [self addCell:@"Text Attachments" class:@"SZTextAttachmentVC"];
    [self addCell:@"Text Edit" class:@"SZTextEditVC"];
    [self addCell:@"Text Parser (Markdown)" class:@"SZTextMarkdownVC"];
    [self addCell:@"Text Parser (Emoticon)" class:@"SZTextEmoticonVC"];
    [self addCell:@"Text Binding" class:@"SZTextBindingVC"];
    [self addCell:@"Copy and Paste" class:@"SZTextCopyPasteVC"];
    [self addCell:@"Undo and Redo" class:@"SZTextUndoRedoVC"];
    [self addCell:@"Ruby Annotation" class:@"SZTextRubyVC"];
    [self addCell:@"Async Display" class:@"SZTextAsyncVC"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rid];
    
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _classNames[indexPath.row];
    Class cla = NSClassFromString(className);
    if (cla) {
        UIViewController *vc = cla.new;
        vc.title = _titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
