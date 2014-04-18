//
//  TipsListManagerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "TipsListManager.h"
#import "FootyCommunicator.h"
#import "FootyFixture.h"

static TipsListManager *manager;
static id mockDelegate;
static id mockMTLJSONAdapter;
static NSError *underlyingError;
static NSDictionary *fixtureJSONDictionary;

SpecBegin(TipsListManager)

describe(@"TipsListManager", ^{
  
  before(^{
    manager = [[TipsListManager alloc] init];
    mockDelegate = [OCMockObject mockForProtocol:@protocol(TipsListManagerDelegate)];
    mockMTLJSONAdapter = [OCMockObject mockForClass:MTLJSONAdapter.class];
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    fixtureJSONDictionary = @{@"season": @2014};
  });
  
  it(@"conforms to the FootyCommunicator delegate protocol", ^{
    expect(TipsListManager.class).to.conformTo(@protocol(FootyCommunicatorDelegate));
  });
  
  it(@"non conforming object cannot be delegate", ^{
    expect(^{manager.delegate = (id <TipsListManagerDelegate>)[NSNull null];}).to.raise(NSInvalidArgumentException);
  });
  
  it(@"conforming object can be delegate", ^{
    expect(^{manager.delegate = mockDelegate;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"can accept nil as a delegate", ^{
    expect(^{manager.delegate = nil;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"asking for fixture means requesting data", ^{    
    id mockCommunicator = [OCMockObject mockForClass:FootyCommunicator.class];
    manager.communicator = mockCommunicator;
    [[mockCommunicator expect] fetchFixture];
    [manager buildFixture];
    [mockCommunicator verify];
  });
  
  it(@"unsuccessful fetching of the fixture passes an error to the delegate", ^{
    manager.delegate = mockDelegate;
    [[mockDelegate expect] buildingFixtureDidFailWithError:[OCMArg checkWithBlock:^BOOL(NSError *error) {
      BOOL matchesExpectedError = [error.domain isEqual:TipsListManagerErrorDomain];
      matchesExpectedError = matchesExpectedError && error.code == TipsListManagerCommunicatorError;
      matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:underlyingError];
      return matchesExpectedError;
    }]];
    [manager fetchingFixtureDidFailWithError:underlyingError];
    [mockDelegate verify];
  });
  
  it(@"on succcesul receipt of fixture dictionary a fixture model is passed to the delegate", ^{
    underlyingError = nil;
    id mockFixtureModel = [OCMockObject mockForClass:FootyFixture.class];
    [[[mockMTLJSONAdapter stub] andReturn:mockFixtureModel] modelOfClass:FootyFixture.class
                                                      fromJSONDictionary:fixtureJSONDictionary
                                                                   error:[OCMArg setTo:underlyingError]];
    manager.delegate = mockDelegate;
    [[mockDelegate expect] didReceiveFixtureModel:mockFixtureModel];
    [manager didReceiveFixture:fixtureJSONDictionary];
    [mockDelegate verify];
  });
  
  it(@"unsuccessful building of fixture model passes an error to the delegate", ^{
    [[[mockMTLJSONAdapter stub] andReturn:nil] modelOfClass:FootyFixture.class
                                         fromJSONDictionary:fixtureJSONDictionary
                                                      error:[OCMArg setTo:underlyingError]];
    manager.delegate = mockDelegate;
    [[mockDelegate expect] buildingFixtureDidFailWithError:[OCMArg checkWithBlock:^BOOL(NSError *error) {
      BOOL matchesExpectedError = [error.domain isEqual:TipsListManagerErrorDomain];
      matchesExpectedError = matchesExpectedError && error.code == TipsListManagerMantleError;
      matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:underlyingError];
      return matchesExpectedError;
    }]];
    [manager didReceiveFixture:fixtureJSONDictionary];
    [mockDelegate verify];
  });
  
  after(^{
    fixtureJSONDictionary = nil;
    underlyingError = nil;
    mockMTLJSONAdapter = nil;
    mockDelegate = nil;
    manager = nil;
  });
  
});

SpecEnd
