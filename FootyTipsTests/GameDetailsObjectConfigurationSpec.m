//
//  GameDetailsObjectConfigurationSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 2/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "GameDetailsObjectConfiguration.h"
#import "GameDetailsViewController.h"
#import "Game.h"

static id mockGameModel;

SpecBegin(GameDetailsObjectConfiguration)

describe(@"GameDetailsObjectConfiguration", ^{
  
  describe(@"gameDetailsViewControllerForGame class method", ^{
    
    before(^{
      mockGameModel = [OCMockObject mockForClass:Game.class];
    });
    
    it(@"returns a game details view controller", ^{
      id viewController = [GameDetailsObjectConfiguration gameDetailsViewControllerForGame:mockGameModel];
      expect(viewController).to.beKindOf(GameDetailsViewController.class);
    });
    
    it(@"returns a game details view controller with the game property set", ^{
      
      GameDetailsViewController *viewController = [GameDetailsObjectConfiguration gameDetailsViewControllerForGame:mockGameModel];
      expect(viewController.game).to.beIdenticalTo(mockGameModel);
    });
    
    after(^{
      mockGameModel = nil;
    });
    
  });
});

SpecEnd
