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
#import "TipsListManager.h"

static TipsListViewController *tipsListViewController;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
  });
  
  it(@"conforms to the TipsListManagerDelegate protocol", ^{
    expect(TipsListViewController.class).to.conformTo(@protocol(TipsListManagerDelegate));
  });
  
  describe(@"initialisation", ^{

    it(@"configures a plain table view style with using new designated initializer init", ^{
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"configures a plain table view style when the old desiginated initializer is used", ^{
      TipsListViewController *tips = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tips.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"configures the manager property", ^{
      expect(tipsListViewController.manager).notTo.beNil();
      expect(tipsListViewController.manager).to.beKindOf(TipsListManager.class);
    });
    
    it(@"sets the manager delegate to self", ^{
      expect(tipsListViewController.manager.delegate).to.beIdenticalTo(tipsListViewController);
    });

  });
  
  after(^{
    tipsListViewController = nil;
  });
  
});

SpecEnd
