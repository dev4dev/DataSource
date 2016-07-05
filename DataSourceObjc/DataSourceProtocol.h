//
//  DataSourceProtocol.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;

@protocol DataSourceSection;

@protocol DataSourceProtocol <UITableViewDataSource>

@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, assign) UITableViewRowAnimation animation;

@optional
@property (nonatomic, weak) id<DataSourceProtocol> parentDataSource;
- (NSUInteger)indexOfSection:(id<DataSourceSection>)section;

@end
