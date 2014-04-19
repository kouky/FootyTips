//
//  TipsListViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "TipsListViewController.h"

static TipsListViewController *tipsListViewController;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
  });
  
  describe(@"initialisation", ^{

    it(@"with designated initializer init configures a plain table view style", ^{
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"with old deignated initializer initWithStyle defers to init", ^{
      tipsListViewController = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });

  });
  
  after(^{
    tipsListViewController = nil;
  });
  
});

SpecEnd
