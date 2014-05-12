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
#warning incomplete method
  return nil;
}

@end
