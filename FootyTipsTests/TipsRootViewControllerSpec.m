//
//  TipsRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "TipsRootViewController.h"
#import "InspectableTipsRootViewController.h"
#import "TipsManager.h"
#import "TipsObjectConfiguration.h"
#import "TipsPageViewController.h"

static InspectableTipsRootViewController *viewController;
static id mockTipsManager;
static id mockTipsObjectConfiguration;
static id mockTipsPageViewController;

SpecBegin(TipsRootViewController)

describe(@"TipsRootViewController", ^{
  
  before(^{
    viewController = [[InspectableTipsRootViewController alloc] init];
    mockTipsManager = [OCMockObject niceMockForClass:TipsManager.class];
    mockTipsObjectConfiguration = [OCMockObject mockForClass:TipsObjectConfiguration.class];
    mockTipsPageViewController = [OCMockObject mockForClass:TipsPageViewController.class];
    [MockModels enumerate];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsRootViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      viewController.manager = nil;
      expect(viewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      viewController.manager = mockTipsManager;
      expect(viewController.manager).to.beIdenticalTo(mockTipsManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:viewController];
      viewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  it(@"viewDidLoad requests the building of the footy fixture", ^{
    [[mockTipsManager expect] buildFixture];
    viewController.manager = mockTipsManager;
    [viewController viewDidLoad];
    [mockTipsManager verify];
  });
  
  describe(@"delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture ivar", ^{
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect([viewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    it(@"configures a tips page view controller", ^{
      [[[mockTipsObjectConfiguration expect] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      [mockTipsObjectConfiguration verify];
      expect(viewController.pageViewController).to.beIdenticalTo(mockTipsPageViewController);
    });
    
    it(@"only configures a tips page view controller if it's nil", ^{
      id mock = [OCMockObject mockForClass:TipsPageViewController.class];
      [viewController setPageViewController:mock];
      [[[mockTipsObjectConfiguration stub] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect(viewController.pageViewController).to.beIdenticalTo(mock);
    });
    
    it(@"adds the page view controller as a child view controller", ^{
      [[[mockTipsObjectConfiguration stub] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect(viewController.wasAskedtoAddChildPageViewController).to.beTruthy();
    });
    
  });
  
  after(^{
    [MockModels clear];
    mockTipsPageViewController = nil;
    mockTipsObjectConfiguration = nil;
    mockTipsManager = nil;
    viewController = nil;
  });
  
});

SpecEnd
