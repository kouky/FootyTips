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
#import "GameDetailsObjectConfiguration.h"
#import "GameDetailsViewController.h"
#import "MockModels.h"

SpecBegin(GameDetailsObjectConfiguration)

describe(@"GameDetailsObjectConfiguration", ^{
  
  describe(@"gameDetailsViewControllerForGame class method", ^{
    
    before(^{
      [MockModels enumerate];
    });
    
    it(@"returns a game details view controller", ^{
      id viewController = [GameDetailsObjectConfiguration gameDetailsViewControllerForGame:mockGame];
      expect(viewController).to.beKindOf(GameDetailsViewController.class);
    });
    
    it(@"returns a game details view controller with the game property set", ^{
      
      GameDetailsViewController *viewController = [GameDetailsObjectConfiguration gameDetailsViewControllerForGame:mockGame];
      expect(viewController.game).to.beIdenticalTo(mockGame);
    });
    
    after(^{
      [MockModels clear];
    });
    
  });
});

SpecEnd
