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
#import "TipsPageViewController.h"
#import "TipsFootyRoundViewController.h"
#import "TipsObjectConfiguration.h"
#import <objc/runtime.h>

static TipsPageViewController *viewController;
static id mockTipsFootyRoundViewController;
static id mockPreviousTipsFootyRoundViewController;
static id mockTipsObjectConfiguration;

SpecBegin(TipsPageViewController)

describe(@"TipsPageViewController", ^{
  
  before(^{
    [MockModels enumerate];
    
    mockTipsFootyRoundViewController = [OCMockObject mockForClass:TipsFootyRoundViewController.class];
    [[[mockTipsFootyRoundViewController stub] andReturn:mockFootyRound] footyRound];
    
    mockPreviousTipsFootyRoundViewController = [OCMockObject mockForClass:TipsFootyRoundViewController.class];
    
    mockTipsObjectConfiguration = [OCMockObject mockForClass:TipsObjectConfiguration.class];
    
    viewController = [[TipsPageViewController alloc] init];
    viewController.footyFixture = mockFootyFixture;
  });
  
  it(@"init configures a horizontal scrolling page controller", ^{
    expect(viewController.navigationOrientation).to.equal(UIPageViewControllerNavigationOrientationHorizontal);
    expect(viewController.transitionStyle).to.equal(UIPageViewControllerTransitionStyleScroll);
    expect(viewController.spineLocation).to.equal(UIPageViewControllerSpineLocationNone);
  });
  
  it(@"has a footyFixture property with a copy attribute", ^{
    objc_property_t footyFixtureProperty = class_getProperty(TipsPageViewController.class, "footyFixture");
    expect(footyFixtureProperty).notTo.equal(NULL);
    const char *propertyAttrs = property_getAttributes(footyFixtureProperty);
    // See Objective-C Runtime Programming Guide
    expect(propertyAttrs).to.equal("T@\"FootyFixture\",C,V_footyFixture");
  });
  
  it(@"conforms to the UIPageViewControllerDataSource protocol", ^{
    expect(TipsPageViewController.class).to.conformTo(@protocol(UIPageViewControllerDataSource));
  });
  
  describe(@"implements UIPageViewControllerDataSource protocol methods", ^{
    
    it(@"before view controller", ^{
      [[[mockFootyFixture expect] andReturn:mockPreviousFootyRound] footyRoundBefore:mockFootyRound];
      
      [[[mockTipsObjectConfiguration expect] andReturn:mockPreviousTipsFootyRoundViewController] tipsFootyRoundViewControllerForFootyRound:mockPreviousFootyRound];
      
      id previousViewController = [viewController pageViewController:nil viewControllerBeforeViewController:mockTipsFootyRoundViewController];
      
      [mockFootyFixture verify];
      [mockTipsObjectConfiguration verify];
      expect(previousViewController).to.beIdenticalTo(mockPreviousTipsFootyRoundViewController);
    });

    pending(@"pageViewController:viewControllerAfterViewController:");
    
  });
  
  after(^{
    mockTipsObjectConfiguration = nil;
    mockTipsFootyRoundViewController = nil;
    mockPreviousTipsFootyRoundViewController = nil;
    viewController = nil;
    [MockModels clear];
  });

});

SpecEnd
