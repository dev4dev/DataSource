//
//  SectionedDataSource.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

@import UIKit;
#import "DataSource.h"
#import "DataSourceCellConfigurable.h"
#import "ArrayDataSource.h"

typedef void(^DataSourceSectionSetupBlock)(id<DataSourceSection> section);

@interface SectionedDataSource : DataSource <DataSourceProtocol>

@property (nonatomic, assign, readonly) NSUInteger sectionsCount;
@property (nonatomic, strong, readonly) NSArray *objects;

- (void)addSection:(DataSourceSectionSetupBlock)block;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (id<DataSourceSection>)sectionAtIndex:(NSUInteger)index;

- (void)addData:(id<DataSourceCellConfigurable>)object toSection:(NSUInteger)section;
- (void)addData:(id<DataSourceCellConfigurable>)object toIndexPath:(NSIndexPath *)indexPath;
- (void)setData:(NSArray<id<DataSourceCellConfigurable>> *)object forSection:(NSUInteger)section;
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
- (id<DataSourceCellConfigurable>)objectAtIndexPath:(NSIndexPath *)indexPath;

@end
