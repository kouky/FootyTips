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
#import "TipsListManager.h"
#import <objc/runtime.h>

static TipsListViewController *tipsListViewController;

SpecBegin(TipsListViewController)

describe(@"TipsListViewController", ^{
  
  before(^{
    tipsListViewController = [[TipsListViewController alloc] init];
  });
  
  it(@"conforms to the TipsListManagerDelegate protocol", ^{
    expect(TipsListViewController.class).to.conformTo(@protocol(TipsListManagerDelegate));
  });
  
  it(@"has a manager property", ^{
    objc_property_t managerProperty = class_getProperty(tipsListViewController.class, "manager");
    expect(managerProperty).notTo.equal(NULL);
  });
  
  describe(@"initialisation", ^{

    it(@"configures a plain table view style with using new designated initializer init", ^{
      expect(tipsListViewController.tableView.style).to.equal(UITableViewStylePlain);
    });
    
    it(@"configures a plain table view style when the old desiginated initializer is used", ^{
      TipsListViewController *tips = [[TipsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
      expect(tips.tableView.style).to.equal(UITableViewStylePlain);
    });
    
  });
  
  describe(@"setManager", ^{
    
    it(@"sets the manager property", ^{
      id mockManager = [OCMockObject mockForClass:TipsListManager.class];
      [[mockManager stub] setDelegate:[OCMArg any]];
      tipsListViewController.manager = mockManager;
      expect(tipsListViewController.manager).to.beIdenticalTo(mockManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      id mockManager = [OCMockObject mockForClass:TipsListManager.class];
      [[mockManager expect] setDelegate:tipsListViewController];
      tipsListViewController.manager = mockManager;
      [mockManager verify];
    });
    
  });
  
  after(^{
    tipsListViewController = nil;
  });
  
});

SpecEnd
