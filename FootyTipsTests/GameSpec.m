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

static NSDictionary *JSONDictionary;
static Game *game;

SpecBegin(FootyFixture)

describe(@"Game", ^{
  
  it(@"is an Mantle model subclass", ^{
    expect([Game class]).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect([Game conformsToProtocol:@protocol(MTLJSONSerializing)]).to.beTruthy();
  });
  
  describe(@"serializing from JSON", ^{
    
    before(^{
      JSONDictionary = @{ @"venue" : @"MCG", @"homeTeam": @"Richmond", @"awayTeam": @"Collingwood" };
      game = [MTLJSONAdapter modelOfClass:Game.class fromJSONDictionary:JSONDictionary error:nil];
    });
    
    it(@"has a home team property", ^{
      expect(game.homeTeam).to.equal(@"Richmond");
    });
    
    it(@"has a away team property", ^{
      expect(game.awayTeam).to.equal(@"Collingwood");
    });

    it(@"has a venue property", ^{
      expect(game.venue).to.equal(@"MCG");
    });
    
    pending(@"has a time and date");

    after(^{
      JSONDictionary = nil;
      game = nil;
    });
    
  });
  
});

SpecEnd
