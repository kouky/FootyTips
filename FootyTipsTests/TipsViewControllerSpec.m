//
//  TipsViewControllerSpec.m
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

SpecBegin(TipsViewController)

describe(@"TipsViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
  });
  
  describe(@"initialisation", ^{

    it(@"with init configures a grouped table view style ", ^{
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStyleGrouped);
    });
    
    it(@"with initWithStyle always configures a grouped table view style", ^{
      tipsListViewController = [[TipsListViewController alloc] initWithStyle:UITableViewStylePlain];
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStyleGrouped);
    });

  });
  
  after(^{
    tipsListViewController = nil;
  });
  
});

SpecEnd
