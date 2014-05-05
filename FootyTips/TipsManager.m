//
//  TipsManager.m
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsManager.h"
#import "FootyCommunicator.h"
#import "FootyFixture.h"

@implementation TipsManager

- (void)setDelegate:(id<TipsManagerDelegate>)delegate
{
  if (delegate && ![delegate conformsToProtocol:@protocol(TipsManagerDelegate)]) {
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

- (void)didReceiveFixtureDictionary:(id)fixture
{
  NSError *error = nil;
  FootyFixture *fixtureModel =  [MTLJSONAdapter modelOfClass:FootyFixture.class fromJSONDictionary:fixture error:&error];
  if (error) {
    NSError *localError = [NSError errorWithDomain:TipsManagerErrorDomain
                                              code:TipsManagerMantleError
                                          userInfo:@{NSUnderlyingErrorKey:error}];
    [self.delegate buildingFixtureDidFailWithError:localError];
  }
  else {
    [self.delegate didReceiveFixtureModel:fixtureModel];
  }
}

- (void)fetchingFixtureDidFailWithError:(NSError *)error
{
  NSError *localError = [NSError errorWithDomain:TipsManagerErrorDomain
                                            code:TipsManagerCommunicatorError
                                        userInfo:@{NSUnderlyingErrorKey:error}];

  [self.delegate buildingFixtureDidFailWithError:localError];
}

@end

NSString * const TipsManagerErrorDomain = @"org.kouky.footytips.TipsManagerErrorDomain";
