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
static NSDateComponents *components;

SpecBegin(FootyFixture)

describe(@"Game", ^{
  
  before(^{
    JSONDictionary = @{
      @"id"       : @140401,
      @"round"    : @4,
      @"venue"    : @"MCG",
      @"homeTeam" : @"Richmond",
      @"awayTeam" : @"Collingwood",
      @"date"     : @"2014-04-11 19:50",
      @"timeZone" : @"AEST"
    };
  });
  
  it(@"is an Mantle model subclass", ^{
    expect([Game class]).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect(Game.class).to.conformTo(@protocol(MTLJSONSerializing));
  });
  
  it(@"should initialize from JSON", ^{
    
    NSError *error = nil;
    game = [MTLJSONAdapter modelOfClass:Game.class fromJSONDictionary:JSONDictionary error:&error];
    
    expect(game).notTo.beNil();
    expect(error).to.beNil();
    
    expect(game.id).to.equal(140401);
    expect(game.round).to.equal(4);
    expect(game.homeTeam).to.equal(@"Richmond");
    expect(game.awayTeam).to.equal(@"Collingwood");
    expect(game.venue).to.equal(@"MCG");
    expect(game.timeZone).to.equal(@"AEST");
    expect(game.date).to.beKindOf(NSDate.class);
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                                       fromDate:game.date];
    expect(dateComponents.hour).to.equal(19);
    expect(dateComponents.minute).to.equal(50);
    expect(dateComponents.year).to.equal(2014);
    expect(dateComponents.month).to.equal(4);
    expect(dateComponents.day).to.equal(11);
  });
  
  after(^{
    JSONDictionary = nil;
    game = nil;
  });
  
});

SpecEnd
