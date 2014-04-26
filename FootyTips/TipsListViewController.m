//
//  TipsViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsListViewController.h"
#import "TipsListManager.h"
#import "FootyFixture.h"

@interface TipsListViewController ()

@end

@implementation TipsListViewController

// Designated initializer
- (id)init
{
  self = [super initWithStyle:UITableViewStylePlain];  
  return self;
}

// Previous designated initializer defers to init.
- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (void)setManager:(TipsListManager *)manager
{
  _manager = manager;
  _manager.delegate = self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.manager buildFixture];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [[_footyFixture rounds] count];
//  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
  // Return the number of rows in the section.
  return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
  
  // Configure the cell...
  
  return cell;
}
*/

# pragma mark TipsListManagerDelegate protocol methods

- (void)didReceiveFixtureModel:(FootyFixture *)fixture
{
  _footyFixture = fixture;
  [self.tableView reloadData];
}

@end
