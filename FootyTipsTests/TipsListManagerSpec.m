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

SpecBegin(TipsListManager)

describe(@"TipsListManager", ^{
  
  before(^{
    manager = [[TipsListManager alloc] init];
    mockDelegate = [OCMockObject mockForProtocol:@protocol(TipsListManagerDelegate)];
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
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [[mockDelegate expect] buildingFixtureDidFailWithError:[OCMArg checkWithBlock:^BOOL(id obj) {
      NSError *error = (NSError *)obj;
      BOOL matchesExpectedError = [error.domain isEqual:TipsListManagerErrorDomain];
      matchesExpectedError = matchesExpectedError && error.code == TipsListManagerCommunicatorError;
      matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:underlyingError];
      return matchesExpectedError;
    }]];
    [manager fetchingFixtureDidFailWithError:underlyingError];
    [mockDelegate verify];
  });
  
  it(@"on succcesul receipt of fixture dictionary a fixture model is passed to the delegate", ^{
    NSDictionary *fixtureJSONDictionary = @{@"season": @2014};
    id mockFixtureModel = [OCMockObject mockForClass:FootyFixture.class];
    id mockMTLJSONAdapter = [OCMockObject mockForClass:MTLJSONAdapter.class];
    [[[mockMTLJSONAdapter stub] andReturn:mockFixtureModel] modelOfClass:FootyFixture.class
                                                      fromJSONDictionary:fixtureJSONDictionary
                                                                   error:nil];
    manager.delegate = mockDelegate;
    [[mockDelegate expect] didReceiveFixtureModel:mockFixtureModel];
    [manager didReceiveFixture:fixtureJSONDictionary];
    [mockDelegate verify];
  });
  
  after(^{
    mockDelegate = nil;
    manager = nil;
  });
  
});

SpecEnd
