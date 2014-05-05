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
#import "TipsPageViewController.h"

static TipsPageViewController *viewController;

SpecBegin(TipsPageViewController)

describe(@"TipsPageViewController", ^{
  
  before(^{
    viewController = [[TipsPageViewController alloc] init];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsPageViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  it(@"init configures a horizontal scrolling page controller", ^{
    expect(viewController.navigationOrientation).to.equal(UIPageViewControllerNavigationOrientationHorizontal);
    expect(viewController.transitionStyle).to.equal(UIPageViewControllerTransitionStyleScroll);
    expect(viewController.spineLocation).to.equal(UIPageViewControllerSpineLocationNone);
  });
  
  after(^{
    viewController = nil;
  });

});

SpecEnd
