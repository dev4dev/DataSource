//
//  ArrayDataSource.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<id<DataSourceCellConfigurable>> *data;

@end

@implementation ArrayDataSource

- (instancetype)init
{
	if (self = [super init]) {
		_data = [NSMutableArray array];
	}

	return self;
}

#pragma mark - Public

- (void)connectTableView:(UITableView *)tableView
{
	tableView.dataSource = self;
	self.tableView = tableView;
}

- (void)registerDataClass:(Class)dataClass
{
	if ([dataClass conformsToProtocol:@protocol(DataSourceCellConfigurable)]) {
		[dataClass setupTableView:self.tableView];
	} else {
		NSAssert(NO, @"[DataSource Error]: Trying to register data class which doesn't conform to DataSourceCellConfigurable protocol");
	}
}

- (void)addData:(id<DataSourceCellConfigurable>)object
{
	[self.data addObject:object];
	[self.tableView reloadData];
}

- (void)deleteObject:(id<DataSourceCellConfigurable>)object
{
	[self.data removeObject:object];
	[self.tableView reloadData];
}

- (void)deleteObjectAtIndex:(NSUInteger)index
{
	if (index < self.data.count) {
		[self.data removeObjectAtIndex:index];
	}
	[self.tableView reloadData];
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id<DataSourceCellConfigurable> object = self.data[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[object class] cellIdentifier] forIndexPath:indexPath];
	[object setupCell:cell];
	return cell;
}

@end
