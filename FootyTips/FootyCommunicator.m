//
//  FootyCommunicator.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@implementation FootyCommunicator

- (id)init
{
  self = [super init];
  if (self) {
    _manager = [AFHTTPRequestOperationManager manager];
  }
  return self;
}

- (void)fetchFixture
{
  [_manager GET:@"http://footytips.kouky.org/fixture.json" parameters:nil success:nil failure:nil];
}

- (void)fetchLadder
{
  [_manager GET:@"http://footytips.kouky.org/ladder.json" parameters:nil success:nil failure:nil];
}

@end
