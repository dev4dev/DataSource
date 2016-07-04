//
//  ArrayDataSource.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;
#import "DataSourceCellConfigurable.h"

@interface ArrayDataSource : NSObject

- (void)connectTableView:(UITableView *)tableView;
- (void)registerDataClass:(Class)dataClass;

- (void)addData:(id<DataSourceCellConfigurable>)object;
- (void)deleteObject:(id<DataSourceCellConfigurable>)object;
- (void)deleteObjectAtIndex:(NSUInteger)index;

@end
