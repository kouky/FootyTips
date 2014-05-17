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
#import "InspectableTipsFootyRoundViewController.h"
#import <objc/runtime.h>

static InspectableTipsFootyRoundViewController *viewController;

SpecBegin(TipsFootyRoundViewController)

describe(@"TipsFootyRoundViewController", ^{
  
  before(^{
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


});

SpecEnd
