//
//  DataSourceCellConfigurable.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceCellConfigurable <NSObject>

+ (NSString *)cellIdentifier;
+ (void)setupTableView:(UITableView *)tableView;
- (void)setupCell:(UITableViewCell *)cell;

@end
