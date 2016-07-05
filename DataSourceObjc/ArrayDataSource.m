//
//  ArrayDataSource.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "ArrayDataSource.h"
#import "DataSource+Protected.h"

@interface ArrayDataSource ()

@property (nonatomic, strong) NSMutableArray<id<DataSourceCellConfigurable>> *data;

@end

@implementation ArrayDataSource

@synthesize parentDataSource = _parentDataSource;
@synthesize tableView = _tableView;

- (instancetype)init
{
	if (self = [super init]) {
		_data = [NSMutableArray array];
	}

	return self;
}

- (UITableView *)tableView
{
	if (self.parentDataSource) {
		return self.parentDataSource.tableView;
	}

	return _tableView;
}

- (NSUInteger)activeSectionIndex
{
	if (self.parentDataSource) {
		return [self.parentDataSource indexOfSection:self];
	} else {
		return 0;
	}
}

- (NSArray *)objects
{
	return [self.data copy];
}

#pragma mark - Public

- (void)addData:(id<DataSourceCellConfigurable>)object
{
	[self.tableView beginUpdates];
	[self.data addObject:object];
	[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.data.count - 1 inSection:[self activeSectionIndex]]] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (void)insertData:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index
{
	if (index < self.data.count) {
		[self.tableView beginUpdates];
		[self.data insertObject:object atIndex:index];
		[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:[self activeSectionIndex]]] withRowAnimation:self.animation];
		[self.tableView endUpdates];
	} else {
		[self addData:object];
	}
}

- (void)setData:(NSArray<id<DataSourceCellConfigurable>> *)objects
{
	[self.data removeAllObjects];
	[self.data addObjectsFromArray:objects];
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
		[self.tableView beginUpdates];
		[self.data removeObjectAtIndex:index];
		NSLog(@"%lu",  (unsigned long)[self activeSectionIndex]);
		[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:[self activeSectionIndex]]] withRowAnimation:self.animation];
		[self.tableView endUpdates];
	}
}

- (id<DataSourceCellConfigurable>)objectAtIndex:(NSUInteger)index
{
	if (index < self.data.count) {
		return self.data[index];
	}

	return nil;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.data.count;
}

- (NSInteger)numberOfRowsInSection
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self deleteObjectAtIndex:indexPath.row];
	}
}

@end
