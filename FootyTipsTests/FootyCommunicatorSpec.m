//
//  FootyCommunicatorSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "InspectableFootyCommunicator.h"
#import "NonNetworkedFootyCommunicator.h"
#import "FootyCommunicatorDelegate.h"

static InspectableFootyCommunicator *inspectableCommunicator;
static NonNetworkedFootyCommunicator *nonNetworkedCommunicator;
static id manager;
static id mockCommunicatorDelegate;
static NSError *networkingError;

SpecBegin(FootyCommunicator)

describe(@"FootyCommunicator", ^{
  
  before(^{
    inspectableCommunicator = [[InspectableFootyCommunicator alloc] init];
    nonNetworkedCommunicator = [[NonNetworkedFootyCommunicator alloc] init];
    mockCommunicatorDelegate = [OCMockObject mockForProtocol:@protocol(FootyCommunicatorDelegate)];
  });

  it(@"non conforming object cannot be delegate", ^{
    expect(^{inspectableCommunicator.delegate = (id <FootyCommunicatorDelegate>)[NSNull null];}).to.raise(NSInvalidArgumentException);
  });
  
  it(@"conforming object can be delegate", ^{
    expect(^{inspectableCommunicator.delegate = mockCommunicatorDelegate;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"can accept nil as a delegate", ^{
    expect(^{inspectableCommunicator.delegate = nil;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"uses a AFNetworking request manager", ^{
    expect(inspectableCommunicator.manager).to.beKindOf([AFHTTPRequestOperationManager class]);
  });
  
  describe(@"calls the json API", ^{
    
    before(^{
      manager = [OCMockObject mockForClass:[AFHTTPRequestOperationManager class]];
      inspectableCommunicator.manager = manager;
    });

    it(@"when fetching the fixture", ^{
      [[manager expect] GET:@"http://footytips.kouky.org/fixture.json" parameters:nil success:[OCMArg any] failure:[OCMArg any]];
      [inspectableCommunicator fetchFixture];
      [manager verify];
    });

    it(@"when fetching the ladder", ^{
      [[manager expect] GET:@"http://footytips.kouky.org/ladder.json" parameters:nil success:[OCMArg any] failure:[OCMArg any]];
      [inspectableCommunicator fetchLadder];
      [manager verify];
    });

  });
  
  describe(@"successful fetch", ^{
    
    before(^{
      nonNetworkedCommunicator.delegate = mockCommunicatorDelegate;
      nonNetworkedCommunicator.fireSuccessHandler = YES;
    });

    it(@"of fixture data is passed to the delegate", ^{
      [nonNetworkedCommunicator setReceivedData:@{ @"season": @2014 }];
      [[mockCommunicatorDelegate expect] didReceiveFixtureDictionary:@{ @"season": @2014 }];
      [nonNetworkedCommunicator fetchFixture];
      [mockCommunicatorDelegate verify];
    });
    
    it(@"of ladder data is passed to the delegate", ^{
      [nonNetworkedCommunicator setReceivedData:@{ @"ladder": @2014 }];
      [[mockCommunicatorDelegate expect] didReceiveLadderDictionary:@{ @"ladder": @2014 }];
      [nonNetworkedCommunicator fetchLadder];
      [mockCommunicatorDelegate verify];
    });
    
  });
  
  describe(@"unsuccessful fetch", ^{
    
    before(^{
      nonNetworkedCommunicator.delegate = mockCommunicatorDelegate;
      nonNetworkedCommunicator.fireErrorHandler = YES;
      networkingError = [NSError errorWithDomain:@"AF Networking Error" code:0 userInfo:nil];
      [nonNetworkedCommunicator setReceivedError:networkingError];
    });
  
    it(@"of fixture data passes an error to the delegate", ^{
      [[mockCommunicatorDelegate expect] fetchingFixtureDidFailWithError:[OCMArg checkWithBlock:^BOOL(id obj) {
        NSError *error = (NSError *)obj;
        BOOL matchesExpectedError = [error.domain isEqual:FootyCommunicatorErrorDomain];
        matchesExpectedError = matchesExpectedError && error.code == FootyCommunicatorFixtureError;
        matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:networkingError];
        return matchesExpectedError;
      }]];
      [nonNetworkedCommunicator fetchFixture];
      [mockCommunicatorDelegate verify];
    });
    
    it(@"of ladder data passes an error to the delegate", ^{
      [[mockCommunicatorDelegate expect] fetchingLadderDidFailWithError:[OCMArg checkWithBlock:^BOOL(id obj) {
        NSError *error = (NSError *)obj;
        BOOL matchesExpectedError = [error.domain isEqual:FootyCommunicatorErrorDomain];
        matchesExpectedError = matchesExpectedError && error.code == FootyCommunicatorLadderError;
        matchesExpectedError = matchesExpectedError && [error.userInfo[NSUnderlyingErrorKey] isEqual:networkingError];
        return matchesExpectedError;
      }]];
      [nonNetworkedCommunicator fetchLadder];
      [mockCommunicatorDelegate verify];
    });
    
  });
  
  after(^{
    networkingError = nil;
    mockCommunicatorDelegate = nil;
    nonNetworkedCommunicator = nil;
    inspectableCommunicator = nil;
  });
  
});

SpecEnd
