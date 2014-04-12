//
//  GameSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 12/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Game.h"

SpecBegin(FootyFixture)

describe(@"Game", ^{
  
  it(@"is an Mantle model subclass", ^{
    expect([Game class]).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect([Game conformsToProtocol:@protocol(MTLJSONSerializing)]).to.beTruthy();
  });
  
});

SpecEnd
