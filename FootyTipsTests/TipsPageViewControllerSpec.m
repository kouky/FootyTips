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
#import <objc/runtime.h>

static TipsPageViewController *viewController;

SpecBegin(TipsPageViewController)

describe(@"TipsPageViewController", ^{
  
  before(^{
    viewController = [[TipsPageViewController alloc] init];
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

    pending(@"pageViewController:viewControllerBeforeViewController:");
    pending(@"pageViewController:viewControllerAfterViewController:");
    
  });
  
  after(^{
    viewController = nil;
  });

});

SpecEnd
