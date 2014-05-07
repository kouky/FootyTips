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

static InspectableTipsFootyRoundViewController *inspectableViewController;

SpecBegin(TipsFootyRoundViewController)

describe(@"TipsFootyRoundViewController", ^{
  
  before(^{
    inspectableViewController = [[InspectableTipsFootyRoundViewController alloc] init];
  });
  
  it(@"init configures a plain table view style", ^{
    expect(inspectableViewController.tableView.style).to.equal(UITableViewStylePlain);
  });

});

SpecEnd
