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

static Team *team;
static NSDictionary *JSONDictionary;

SpecBegin(Team)

describe(@"Team", ^{
  
  before(^{
    JSONDictionary = @{
      @"name"           : @"Richmond",
      @"mascotName"     : @"Tigers",
      @"shortName"      : @"RICH",
      @"ladderPosition" : @8
    };
  });
  
  it(@"is an Mantle model subclass", ^{
    expect(Team.class).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect(Team.class).to.conformTo(@protocol(MTLJSONSerializing));
  });
  
  it(@"should initialize from JSON", ^{
    NSError *error = nil;
    team = [MTLJSONAdapter modelOfClass:Team.class fromJSONDictionary:JSONDictionary error:&error];
    
    expect(team).notTo.beNil();
    expect(error).to.beNil();
    
    expect(team.name).to.equal(@"Richmond");
    expect(team.mascotName).to.equal(@"Tigers");
    expect(team.shortName).to.equal(@"RICH");
    expect(team.ladderPosition).to.equal(8);
  });
  
  after(^{
    JSONDictionary = nil;
    team = nil;
  });
  
});

SpecEnd
