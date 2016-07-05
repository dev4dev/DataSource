//
//  DataSource.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;
#import "DataSourceProtocol.h"

@interface DataSource : NSObject <DataSourceProtocol>

@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) UITableViewRowAnimation animation;
@property (nonatomic, weak, readonly) UITableView *tableView;

- (void)connectTableView:(UITableView *)tableView;
- (void)registerDataClass:(Class)dataClass;

@end
