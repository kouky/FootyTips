//
//  TipsListObjectConfiguration.m
//  FootyTips
//
//  Created by Michael Koukoullis on 19/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsListObjectConfiguration.h"
#import "TipsListManager.h"
#import "FootyCommunicator.h"

@implementation TipsListObjectConfiguration

+ (TipsListManager *)tipsListManager
{
  TipsListManager *manager = [[TipsListManager alloc] init];
  manager.communicator = [[FootyCommunicator alloc] init];
  manager.communicator.delegate = manager;
  return manager;
}

@end
