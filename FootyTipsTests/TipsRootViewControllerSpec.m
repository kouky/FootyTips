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

static TipsRootViewController *viewController;
static InspectableTipsRootViewController *inspectableViewController;
static id mockTipsManager;

SpecBegin(TipsRootViewController)

describe(@"TipsRootViewController", ^{
  
  before(^{
    viewController = [[TipsRootViewController alloc] init];
    inspectableViewController = [[InspectableTipsRootViewController alloc] init];
    mockTipsManager = [OCMockObject niceMockForClass:TipsManager.class];
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
      [inspectableViewController didReceiveFixtureModel:mockFootyFixture];
      expect([inspectableViewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    pending(@"configure tips page view controller");
  });
  
  after(^{
    [MockModels clear];
    mockTipsManager = nil;
    inspectableViewController = nil;
    viewController = nil;
  });
  
});

SpecEnd
