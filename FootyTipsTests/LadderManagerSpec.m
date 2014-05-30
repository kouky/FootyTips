//
//  LadderManagerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "LadderManager.h"
#import "FootyCommunicator.h"
#import "LadderManagerDelegate.h"

static LadderManager *manager;
static id mockDelegate;

SpecBegin(LadderManager)

before(^{
  manager = [[LadderManager alloc] init];
  mockDelegate = [OCMockObject mockForProtocol:@protocol(LadderManagerDelegate)];
});

it(@"conforms to the FootyCommunicatorDelegate protocol", ^{
  expect(LadderManager.class).to.conformTo(@protocol(FootyCommunicatorDelegate));
});

it(@"non conforming object cannot be delegate", ^{
  expect(^{manager.delegate = (id <LadderManagerDelegate>)[NSNull null];}).to.raise(NSInvalidArgumentException);
});

it(@"conforming object can be delegate", ^{
  expect(^{manager.delegate = mockDelegate;}).notTo.raise(NSInvalidArgumentException);
});

it(@"can accept nil as a delegate", ^{
  expect(^{manager.delegate = nil;}).notTo.raise(NSInvalidArgumentException);
});

after(^{
  manager = nil;
});

SpecEnd
