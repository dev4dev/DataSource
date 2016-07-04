//
//  PersonViewModelFancy.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "PersonViewModelFancy.h"
#import "PersonTableViewCell.h"

@implementation PersonViewModelFancy

+ (NSString *)cellIdentifier
{
	return @"PersonFancyCell";
}

+ (void)setupTableView:(UITableView *)tableView
{
	[tableView registerNib:[UINib nibWithNibName:@"PersonFancyTableViewCell" bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}

- (void)setupCell:(PersonTableViewCell *)cell
{
	[super setupCell:cell];
	cell.textLabel.text = [NSString stringWithFormat:@"~~~> %@ <~~~", self.model.name];
}

@end
