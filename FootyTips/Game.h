//
//  Game.h
//  FootyTips
//
//  Created by Michael Koukoullis on 12/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "Team.h"

@interface Game : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *id;
@property (nonatomic, strong, readonly) Team *homeTeam;
@property (nonatomic, strong, readonly) Team *awayTeam;
@property (nonatomic, copy, readonly) NSString *venue;
@property (nonatomic, copy, readonly) NSDate   *date;
@property (nonatomic, copy, readonly) NSString *timeZone;

@end
