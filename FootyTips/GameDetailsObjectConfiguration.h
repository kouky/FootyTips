//
//  GameDetailsObjectConfiguration.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameDetailsViewController;
@class Game;

@interface GameDetailsObjectConfiguration : NSObject

+ (GameDetailsViewController *)gameDetailsViewControllerForGame:(Game *)game;

@end
