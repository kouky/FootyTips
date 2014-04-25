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

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
    inspectableTipsListViewController = [[InspectableTipsListViewController alloc] init];
    mockTipsListManager = [OCMockObject mockForClass:TipsListManager.class];
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
  
  it(@"sets the fixture model when delegate method didReceiveFixtureModel is called", ^{
    id mockFixture = [OCMockObject mockForClass:FootyFixture.class];
    [inspectableTipsListViewController didReceiveFixtureModel:mockFixture];
    expect([inspectableTipsListViewController footyFixture]).to.beIdenticalTo(mockFixture);
  });
  
  after(^{
    mockTipsListManager = nil;
    inspectableTipsListViewController = nil;
    tipsListViewController = nil;
  });
  
});

SpecEnd
