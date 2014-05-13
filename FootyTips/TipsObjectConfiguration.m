//
//  TipsObjectConfiguration.m
//  FootyTips
//
//  Created by Michael Koukoullis on 19/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsObjectConfiguration.h"
#import "TipsManager.h"
#import "FootyCommunicator.h"
#import "TipsPageViewController.h"

@implementation TipsObjectConfiguration

+ (TipsManager *)tipsManager
{
  TipsManager *manager = [[TipsManager alloc] init];
  manager.communicator = [[FootyCommunicator alloc] init];
  manager.communicator.delegate = manager;
  return manager;
}

+ (TipsPageViewController *)tipsPageViewControllerForFootyFixture:(FootyFixture *)footyFixture
{
  NSParameterAssert(footyFixture != nil);
  TipsPageViewController *pageViewController = [[TipsPageViewController alloc] init];
  pageViewController.footyFixture = footyFixture;
  return pageViewController;
}

@end
