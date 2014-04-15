//
//  RoundSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Round.h"

SpecBegin(Round)

describe(@"Round", ^{
  
  it(@"is an Mantle model subclass", ^{
    expect(Round.class).to.beSubclassOf(MTLModel.class);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect(Round.class).to.conformTo(@protocol(MTLJSONSerializing));
  });
  
});

SpecEnd
