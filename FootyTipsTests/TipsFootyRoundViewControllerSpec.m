//
//  TipsFootyRoundViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "InspectableTipsFootyRoundViewController.h"
#import "GameSummaryCell.h"
#import "GameDetailsObjectConfiguration.h"
#import "GameDetailsViewController.h"
#import <objc/runtime.h>

static InspectableTipsFootyRoundViewController *viewController;
static NSIndexPath *firstCellIndexPath;
static id mockGameDetailsObjectConfiguration;
static id mockGameDetailsViewController;
static id mockNavController;

SpecBegin(TipsFootyRoundViewController)

describe(@"TipsFootyRoundViewController", ^{
  
  before(^{
    [MockModels enumerate];
    firstCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    mockGameDetailsObjectConfiguration = [OCMockObject mockForClass:GameDetailsObjectConfiguration.class];
    mockGameDetailsViewController = [OCMockObject mockForClass:GameDetailsViewController.class];
    mockNavController = [OCMockObject niceMockForClass:UINavigationController.class];
    viewController = [[InspectableTipsFootyRoundViewController alloc] init];
    viewController.navigationController = mockNavController;
  });
  
  it(@"init configures a plain table view style", ^{
    expect(viewController.tableView.style).to.equal(UITableViewStylePlain);
  });
  
  it(@"has a footyRound property with a copy attribute", ^{
    objc_property_t footyRoundProperty = class_getProperty(TipsFootyRoundViewController.class, "footyRound");
    expect(footyRoundProperty).notTo.equal(NULL);
    const char *propertyAttrs = property_getAttributes(footyRoundProperty);
    // See Objective-C Runtime Programming Guide
    expect(propertyAttrs).to.equal("T@\"FootyRound\",C,V_footyRound");
  });

  describe(@"table view data source", ^{
    
    before(^{
      [viewController setFootyRound:mockFootyRound];
    });
    
    it(@"number of sections is equal to one", ^{
      NSInteger numberSections = [viewController numberOfSectionsInTableView:nil];
      expect(numberSections).to.equal(1);
    });
    
    it(@"number of rows in first section equals the number of games for the round", ^{
      NSInteger numberRows = [viewController tableView:nil numberOfRowsInSection:0];
      expect(numberRows).to.equal([[mockFootyRound games] count]);
    });

    it(@"cell properties represent game  details", ^{
      UITableView *tableView = viewController.tableView;
      GameSummaryCell *cell = (GameSummaryCell *)[viewController tableView:tableView cellForRowAtIndexPath:firstCellIndexPath];
      [viewController tableView:tableView willDisplayCell:cell forRowAtIndexPath:firstCellIndexPath];
      expect(cell.homeTeamLabel.text).to.equal([mockHomeTeam shortName]);
      expect(cell.awayTeamLabel.text).to.equal([mockAwayTeam shortName]);
    });
    
    it(@"cell selection pushes a game details view controller for the selected game", ^{
      [[[mockGameDetailsObjectConfiguration expect] andReturn:mockGameDetailsViewController] gameDetailsViewControllerForGame:mockGame];
      [[mockNavController expect] pushViewController:mockGameDetailsViewController animated:YES];
      
      [viewController tableView:nil didSelectRowAtIndexPath:firstCellIndexPath];
      [mockGameDetailsObjectConfiguration verify];
      [mockNavController verify];
    });
    
  });
  
  after(^{
    mockNavController = nil;
    mockGameDetailsViewController = nil;
    mockGameDetailsObjectConfiguration = nil;
    firstCellIndexPath = nil;
    [MockModels clear];
    viewController = nil;
  });

});

SpecEnd
