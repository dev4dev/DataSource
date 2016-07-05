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
#import "SectionedDataSource.h"

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) ArrayDataSource *dataSource;
@property (nonatomic, strong) SectionedDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

//	self.dataSource = [ArrayDataSource new];
	self.dataSource = [SectionedDataSource new];
	self.dataSource.editable = YES;
	self.dataSource.animation = UITableViewRowAnimationFade;

	[self.dataSource connectTableView:self.tableView];
	[self.dataSource registerDataClass:[PersonViewModel class]];
	[self.dataSource registerDataClass:[PersonViewModelFancy class]];
	[self.dataSource registerDataClass:[Company class]];
//	[self.dataSource registerDataClass:[Item class]];
	[self.dataSource addSection:^(id<DataSourceSection> section) {
		section.sectionHeaderTitle = @"Static";
		section.sectionFooterTitle = @"Add + to add random objects";
	}];

	[self.dataSource addData:[self createPerson] toSection:0];
	[self.dataSource addData:[self createCompany] toSection:0];

//	[self.dataSource addData:[self createPerson]];
//	[self.dataSource addData:[self createCompany]];
//	[self.dataSource addData:[Item new]];
	[self.dataSource addSection:^(id<DataSourceSection> section) {
		section.sectionHeaderTitle = @"Dynamic";
	}];
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
//	[self.dataSource addData:object toSection:1];
	[self.dataSource addData:object toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	id object = [self.dataSource objectAtIndexPath:indexPath];
	NSLog(@"Selected %@", object);
}

@end
