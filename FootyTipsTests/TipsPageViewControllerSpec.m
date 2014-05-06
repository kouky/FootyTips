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
#import <OCMock/OCMock.h>
#import "TipsPageViewController.h"
#import "TipsManager.h"

static TipsPageViewController *viewController;
static id mockTipsManager;

SpecBegin(TipsPageViewController)

describe(@"TipsPageViewController", ^{
  
  before(^{
    viewController = [[TipsPageViewController alloc] init];
    mockTipsManager = [OCMockObject mockForClass:TipsManager.class];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsPageViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  it(@"init configures a horizontal scrolling page controller", ^{
    expect(viewController.navigationOrientation).to.equal(UIPageViewControllerNavigationOrientationHorizontal);
    expect(viewController.transitionStyle).to.equal(UIPageViewControllerTransitionStyleScroll);
    expect(viewController.spineLocation).to.equal(UIPageViewControllerSpineLocationNone);
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      viewController.manager = nil;
      expect(viewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      [[mockTipsManager stub] setDelegate:[OCMArg any]];
      viewController.manager = mockTipsManager;
      expect(viewController.manager).to.beIdenticalTo(mockTipsManager);
    });

    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:viewController];
      viewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  after(^{
    mockTipsManager = nil;
    viewController = nil;
  });

});

SpecEnd
