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
  
  it(@"is an Mantle model subclass", ^{
    expect([Game class]).to.beSubclassOf([MTLModel class]);
  });
  
  it(@"conforms to the Mantle JSON serializing protocol", ^{
    expect([Game conformsToProtocol:@protocol(MTLJSONSerializing)]).to.beTruthy();
  });
  
  describe(@"serialized from JSON", ^{
    
    before(^{
      JSONDictionary = @{
        @"venue"    : @"MCG",
        @"homeTeam" : @"Richmond",
        @"awayTeam" : @"Collingwood",
        @"date"     : @"2014-04-11 19:50",
        @"timeZone" : @"AEST"
      };
      game = [MTLJSONAdapter modelOfClass:Game.class fromJSONDictionary:JSONDictionary error:nil];
    });
    
    it(@"has a home team property", ^{
      expect(game.homeTeam).to.equal(@"Richmond");
    });
    
    it(@"has an away team property", ^{
      expect(game.awayTeam).to.equal(@"Collingwood");
    });

    it(@"has a venue property", ^{
      expect(game.venue).to.equal(@"MCG");
    });
    
    describe(@"has a date property", ^{
      
      before(^{
        components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                     fromDate:game.date];
      });
      
      it(@"which is an NSDate object", ^{
        expect(game.date).to.beKindOf(NSDate.class);
      });
      
      it(@"with the correct time units", ^{
        expect(components.hour).to.equal(19);
        expect(components.minute).to.equal(50);
      });
      
      it(@"with the correct date units", ^{
        expect(components.year).to.equal(2014);
        expect(components.month).to.equal(4);
        expect(components.day).to.equal(11);
      });
      
      after(^{
        components = nil;
      });
      
    });
    
    it(@"has a time zone property", ^{
      expect(game.timeZone).to.equal(@"AEST");
    });
    
    after(^{
      JSONDictionary = nil;
      game = nil;
    });
    
  });
  
});

SpecEnd
