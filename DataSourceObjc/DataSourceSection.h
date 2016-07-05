//
//  DataSourceSection.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceCellConfigurable.h"
#import "DataSourceProtocol.h"

@protocol DataSourceSection <DataSourceProtocol>

@property (nonatomic, copy) NSString *sectionHeaderTitle;
@property (nonatomic, copy) NSString *sectionFooterTitle;

@property (nonatomic, strong, readonly) NSArray *objects;
- (NSInteger)numberOfRowsInSection;

- (void)addData:(id<DataSourceCellConfigurable>)object;
- (void)insertData:(id<DataSourceCellConfigurable>)object atIndex:(NSUInteger)index;
- (void)setData:(NSArray<id<DataSourceCellConfigurable>> *)objects;
- (void)deleteObject:(id<DataSourceCellConfigurable>)object;
- (void)deleteObjectAtIndex:(NSUInteger)index;
- (id<DataSourceCellConfigurable>)objectAtIndex:(NSUInteger)index;

@end
