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
#import "GameSummaryCell.h"

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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[[[_footyFixture rounds] objectAtIndex:section] games] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"gameSummaryCell";
  
  GameSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    [tableView registerNib:[UINib nibWithNibName:@"GameSummaryCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GameSummaryCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  Game *game = [[[[_footyFixture rounds] objectAtIndex:indexPath.section] games] objectAtIndex:indexPath.row];
  
  cell.homeTeamLabel.text = game.homeTeam.shortName;
  cell.awayTeamLabel.text = game.awayTeam.shortName;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  FootyRound *roundForSection = _footyFixture.rounds[section];
  return [NSString stringWithFormat:@"Round %@", roundForSection.id];
}

# pragma mark TipsListManagerDelegate protocol methods

- (void)didReceiveFixtureModel:(FootyFixture *)fixture
{
  _footyFixture = fixture;
  [self.tableView reloadData];
}

@end
