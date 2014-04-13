//
//  TeamSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 13/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Team.h"

SpecBegin(Team)

describe(@"Team", ^{
  
  it(@"is an Mantle model subclass", ^{
    expect(Team.class).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect([Team conformsToProtocol:@protocol(MTLJSONSerializing)]).to.beTruthy();
  });

});

SpecEnd
