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

static TipsListManager *manager;

SpecBegin(TipsListManager)

describe(@"TipsListManager", ^{
  
  before(^{
    manager = [[TipsListManager alloc] init];
  });
  
  it(@"conforms to the FootyCommunicator delegate protocol", ^{
    expect(TipsListManager.class).to.conformTo(@protocol(FootyCommunicatorDelegate));
  });
  
  it(@"non conforming object cannot be delegate", ^{
    expect(^{manager.delegate = (id <TipsListManagerDelegate>)[NSNull null];}).to.raise(NSInvalidArgumentException);
  });
  
  it(@"conforming object can be delegate", ^{
    id delegate = [OCMockObject mockForProtocol:@protocol(TipsListManagerDelegate)];
    expect(^{manager.delegate = delegate;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"can accept nil as a delegate", ^{
    expect(^{manager.delegate = nil;}).notTo.raise(NSInvalidArgumentException);
  });
  
  it(@"asking for fixture means requesting data", ^{    
    id mockCommunicator = [OCMockObject mockForClass:FootyCommunicator.class];
    manager.communicator = mockCommunicator;
    [[mockCommunicator expect] fetchFixture];
    [manager fetchFixture];
    [mockCommunicator verify];
  });
  
  after(^{
    manager = nil;
  });
  
});

SpecEnd
