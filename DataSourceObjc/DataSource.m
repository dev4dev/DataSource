//
//  DataSource.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "DataSource.h"
#import "DataSource+Protected.h"
#import "DataSourceCellConfigurable.h"

@interface DataSource ()

@end

@implementation DataSource

- (instancetype)init
{
	if (self = [super init]) {
		_animation = UITableViewRowAnimationNone;
	}

	return self;
}

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

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSAssert(NO, @"Use subclasses only");
	return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.editable;
}

@end
