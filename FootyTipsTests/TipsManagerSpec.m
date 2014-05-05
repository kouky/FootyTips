//
//  TipsManagerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "TipsManager.h"
#import "FootyCommunicator.h"
#import "MockModels.h"

static TipsManager *manager;
static id mockDelegate;
static id mockMTLJSONAdapter;
static NSError *underlyingError;
static NSDictionary *fixtureJSONDictionary;

SpecBegin(TipsManager)

describe(@"TipsManager", ^{
  
  before(^{
    manager = [[TipsManager alloc] init];
    mockDelegate = [OCMockObject mockForProtocol:@protocol(TipsListManagerDelegate)];
    mockMTLJSONAdapter = [OCMockObject mockForClass:MTLJSONAdapter.class];
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    fixtureJSONDictionary = @{@"season": @2014};
    [MockModels enumerate];
  });
  
  it(@"conforms to the FootyCommunicatorDelegate protocol", ^{
    expect(TipsManager.class).to.conformTo(@protocol(FootyCommunicatorDelegate));
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
      BOOL matchesExpectedError = [error.domain isEqual:TipsManagerErrorDomain];
      matchesExpectedError = matchesExpectedError && error.code == TipsManagerCommunicatorError;
      matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:underlyingError];
      return matchesExpectedError;
    }]];
    [manager fetchingFixtureDidFailWithError:underlyingError];
    [mockDelegate verify];
  });
  
  it(@"on succcesul receipt of fixture dictionary a fixture model is passed to the delegate", ^{
    underlyingError = nil;
    [[[mockMTLJSONAdapter stub] andReturn:mockFootyFixture] modelOfClass:FootyFixture.class
                                                      fromJSONDictionary:fixtureJSONDictionary
                                                                   error:[OCMArg setTo:underlyingError]];
    manager.delegate = mockDelegate;
    [[mockDelegate expect] didReceiveFixtureModel:mockFootyFixture];
    [manager didReceiveFixtureDictionary:fixtureJSONDictionary];
    [mockDelegate verify];
  });
  
  it(@"unsuccessful building of fixture model passes an error to the delegate", ^{
    [[[mockMTLJSONAdapter stub] andReturn:nil] modelOfClass:FootyFixture.class
                                         fromJSONDictionary:fixtureJSONDictionary
                                                      error:[OCMArg setTo:underlyingError]];
    manager.delegate = mockDelegate;
    [[mockDelegate expect] buildingFixtureDidFailWithError:[OCMArg checkWithBlock:^BOOL(NSError *error) {
      BOOL matchesExpectedError = [error.domain isEqual:TipsManagerErrorDomain];
      matchesExpectedError = matchesExpectedError && error.code == TipsManagerMantleError;
      matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:underlyingError];
      return matchesExpectedError;
    }]];
    [manager didReceiveFixtureDictionary:fixtureJSONDictionary];
    [mockDelegate verify];
  });
  
  after(^{
    [MockModels clear];
    fixtureJSONDictionary = nil;
    underlyingError = nil;
    mockMTLJSONAdapter = nil;
    mockDelegate = nil;
    manager = nil;
  });
  
});

SpecEnd
