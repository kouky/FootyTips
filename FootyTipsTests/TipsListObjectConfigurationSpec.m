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
#import "TipsManager.h"
#import "FootyCommunicator.h"

static TipsListObjectConfiguration *configuration;

SpecBegin(TipsListObjectConfiguration)

describe(@"TipsListObjectConfiguration", ^{
  
  describe(@"tipsManager class method", ^{
    
    it(@"returns a TipsManager", ^{
      expect([TipsListObjectConfiguration tipsManager]).to.beKindOf(TipsManager.class);
    });
    
    it(@"returns a correctly configured TipsManager", ^{
      TipsManager *manager = [TipsListObjectConfiguration tipsManager];
      expect(manager.communicator).to.beKindOf(FootyCommunicator.class);
      expect(manager.communicator.delegate).to.beIdenticalTo(manager);
    });

  });
});

SpecEnd