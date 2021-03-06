//
//  GameDetailsObjectConfiguration.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "GameDetailsObjectConfiguration.h"
#import "GameDetailsViewController.h"

@implementation GameDetailsObjectConfiguration

+ (GameDetailsViewController *)gameDetailsViewControllerForGame:(Game *)game
{
  GameDetailsViewController *viewController = [[GameDetailsViewController alloc] init];
  [viewController setGame:game];
  return viewController;
}

@end
