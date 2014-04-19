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
  
  before(^{
    configuration = [[TipsListObjectConfiguration alloc] init];
  });
  
  it(@"returns a TipsListManager", ^{
    expect([configuration tipsListManager]).to.beKindOf(TipsListManager.class);
  });
  
  it(@"return a correctly configured TipsListManager", ^{
    TipsListManager *manager = [configuration tipsListManager];
    expect(manager.communicator).to.beKindOf(FootyCommunicator.class);
    expect(manager.communicator.delegate).to.beIdenticalTo(manager);
  });
  
  after(^{
    configuration = nil;
  });
  
});

SpecEnd