//
//  Company+DataSource.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "Company+DataSource.h"
#import "CompanyTableViewCell.h"

@implementation Company (DataSource)

+ (NSString *)cellIdentifier
{
	return @"CompanyCell";
}

+ (void)setupTableView:(UITableView *)tableView
{
	[tableView registerClass:[CompanyTableViewCell class] forCellReuseIdentifier:[self cellIdentifier]];
}

- (void)setupCell:(CompanyTableViewCell *)cell
{
	cell.textLabel.text = self.name;
	cell.detailTextLabel.text = self.address;
}

@end
