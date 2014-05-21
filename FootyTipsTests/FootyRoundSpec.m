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
#import "Game.h"

static NSDictionary *JSONDictionary;
static FootyRound *footyRound;

SpecBegin(FootyRound)

describe(@"FootyRound", ^{
  
  before(^{
    JSONDictionary = @{
      @"id"        : @4,
      @"startDate" : @"2014-04-11",
      @"endDate"   : @"2014-04-13",
      @"timeZone"  : @"AEST",
      @"games"     : @[
        @{
          @"venue"    : @"MCG",
          @"homeTeam" : @{ @"name": @"Richmond" } },
        @{
          @"venue"    : @"Etihad",
          @"homeTeam" : @{ @"name": @"Hawthorn" } }
      ]
    };
  });
  
  it(@"is an Mantle model subclass", ^{
    expect(FootyRound.class).to.beSubclassOf(MTLModel.class);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect(FootyRound.class).to.conformTo(@protocol(MTLJSONSerializing));
  });
  
  it(@"should initialize from JSON", ^{
    NSError *error = nil;
    footyRound = [MTLJSONAdapter modelOfClass:FootyRound.class fromJSONDictionary:JSONDictionary error:&error];
    
    expect(footyRound).notTo.beNil();
    expect(error).to.beNil();
    
    expect(footyRound.id).to.equal(4);
    expect(footyRound.timeZone).to.equal(@"AEST");
    
    expect(footyRound.startDate).to.beKindOf(NSDate.class);
    expect(footyRound.endDate).to.beKindOf(NSDate.class);

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                       fromDate:footyRound.startDate];
    expect(dateComponents.year).to.equal(2014);
    expect(dateComponents.month).to.equal(4);
    expect(dateComponents.day).to.equal(11);
    
    dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                       fromDate:footyRound.endDate];
    expect(dateComponents.year).to.equal(2014);
    expect(dateComponents.month).to.equal(4);
    expect(dateComponents.day).to.equal(13);
    
    expect(footyRound.games).to.beKindOf(NSArray.class);
    
    Game *firstGame = footyRound.games[0];
    expect(firstGame.venue).to.equal(@"MCG");
    
    Team *firstGameHomeTeam = firstGame.homeTeam;
    expect(firstGameHomeTeam.name).to.equal(@"Richmond");
    
    Game *secondGame = footyRound.games[1];
    expect(secondGame.venue).to.equal(@"Etihad");
    
    Team *secondGameHomeTeam = secondGame.homeTeam;
    expect(secondGameHomeTeam.name).to.equal(@"Hawthorn");
    
  });
  
  describe(@"decorators", ^{
    
    before(^{
      footyRound = [MTLJSONAdapter modelOfClass:FootyRound.class fromJSONDictionary:JSONDictionary error:nil];
    });
    
    it(@"title describes the footy round", ^{
      expect(footyRound.title).to.equal(@"Round 4");
    });

    it(@"shortTitle describes the footy round", ^{
      expect(footyRound.shortTitle).to.equal(@"Rnd 4");
    });
    
  });
  
  after(^{
    JSONDictionary = nil;
    footyRound = nil;
  });
  
});

SpecEnd
