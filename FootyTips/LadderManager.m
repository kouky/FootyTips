//
//  LadderManager.m
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "LadderManager.h"

@implementation LadderManager

- (void)setDelegate:(id<LadderManagerDelegate>)delegate
{
  if (delegate && ![delegate conformsToProtocol:@protocol(LadderManagerDelegate)]) {
    [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to protocol" userInfo:nil] raise];
  }
  _delegate = delegate;
}

@end