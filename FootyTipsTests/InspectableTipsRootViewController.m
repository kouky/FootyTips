//
//  InspectableTipsRootViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "InspectableTipsRootViewController.h"

@implementation InspectableTipsRootViewController {
  BOOL wasAskedtoAddChildPageViewController;
}

- (FootyFixture *)footyFixture
{
  return _footyFixture;
}

- (TipsPageViewController *)pageViewController
{
  return _pageViewController;
}

- (void)setPageViewController:(TipsPageViewController *)pageViewController
{
  _pageViewController = pageViewController;
}

- (void)addChildPageViewControler
{
  wasAskedtoAddChildPageViewController = YES;
}

- (BOOL)wasAskedtoAddChildPageViewController
{
  return wasAskedtoAddChildPageViewController;
}

@end
