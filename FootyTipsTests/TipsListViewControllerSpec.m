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
#import <OCMock/OCMock.h>
#import "TipsListViewController.h"
#import "InspectableTipsListViewController.h"
#import "TipsListManager.h"
#import "TipsListObjectConfiguration.h"

static TipsListViewController *tipsListViewController;
static InspectableTipsListViewController *inspectableTipsListViewController;

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
    
    it(@"sets the manager ivar using the TipsListObjectConfiguration class", ^{
      id mockConfiguration = [OCMockObject mockForClass:TipsListObjectConfiguration.class];
      id mockManager = [OCMockObject mockForClass:TipsListManager.class];
      [[[mockConfiguration expect] andReturn:mockManager] tipsListManager];
      inspectableTipsListViewController = [[InspectableTipsListViewController alloc] init];
      [mockConfiguration verify];
      expect(inspectableTipsListViewController.manager).to.beIdenticalTo(mockManager);
    });
    
  });
  
  after(^{
    inspectableTipsListViewController = nil;
    tipsListViewController = nil;
  });
  
});

SpecEnd
