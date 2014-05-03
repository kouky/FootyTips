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
  
  describe(@"initialisation", ^{
    
    it(@"with init configures a plain table view style", ^{
      expect(viewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"with initWithStyle always configues a plain table view style", ^{
      GameDetailsViewController *gameVC = [[GameDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(gameVC.tableView.style).to.equal(UITableViewStylePlain);
    });
    
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
