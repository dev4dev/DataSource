//
//  ArrayDataSource.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;
#import "DataSource.h"
#import "DataSourceCellConfigurable.h"
#import "DataSourceSection.h"

@interface ArrayDataSource : DataSource <DataSourceSection>

@property (nonatomic, strong, readonly) NSArray *objects;
@property (nonatomic, weak) id<DataSourceProtocol> parentDataSource;

#pragma mark - DataSource Section
@property (nonatomic, copy) NSString *sectionHeaderTitle;
@property (nonatomic, copy) NSString *sectionFooterTitle;

@end
