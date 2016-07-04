//
//  ViewController.m
//  DataSourceObjc
//
//  Created by Alex Antonyuk on 7/4/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

#import "ViewController.h"
#import "ArrayDataSource.h"
#import "PersonViewModel.h"
#import "PersonViewModelFancy.h"
#import "Company+DataSource.h"
#import "Item.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ArrayDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.dataSource = [ArrayDataSource new];
	[self.dataSource connectTableView:self.tableView];
	[self.dataSource registerDataClass:[PersonViewModel class]];
	[self.dataSource registerDataClass:[PersonViewModelFancy class]];
	[self.dataSource registerDataClass:[Company class]];
//	[self.dataSource registerDataClass:[Item class]];

	[self.dataSource addData:[self createPerson]];
	[self.dataSource addData:[self createCompany]];
//	[self.dataSource addData:[Item new]];
}

- (PersonViewModel *)createPerson
{
	Person *p = [Person new];
	p.name = @"Bob";
	p.address = @"Lorem Street. 11";
	Class vm = (arc4random_uniform(2)) == 0 ? [PersonViewModel class] : [PersonViewModelFancy class];
	return [[vm alloc] initWithModel:p];
}

- (Company *)createCompany
{
	Company *c = [Company new];
	c.name = @"Apple";
	c.address = @"Infinite Loop 1.";
	return c;
}

- (IBAction)onAddTap:(id)sender
{
	id<DataSourceCellConfigurable> object;
	if (arc4random_uniform(100) % 2 == 0) {
		object = [self createPerson];
	} else {
		object = [self createCompany];
	}
	[self.dataSource addData:object];
}

@end
