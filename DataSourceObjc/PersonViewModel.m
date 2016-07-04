//
//  PersonViewModel.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "PersonViewModel.h"
#import "PersonTableViewCell.h"

@interface PersonViewModel ()

@property (nonatomic, strong) Person *model;

@end

@implementation PersonViewModel

- (instancetype)initWithModel:(Person *)model
{
	if (self = [self init]) {
		_model = model;
	}

	return self;
}

#pragma mark - DataSource

+ (NSString *)cellIdentifier
{
	return @"PersonCell";
}

+ (void)setupTableView:(UITableView *)tableView
{
	[tableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

- (void)setupCell:(PersonTableViewCell *)cell
{
	cell.textLabel.text = self.model.name;
	cell.detailTextLabel.text = self.model.address;
}

@end
