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
#import "TipsFootyRoundViewController.h"

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
    
    it(@"throws an error if configured with a nil footy fixture", ^{
      expect(^{[TipsObjectConfiguration tipsPageViewControllerForFootyFixture:nil]; }).to.raise(@"NSInternalInconsistencyException");
    });
  });
  
  describe(@"tipsFootyRoundViewControllerForFootyRound class method", ^{
    
    it(@"returns a TipsFootyRoundViewController", ^{
      expect([TipsObjectConfiguration tipsFootyRoundViewControllerForFootyRound:mockFootyRound]).to.beKindOf(TipsFootyRoundViewController.class);
    });
    
    it(@"returns a correctly configured TipsFootyRoundViewController", ^{
      TipsFootyRoundViewController *viewController = [TipsObjectConfiguration tipsFootyRoundViewControllerForFootyRound:mockFootyRound];
      expect(viewController.footyRound).to.equal(mockFootyRound);
    });
    
    it(@"throws an error if configured with a nil footy fixture", ^{
      expect(^{[TipsObjectConfiguration tipsFootyRoundViewControllerForFootyRound:nil]; }).to.raise(@"NSInternalInconsistencyException");
    });
    
  });
  
  after(^{
    [MockModels clear];
  });
  
});

SpecEnd