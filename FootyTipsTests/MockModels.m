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
  
  mockFootyFixture = [OCMockObject mockForClass:FootyFixture.class];
  [[[mockFootyFixture stub] andReturn:@[mockFootyRound]] rounds];
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