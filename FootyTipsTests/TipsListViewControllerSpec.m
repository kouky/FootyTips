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
#import <OCMock/OCMock.h>
#import "TipsListViewController.h"
#import "InspectableTipsListViewController.h"
#import "TipsListManager.h"
#import "FootyFixture.h"
#import "GameSummaryCell.h"
#import "GameDetailsViewController.h"

static InspectableTipsListViewController *inspectableTipsListViewController;
static NSIndexPath *firstCellIndexPath;
static UINavigationController *navController;
static id mockTipsListManager;
static id mockHomeTeam;
static id mockAwayTeam;
static id mockGame;
static id mockFootyRound;
static id mockFootyFixture;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    inspectableTipsListViewController = [[InspectableTipsListViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:inspectableTipsListViewController];
    mockTipsListManager = [OCMockObject mockForClass:TipsListManager.class];
    firstCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    // Mock models
    mockHomeTeam = [OCMockObject mockForClass:Team.class];
    [[[mockHomeTeam stub] andReturn:@"HAW"] shortName];
    
    mockAwayTeam = [OCMockObject mockForClass:Team.class];
    [[[mockAwayTeam stub] andReturn:@"ESS"] shortName];
    
    mockGame = [OCMockObject mockForClass:Game.class];
    [[[mockGame stub] andReturn:mockHomeTeam] homeTeam];
    [[[mockGame stub] andReturn:mockAwayTeam] awayTeam];
    
    mockFootyRound = [OCMockObject mockForClass:FootyRound.class];
    [[[mockFootyRound stub] andReturn:@3] id];
    [[[mockFootyRound stub] andReturn:@[mockGame]] games];
    
    mockFootyFixture = [OCMockObject mockForClass:FootyFixture.class];
    [[[mockFootyFixture stub] andReturn:@[mockFootyRound]] rounds];
  });
  
  it(@"conforms to the TipsListManagerDelegate protocol", ^{
    expect(TipsListViewController.class).to.conformTo(@protocol(TipsListManagerDelegate));
  });
  
  describe(@"initialisation", ^{

    it(@"with init configures a plain table view style", ^{
      expect(inspectableTipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"with initWithStyle always configues a plain table view style", ^{
      TipsListViewController *tips = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tips.tableView.style).to.equal(UITableViewStylePlain);
    });
    
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      inspectableTipsListViewController.manager = nil;
      expect(inspectableTipsListViewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      [[mockTipsListManager stub] setDelegate:[OCMArg any]];
      inspectableTipsListViewController.manager = mockTipsListManager;
      expect(inspectableTipsListViewController.manager).to.beIdenticalTo(mockTipsListManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsListManager expect] setDelegate:inspectableTipsListViewController];
      inspectableTipsListViewController.manager = mockTipsListManager;
      [mockTipsListManager verify];
    });
    
  });
  
  describe(@"viewDidLoad", ^{
    
    it(@"requests the building of the footy fixture", ^{
      [[mockTipsListManager expect] buildFixture];
      [[mockTipsListManager stub] setDelegate:[OCMArg any]];
      inspectableTipsListViewController.manager = mockTipsListManager;
      [inspectableTipsListViewController viewDidLoad];
      [mockTipsListManager verify];
    });
    
  });
  
  describe(@"tips list manager delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture model", ^{
      [inspectableTipsListViewController didReceiveFixtureModel:mockFootyFixture];
      expect([inspectableTipsListViewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    it(@"calls reload data on the table view", ^{
      id mockTableView = [OCMockObject partialMockForObject:inspectableTipsListViewController.tableView];
      [[mockTableView expect] reloadData];
      [inspectableTipsListViewController didReceiveFixtureModel:[OCMArg any]];
      [mockTableView verify];
    });

  });
  
  describe(@"table view data source", ^{
    
    before(^{
      [inspectableTipsListViewController setFootyFixture:mockFootyFixture];
    });
    
    it(@"number of sections in table view corresponds to number of rounds", ^{
      NSInteger numberSections = [inspectableTipsListViewController numberOfSectionsInTableView:nil];
      expect(numberSections).to.equal(1);
    });
    
    it(@"header for table view section correponds to the round number", ^{
      NSString *firstSectionTitle = [inspectableTipsListViewController tableView:nil titleForHeaderInSection:0];
      expect(firstSectionTitle).to.equal(@"Round 3");
    });
    
    it(@"nuber of rows in section", ^{
      NSInteger numberRows = [inspectableTipsListViewController tableView:nil numberOfRowsInSection:0];
      expect(numberRows).to.equal(1);
    });
    
    it(@"cell properties represent game  details", ^{
      NSIndexPath *firstCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
      UITableView *tableView = inspectableTipsListViewController.tableView;
      GameSummaryCell *cell = (GameSummaryCell *)[inspectableTipsListViewController tableView:tableView cellForRowAtIndexPath:firstCellIndexPath];
      [inspectableTipsListViewController tableView:tableView willDisplayCell:cell forRowAtIndexPath:firstCellIndexPath];
      expect(cell.homeTeamLabel.text).to.equal([mockHomeTeam shortName]);
      expect(cell.awayTeamLabel.text).to.equal([mockAwayTeam shortName]);
    });
    
    it(@"cell selection pushes a game details view controller", ^{
      [inspectableTipsListViewController tableView:nil didSelectRowAtIndexPath:firstCellIndexPath];
      expect(navController.topViewController).to.beKindOf(GameDetailsViewController.class);
    });
    
    it(@"cell selection sets the game model on the details view controller", ^{
      [inspectableTipsListViewController tableView:nil didSelectRowAtIndexPath:firstCellIndexPath];
      GameDetailsViewController *gameDetailsViewController = (GameDetailsViewController *)[navController topViewController];
      expect(gameDetailsViewController.game).to.beIdenticalTo(mockGame);
    });
    
  });
  
  after(^{
    mockAwayTeam = nil;
    mockHomeTeam = nil;
    mockGame = nil;
    mockFootyRound = nil;
    mockFootyFixture = nil;
    mockTipsListManager = nil;
    firstCellIndexPath = nil;
    inspectableTipsListViewController = nil;
    navController = nil;
  });
  
});

SpecEnd
