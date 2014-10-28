//
//  FPEventPopupVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPEventPopupVC.h"
#import "FPSimpleDataSource.h"
#import "FPEventTableViewCell.h"
#import "NSObject+FPAdditions.h"

@interface FPEventPopupVC () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FPSimpleDataSource *dataSource;

@end

@implementation FPEventPopupVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)updateForEvents:(NSArray *)events
{
    self.dataSource.items = events;
    [self.tableView reloadData];

    [self didChangeHeight:self.tableView.contentSize.height];
}

#pragma mark - Setup
- (void)setupTableView
{
    self.dataSource = [[FPSimpleDataSource alloc] init];
    self.dataSource.cellIdentifier = [FPEventTableViewCell fp_identifier];
    self.dataSource.cellConfigureBlock = ^(FPEventTableViewCell *cell, FPEvent *event) {
        [cell configureForModel:event];
    };

    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FPEvent *event = self.dataSource.items[indexPath.row];

    [self didSelectEvent:event];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark - Delegate
- (void)didSelectEvent:(FPEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(eventPopupVCDidSelectEvent:)]) {
        [self.delegate eventPopupVCDidSelectEvent:event];
    }
}

- (void)didChangeHeight:(CGFloat)height
{
    if ([self.delegate respondsToSelector:@selector(eventPopupVCDidChangeHeight:)]) {
        [self.delegate eventPopupVCDidChangeHeight:height];
    }
}

@end
