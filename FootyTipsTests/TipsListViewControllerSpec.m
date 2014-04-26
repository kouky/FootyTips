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
#import <objc/runtime.h>

static TipsListViewController *tipsListViewController;
static InspectableTipsListViewController *inspectableTipsListViewController;
static id mockTipsListManager;
static id mockFootyFixture;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
    inspectableTipsListViewController = [[InspectableTipsListViewController alloc] init];
    mockTipsListManager = [OCMockObject mockForClass:TipsListManager.class];
    mockFootyFixture = [OCMockObject mockForClass:FootyFixture.class];
    [[[mockFootyFixture stub] andReturn:@[@"round 1", @"round 2"]] rounds];
  });
  
  it(@"conforms to the TipsListManagerDelegate protocol", ^{
    expect(TipsListViewController.class).to.conformTo(@protocol(TipsListManagerDelegate));
  });
  
  it(@"has a manager property", ^{
    objc_property_t managerProperty = class_getProperty(tipsListViewController.class, "manager");
    expect(managerProperty).notTo.equal(NULL);
  });
  
  describe(@"initialisation", ^{

    it(@"with init configures a plain table view style", ^{
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"with initWithStyle always configues a plain table view style", ^{
      TipsListViewController *tips = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tips.tableView.style).to.equal(UITableViewStylePlain);
    });
    
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      tipsListViewController.manager = nil;
      expect(tipsListViewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      [[mockTipsListManager stub] setDelegate:[OCMArg any]];
      tipsListViewController.manager = mockTipsListManager;
      expect(tipsListViewController.manager).to.beIdenticalTo(mockTipsListManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsListManager expect] setDelegate:tipsListViewController];
      tipsListViewController.manager = mockTipsListManager;
      [mockTipsListManager verify];
    });
    
  });
  
  describe(@"viewDidLoad", ^{
    
    it(@"requests the building of the footy fixture", ^{
      [[mockTipsListManager expect] buildFixture];
      [[mockTipsListManager stub] setDelegate:[OCMArg any]];
      tipsListViewController.manager = mockTipsListManager;
      [tipsListViewController viewDidLoad];
      [mockTipsListManager verify];
    });
    
  });
  
  describe(@"calling delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture model", ^{
      [inspectableTipsListViewController didReceiveFixtureModel:mockFootyFixture];
      expect([inspectableTipsListViewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    it(@"calls reload data on the table view", ^{
      id mockTableView = [OCMockObject partialMockForObject:tipsListViewController.tableView];
      [[mockTableView expect] reloadData];
      [tipsListViewController didReceiveFixtureModel:[OCMArg any]];
      [mockTableView verify];
    });

  });
  
  it(@"number of sections in table view corresponds to number of rounds", ^{
    [inspectableTipsListViewController setFootyFixture:mockFootyFixture];
    NSInteger numberSections = [inspectableTipsListViewController numberOfSectionsInTableView:nil];
    expect(numberSections).to.equal(2);
  });
  
  after(^{
    mockFootyFixture = nil;
    mockTipsListManager = nil;
    inspectableTipsListViewController = nil;
    tipsListViewController = nil;
  });
  
});

SpecEnd
