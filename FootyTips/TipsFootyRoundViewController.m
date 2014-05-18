//
//  TipsFootyRoundViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsFootyRoundViewController.h"
#import "FootyRound.h"
#import "GameSummaryCell.h"
#import "GameDetailsObjectConfiguration.h"
#import "GameDetailsViewController.h"

@interface TipsFootyRoundViewController ()

@end

@implementation TipsFootyRoundViewController

// Designated initializer
- (id)init
{
  self = [super initWithStyle:UITableViewStylePlain];
  return self;
}

// Previous designated initializer defers to init
- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return (self.footyRound) ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (self.footyRound) ? [[self.footyRound games] count] : 0;
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
  Game *game = [self gameForRowAtIndexPath:indexPath];
  cell.homeTeamLabel.text = game.homeTeam.shortName;
  cell.awayTeamLabel.text = game.awayTeam.shortName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Game *game = [self gameForRowAtIndexPath:indexPath];
  GameDetailsViewController *gameDetailsViewController = [GameDetailsObjectConfiguration gameDetailsViewControllerForGame:game];
  [[self navigationController] pushViewController:gameDetailsViewController animated:YES];
} 

# pragma mark Private

- (Game *)gameForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [[self.footyRound games] objectAtIndex:indexPath.row];
}

@end
