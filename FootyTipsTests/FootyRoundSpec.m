//
//  FootyRoundSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "FootyRound.h"

static NSDictionary *JSONDictionary;
static FootyRound *footyRound;

SpecBegin(FootyRound)

describe(@"FootyRound", ^{
  
  it(@"is an Mantle model subclass", ^{
    expect(FootyRound.class).to.beSubclassOf(MTLModel.class);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect(FootyRound.class).to.conformTo(@protocol(MTLJSONSerializing));
  });
  
});

SpecEnd
