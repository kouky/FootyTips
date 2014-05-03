//
//  MockModels.h
//  FootyTips
//
//  Created by Michael Koukoullis on 3/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCMock/OCMock.h>
#import "FootyFixture.h"
#import "FootyRound.h"
#import "Game.h"
#import "Team.h"

id mockHomeTeam;
id mockAwayTeam;
id mockGame;
id mockFootyRound;
id mockFootyFixture;

@interface MockModels : NSObject

+ (void)enumerate;
+ (void)clear;

@end
