//
//  InspectableFootyCommunicator.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "InspectableFootyCommunicator.h"

@implementation InspectableFootyCommunicator

- (AFHTTPRequestOperationManager *)requestManager
{
  return _requestManager;
}

- (void)setRequestManager:(AFHTTPRequestOperationManager *)requestManager
{
  _requestManager = requestManager;
}

@end
