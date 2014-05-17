//
//  TipsFootyRoundViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "InspectableTipsFootyRoundViewController.h"
#import <objc/runtime.h>

static InspectableTipsFootyRoundViewController *viewController;

SpecBegin(TipsFootyRoundViewController)

describe(@"TipsFootyRoundViewController", ^{
  
  before(^{
    [MockModels enumerate];
    viewController = [[InspectableTipsFootyRoundViewController alloc] init];
  });
  
  it(@"init configures a plain table view style", ^{
    expect(viewController.tableView.style).to.equal(UITableViewStylePlain);
  });
  
  it(@"has a footyRound property with a copy attribute", ^{
    objc_property_t footyRoundProperty = class_getProperty(TipsFootyRoundViewController.class, "footyRound");
    expect(footyRoundProperty).notTo.equal(NULL);
    const char *propertyAttrs = property_getAttributes(footyRoundProperty);
    // See Objective-C Runtime Programming Guide
    expect(propertyAttrs).to.equal("T@\"FootyRound\",C,V_footyRound");
  });

  describe(@"table view data source", ^{
    
    before(^{
      [viewController setFootyRound:mockFootyRound];
    });
    
    it(@"number of sections is equal to one", ^{
      NSInteger numberSections = [viewController numberOfSectionsInTableView:nil];
      expect(numberSections).to.equal(1);
    });
    
    it(@"number of rows in first section equals the number of games for the round", ^{
      NSInteger numberRows = [viewController tableView:nil numberOfRowsInSection:0];
      expect(numberRows).to.equal([[mockFootyRound games] count]);
    });

  });
  
  after(^{
    [MockModels clear];
    viewController = nil;
  });

});

SpecEnd
