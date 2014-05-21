//
//  FootyRound.m
//  FootyTips
//
//  Created by Michael Koukoullis on 15/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyRound.h"

@implementation FootyRound

+ (NSDateFormatter *)dateFormatter
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd";
  return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{};
}

+ (NSValueTransformer *)startDateJSONTransformer
{
  return [MTLValueTransformer transformerWithBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  }];
}

+ (NSValueTransformer *)endDateJSONTransformer
{
  return [MTLValueTransformer transformerWithBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  }];
}

+ (NSValueTransformer *)gamesJSONTransformer
{
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:Game.class];
}

# pragma mark Decorators

- (NSString *)title
{
  return [NSString stringWithFormat:@"Round %@", self.id];
}

- (NSString *)shortTitle
{
  return [NSString stringWithFormat:@"Rnd %@", self.id];
}


@end
