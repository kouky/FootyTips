//
//  TipsPageViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 5/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "InspectableTipsPageViewController.h"
#import "TipsManager.h"

static InspectableTipsPageViewController *inspectableViewController;
static id mockTipsManager;

SpecBegin(TipsPageViewController)

describe(@"TipsPageViewController", ^{
  
  before(^{
    inspectableViewController = [[InspectableTipsPageViewController alloc] init];
    mockTipsManager = [OCMockObject niceMockForClass:TipsManager.class];
    [MockModels enumerate];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsPageViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  it(@"init configures a horizontal scrolling page controller", ^{
    expect(inspectableViewController.navigationOrientation).to.equal(UIPageViewControllerNavigationOrientationHorizontal);
    expect(inspectableViewController.transitionStyle).to.equal(UIPageViewControllerTransitionStyleScroll);
    expect(inspectableViewController.spineLocation).to.equal(UIPageViewControllerSpineLocationNone);
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      inspectableViewController.manager = nil;
      expect(inspectableViewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      inspectableViewController.manager = mockTipsManager;
      expect(inspectableViewController.manager).to.beIdenticalTo(mockTipsManager);
    });

    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:inspectableViewController];
      inspectableViewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  it(@"viewDidLoad requests the building of the footy fixture", ^{
    [[mockTipsManager expect] buildFixture];
    inspectableViewController.manager = mockTipsManager;
    [inspectableViewController viewDidLoad];
    [mockTipsManager verify];
  });
  
  describe(@"delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture ivar", ^{
      [inspectableViewController didReceiveFixtureModel:mockFootyFixture];
      expect([inspectableViewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    pending(@"calls reload data on the table views");
  });
  
  after(^{
    [MockModels clear];
    mockTipsManager = nil;
    inspectableViewController = nil;
  });

});

SpecEnd
