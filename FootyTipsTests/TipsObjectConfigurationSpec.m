//
//  TipsObjectConfigurationSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 19/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "TipsObjectConfiguration.h"
#import "TipsManager.h"
#import "FootyCommunicator.h"
#import "TipsPageViewController.h"

static TipsObjectConfiguration *configuration;

SpecBegin(TipsObjectConfiguration)

describe(@"TipsObjectConfiguration", ^{
  
  before(^{
    [MockModels enumerate];
  });
  
  describe(@"tipsManager class method", ^{
    
    it(@"returns a TipsManager", ^{
      expect([TipsObjectConfiguration tipsManager]).to.beKindOf(TipsManager.class);
    });
    
    it(@"returns a correctly configured TipsManager", ^{
      TipsManager *manager = [TipsObjectConfiguration tipsManager];
      expect(manager.communicator).to.beKindOf(FootyCommunicator.class);
      expect(manager.communicator.delegate).to.beIdenticalTo(manager);
    });
  });
  
  describe(@"tipsPageViewControllerForFootyFixture class method", ^{
    
    it(@"returns a TipsPageViewController", ^{
      expect([TipsObjectConfiguration tipsPageViewControllerForFootyFixture:mockFootyFixture]).to.beKindOf(TipsPageViewController.class);
    });
    
    it(@"returns a correctly configured TipsPageViewController", ^{
      TipsPageViewController *viewController = [TipsObjectConfiguration tipsPageViewControllerForFootyFixture:mockFootyFixture];
      expect(viewController.footyFixture).to.equal(mockFootyFixture);
    });
  });
  
  after(^{
    [MockModels clear];
  });
  
});

SpecEnd