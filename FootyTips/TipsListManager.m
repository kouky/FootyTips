//
//  TipsListManager.m
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsListManager.h"
#import "FootyCommunicator.h"

@implementation TipsListManager

- (void)setDelegate:(id<TipsListManagerDelegate>)delegate
{
  if (delegate && ![delegate conformsToProtocol:@protocol(TipsListManagerDelegate)]) {
    [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to protocol" userInfo:nil] raise];
  }
  _delegate = delegate;
}

# pragma mark Public Methods

- (void)fetchFixture
{
  [self.communicator fetchFixture];
}

@end
