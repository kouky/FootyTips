//
//  LadderRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "LadderRootViewController.h"
#import "LadderManager.h"
#import "LadderManagerDelegate.h"

static LadderRootViewController *viewController;
static id mockLadderManager;

SpecBegin(LadderRootViewController)

before(^{
  viewController = [[LadderRootViewController alloc] init];
  mockLadderManager = [OCMockObject niceMockForClass:LadderManager.class];
});

it(@"conforms to the LadderManagerDelegate protocol", ^{
  expect(LadderRootViewController.class).to.conformTo(@protocol(LadderManagerDelegate));
});

describe(@"setManager", ^{
  
  it(@"can accept nil as an argument", ^{
    viewController.manager = nil;
    expect(viewController.manager).to.beNil();
  });
  
  it(@"sets the manager property", ^{
    viewController.manager = mockLadderManager;
    expect(viewController.manager).to.beIdenticalTo(mockLadderManager);
  });
  
  it(@"sets the manager delegate to self", ^{
    [[mockLadderManager expect] setDelegate:viewController];
    viewController.manager = mockLadderManager;
    [mockLadderManager verify];
  });
  
});

after(^{
  mockLadderManager = nil;
  viewController = nil;
});

SpecEnd
