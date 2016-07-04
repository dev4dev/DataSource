//
//  PersonViewModel.h
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "DataSourceCellConfigurable.h"

@interface PersonViewModel : NSObject <DataSourceCellConfigurable>

@property (nonatomic, strong, readonly) Person *model;

- (instancetype)initWithModel:(Person *)model;

@end
