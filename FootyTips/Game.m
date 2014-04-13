//
//  Game.m
//  FootyTips
//
//  Created by Michael Koukoullis on 12/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Game.h"

@implementation Game

+ (NSDateFormatter *)dateFormatter
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
  return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{};
}

+ (NSValueTransformer *)dateJSONTransformer
{
  return [MTLValueTransformer transformerWithBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  }];
}

@end
