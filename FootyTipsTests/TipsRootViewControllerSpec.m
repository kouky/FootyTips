//
//  TipsRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "TipsRootViewController.h"
#import "TipsManager.h"

static TipsRootViewController *viewController;
static id mockTipsManager;

SpecBegin(TipsRootViewController)

describe(@"TipsRootViewController", ^{
  
  before(^{
    viewController = [[TipsRootViewController alloc] init];
    mockTipsManager = [OCMockObject niceMockForClass:TipsManager.class];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsRootViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      viewController.manager = nil;
      expect(viewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      viewController.manager = mockTipsManager;
      expect(viewController.manager).to.beIdenticalTo(mockTipsManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:viewController];
      viewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  after(^{
    mockTipsManager = nil;
    viewController = nil;
  });
  
});

SpecEnd
