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

static InspectableFootyCommunicator *inspectableCommunicator;
static id manager;

SpecBegin(FootyCommunicator)

describe(@"FootyCommunicator", ^{
  
  before(^{
    inspectableCommunicator = [[InspectableFootyCommunicator alloc] init];
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
  
  after(^{
    inspectableCommunicator = nil;
  });
  
});

SpecEnd
