//
//  FootyFixture.m
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyFixture.h"

@implementation FootyFixture

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{};
}

+ (NSValueTransformer *)roundsJSONTransformer
{
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FootyRound.class];
}

# pragma mark Finders

- (FootyRound *)footyRoundBefore:(FootyRound *)footyRound
{
  NSInteger previousFootyRoundIndex = [footyRound.id integerValue] - 2;
  if (previousFootyRoundIndex < 0) {
    return nil;
  } else {
    return [[self rounds] objectAtIndex:previousFootyRoundIndex];
  }
}

- (FootyRound *)footyRoundAfter:(FootyRound *)footyRound
{
  NSInteger nextFootyRoundIndex = [footyRound.id integerValue];
  if (nextFootyRoundIndex >= [self.rounds count]) {
    return nil;
  } else {
    return [[self rounds] objectAtIndex:nextFootyRoundIndex];
  }
}

@end
