//
//  FootyRound.h
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "Game.h"

@interface FootyRound : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy,   readonly) NSNumber *id;
@property (nonatomic, copy,   readonly) NSDate   *startDate;
@property (nonatomic, copy,   readonly) NSDate   *endDate;
@property (nonatomic, copy,   readonly) NSString *timeZone;
@property (nonatomic, strong, readonly) NSArray  *games;

- (NSString *)title;
- (NSString *)shortTitle;

@end
