//
//  GameDetailsViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 3/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "GameDetailsViewController.h"
#import "MockModels.h"

static GameDetailsViewController *viewController;

SpecBegin(GameDetailsViewController)

describe(@"GameDetailsViewController", ^{
  
  before(^{
    [MockModels enumerate];
    viewController = [[GameDetailsViewController alloc] init];
    viewController.game = mockGame;
  });
  
  it(@"sets the game title on view will appear", ^{
    [viewController viewWillAppear:NO];
    expect(viewController.title).to.equal(@"HAW vs ESS");
  });
  
  after(^{
    viewController = nil;
    [MockModels clear];
  });
  
});

SpecEnd
