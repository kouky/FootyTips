//
//  TipsListObjectConfigurationSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 19/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "TipsListObjectConfiguration.h"
#import "TipsListManager.h"
#import "FootyCommunicator.h"

static TipsListObjectConfiguration *configuration;

SpecBegin(TipsListObjectConfiguration)

describe(@"TipsListObjectConfiguration", ^{
  
  describe(@"tipsListManager class method", ^{
    
    it(@"returns a TipsListManager", ^{
      expect([TipsListObjectConfiguration tipsListManager]).to.beKindOf(TipsListManager.class);
    });
    
    it(@"returns a correctly configured TipsListManager", ^{
      TipsListManager *manager = [TipsListObjectConfiguration tipsListManager];
      expect(manager.communicator).to.beKindOf(FootyCommunicator.class);
      expect(manager.communicator.delegate).to.beIdenticalTo(manager);
    });

  });
});

SpecEnd