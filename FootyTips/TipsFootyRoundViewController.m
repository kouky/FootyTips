//
//  TipsFootyRoundViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsFootyRoundViewController.h"
#import "FootyRound.h"

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.footyRound.games count];
}

@end
