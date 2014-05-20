//
//  MockModels.m
//  FootyTips
//
//  Created by Michael Koukoullis on 3/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockModels.h"

@implementation MockModels

+ (void)enumerate
{
  mockHomeTeam = [OCMockObject mockForClass:Team.class];
  [[[mockHomeTeam stub] andReturn:@"HAW"] shortName];
  
  mockAwayTeam = [OCMockObject mockForClass:Team.class];
  [[[mockAwayTeam stub] andReturn:@"ESS"] shortName];
  
  mockGame = [OCMockObject mockForClass:Game.class];
  [[[mockGame stub] andReturn:mockHomeTeam] homeTeam];
  [[[mockGame stub] andReturn:mockAwayTeam] awayTeam];
  
  mockFootyRound = [OCMockObject mockForClass:FootyRound.class];
  [[[mockFootyRound stub] andReturn:@3] id];
  [[[mockFootyRound stub] andReturn:@[mockGame]] games];
  [[[mockFootyRound stub] andReturn:mockFootyRound] copyWithZone:[OCMArg anyPointer]];
  
  mockPreviousFootyRound = [OCMockObject mockForClass:FootyRound.class];
  [[[mockPreviousFootyRound stub] andReturn:@2] id];
  [[[mockPreviousFootyRound stub] andReturn:mockPreviousFootyRound] copyWithZone:[OCMArg anyPointer]];

  mockNextFootyRound = [OCMockObject mockForClass:FootyRound.class];
  [[[mockNextFootyRound stub] andReturn:@4] id];
  [[[mockNextFootyRound stub] andReturn:mockNextFootyRound] copyWithZone:[OCMArg anyPointer]];
  
  mockFootyFixture = [OCMockObject mockForClass:FootyFixture.class];
  [[[mockFootyFixture stub] andReturn:@[mockFootyRound]] rounds];
  [[[mockFootyFixture stub] andReturn:mockFootyFixture] copyWithZone:[OCMArg anyPointer]];
}

+ (void)clear
{
  mockHomeTeam = nil;
  mockAwayTeam = nil;
  mockGame = nil;
  mockFootyRound = nil;
  mockFootyFixture = nil;
}

@end
