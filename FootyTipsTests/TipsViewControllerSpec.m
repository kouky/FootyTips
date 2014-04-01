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
#import "TipsViewController.h"

static TipsViewController *tipsViewController;

SpecBegin(TipsViewController)

describe(@"TipsViewController", ^{
  
  before(^{
    tipsViewController = [[TipsViewController alloc] init];
  });
  
  describe(@"initialisation", ^{

    it(@"with init configures a grouped table view style ", ^{
      expect(tipsViewController.tableView.style).to.equal(UITableViewStyleGrouped);
    });
    
    it(@"with initWithStyle always configures a grouped table view style", ^{
      tipsViewController = [[TipsViewController alloc] initWithStyle:UITableViewStylePlain];
      expect(tipsViewController.tableView.style).to.equal(UITableViewStyleGrouped);
    });

  });
  
});

SpecEnd
