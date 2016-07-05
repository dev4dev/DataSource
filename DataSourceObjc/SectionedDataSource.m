//
//  SectionedDataSource.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "SectionedDataSource.h"
#import "ArrayDataSource.h"
#import "DataSource+Protected.h"

@interface SectionedDataSource ()

@property (nonatomic, strong) NSMutableArray<id<DataSourceSection, DataSourceProtocol>> *sections;

@end

@implementation SectionedDataSource

- (instancetype)init
{
	if (self = [super init]) {
		_sections = [NSMutableArray array];
	}

	return self;
}

#pragma mark - Properties

- (NSUInteger)sectionsCount
{
	return self.sections.count;
}

- (NSArray *)objects
{
	NSMutableArray *data = [NSMutableArray array];
	[self.sections enumerateObjectsUsingBlock:^(id<DataSourceSection,DataSourceProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[data addObject:obj.objects];
	}];
	return [data copy];
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

- (void)addSection:(DataSourceSectionSetupBlock)block
{
	id<DataSourceSection> ds = [ArrayDataSource new];
	ds.parentDataSource = self;
	ds.animation = self.animation;
	[self.tableView beginUpdates];
	[self.sections addObject:ds];
	if (block) {
		block(ds);
	}
	[self.tableView insertSections:[NSIndexSet indexSetWithIndex:self.sections.count - 1] withRowAnimation:self.animation];
	[self.tableView endUpdates];
}

- (void)deleteSectionAtIndex:(NSUInteger)index
{
	if (index < self.sections.count) {
		[self.tableView beginUpdates];
		[self.sections removeObjectAtIndex:index];
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:self.animation];
		[self.tableView endUpdates];
	}
}

- (id<DataSourceSection>)sectionAtIndex:(NSUInteger)index
{
	if (index < self.sections.count) {
		return self.sections[index];
	}

	return nil;
}

- (void)addData:(id<DataSourceCellConfigurable>)object toSection:(NSUInteger)section
{
	if (section < self.sections.count) {
		id<DataSourceSection> ds = self.sections[section];
		[ds addData:object];
	}
}

- (void)addData:(id<DataSourceCellConfigurable>)object toIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section < self.sections.count) {
		id<DataSourceSection> ds = self.sections[indexPath.section];
		[ds insertData:object atIndex:indexPath.row];
	}
}

- (void)setData:(NSArray<id<DataSourceCellConfigurable>> *)object forSection:(NSUInteger)section
{
	if (section < self.sections.count) {
		id<DataSourceSection> ds = self.sections[section];
		[ds setData:object];
	}
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section < self.sections.count) {
		id<DataSourceSection> ds = self.sections[indexPath.section];
		[ds deleteObjectAtIndex:indexPath.row];
	}
}

- (id<DataSourceCellConfigurable>)objectAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section < self.sections.count) {
		id<DataSourceSection> section = self.sections[indexPath.section];
		return [section objectAtIndex:indexPath.row];
	}
	return nil;
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.sections[section] numberOfRowsInSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id<DataSourceSection> ds = self.sections[indexPath.section];
	return [ds tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	id<DataSourceSection> ds = self.sections[section];
	return ds.sectionHeaderTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	id<DataSourceSection> ds = self.sections[section];
	return ds.sectionFooterTitle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self deleteObjectAtIndexPath:indexPath];
	}
}

- (NSUInteger)indexOfSection:(id<DataSourceSection>)section
{
	return [self.sections indexOfObject:section];
}

@end
