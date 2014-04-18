//
//  TipsListManager.m
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsListManager.h"
#import "FootyCommunicator.h"
#import "FootyFixture.h"

@implementation TipsListManager

- (void)setDelegate:(id<TipsListManagerDelegate>)delegate
{
  if (delegate && ![delegate conformsToProtocol:@protocol(TipsListManagerDelegate)]) {
    [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to protocol" userInfo:nil] raise];
  }
  _delegate = delegate;
}

# pragma mark Public Methods

- (void)buildFixture
{
  [self.communicator fetchFixture];
}

#pragma mark FootyCommunicatorDelegate protocol methods

- (void)didReceiveFixture:(id)fixture
{
  FootyFixture *fixtureModel =  [MTLJSONAdapter modelOfClass:FootyFixture.class fromJSONDictionary:fixture error:nil];
  [self.delegate didReceiveFixtureModel:fixtureModel];
  
}

- (void)fetchingFixtureDidFailWithError:(NSError *)error
{
  NSError *localError = [NSError errorWithDomain:TipsListManagerErrorDomain
                                            code:TipsListManagerCommunicatorError
                                        userInfo:@{NSUnderlyingErrorKey: error}];

  [self.delegate buildingFixtureDidFailWithError:localError];
}

@end

NSString * const TipsListManagerErrorDomain = @"org.kouky.footytips.TipsListManagerErrorDomain";
