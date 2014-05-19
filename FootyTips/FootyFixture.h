//
//  FootyFixture.h
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "FootyRound.h"

@interface FootyFixture : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy,   readonly) NSNumber *season;
@property (nonatomic, strong, readonly) NSArray  *rounds;

- (FootyRound *)footyRoundBefore:(FootyRound *)footyRound;
@end
