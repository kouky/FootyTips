//
//  TipsListViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "TipsListViewController.h"
#import "InspectableTipsListViewController.h"
#import "TipsManager.h"
#import "GameSummaryCell.h"
#import "GameDetailsViewController.h"
#import "GameDetailsObjectConfiguration.h"

static InspectableTipsListViewController *inspectableViewController;
static NSIndexPath *firstCellIndexPath;
static id mockTipsManager;
static id mockNavController;
static id mockGameDetailsViewController;
static id mockGameDetailsObjectConfiguration;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    inspectableViewController = [[InspectableTipsListViewController alloc] init];
    mockTipsManager = [OCMockObject mockForClass:TipsManager.class];
    firstCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    mockNavController = [OCMockObject niceMockForClass:UINavigationController.class];
    mockGameDetailsViewController = [OCMockObject mockForClass:GameDetailsViewController.class];
    mockGameDetailsObjectConfiguration = [OCMockObject mockForClass:GameDetailsObjectConfiguration.class];
    inspectableViewController.navigationController = mockNavController;
    [MockModels enumerate];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsListViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  describe(@"initialisation", ^{

    it(@"with init configures a plain table view style", ^{
      expect(inspectableViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"with initWithStyle always configues a plain table view style", ^{
      TipsListViewController *tips = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tips.tableView.style).to.equal(UITableViewStylePlain);
    });
    
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      inspectableViewController.manager = nil;
      expect(inspectableViewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      [[mockTipsManager stub] setDelegate:[OCMArg any]];
      inspectableViewController.manager = mockTipsManager;
      expect(inspectableViewController.manager).to.beIdenticalTo(mockTipsManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:inspectableViewController];
      inspectableViewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  describe(@"viewDidLoad", ^{
    
    it(@"requests the building of the footy fixture", ^{
      [[mockTipsManager expect] buildFixture];
      [[mockTipsManager stub] setDelegate:[OCMArg any]];
      inspectableViewController.manager = mockTipsManager;
      [inspectableViewController viewDidLoad];
      [mockTipsManager verify];
    });
    
  });
  
  describe(@"tips list manager delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture model", ^{
      [inspectableViewController didReceiveFixtureModel:mockFootyFixture];
      expect([inspectableViewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    it(@"calls reload data on the table view", ^{
      id mockTableView = [OCMockObject partialMockForObject:inspectableViewController.tableView];
      [[mockTableView expect] reloadData];
      [inspectableViewController didReceiveFixtureModel:[OCMArg any]];
      [mockTableView verify];
    });

  });
  
  describe(@"table view data source", ^{
    
    before(^{
      [inspectableViewController setFootyFixture:mockFootyFixture];
    });
    
    it(@"number of sections in table view corresponds to number of rounds", ^{
      NSInteger numberSections = [inspectableViewController numberOfSectionsInTableView:nil];
      expect(numberSections).to.equal(1);
    });
    
    it(@"header for table view section correponds to the round number", ^{
      NSString *firstSectionTitle = [inspectableViewController tableView:nil titleForHeaderInSection:0];
      expect(firstSectionTitle).to.equal(@"Round 3");
    });
    
    it(@"nuber of rows in section", ^{
      NSInteger numberRows = [inspectableViewController tableView:nil numberOfRowsInSection:0];
      expect(numberRows).to.equal(1);
    });
    
    it(@"cell properties represent game  details", ^{
      UITableView *tableView = inspectableViewController.tableView;
      GameSummaryCell *cell = (GameSummaryCell *)[inspectableViewController tableView:tableView cellForRowAtIndexPath:firstCellIndexPath];
      [inspectableViewController tableView:tableView willDisplayCell:cell forRowAtIndexPath:firstCellIndexPath];
      expect(cell.homeTeamLabel.text).to.equal([mockHomeTeam shortName]);
      expect(cell.awayTeamLabel.text).to.equal([mockAwayTeam shortName]);
    });
    
    it(@"cell selection pushes a game details view controller for the selected game", ^{
      [[[mockGameDetailsObjectConfiguration expect] andReturn:mockGameDetailsViewController] gameDetailsViewControllerForGame:mockGame];
      [[mockNavController expect] pushViewController:mockGameDetailsViewController animated:YES];
      
      [inspectableViewController tableView:nil didSelectRowAtIndexPath:firstCellIndexPath];
      [mockGameDetailsObjectConfiguration verify];
      [mockNavController verify];
    });
    
  });
  
  after(^{
    [MockModels clear];
    mockNavController = nil;
    mockGameDetailsViewController = nil;
    mockGameDetailsObjectConfiguration = nil;
    mockTipsManager = nil;
    firstCellIndexPath = nil;
    inspectableViewController = nil;
  });
  
});

SpecEnd
