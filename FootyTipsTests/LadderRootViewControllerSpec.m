//
//  LadderRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "LadderRootViewController.h"

static LadderRootViewController *viewController;

SpecBegin(LadderRootViewController)

before(^{
  viewController = [[LadderRootViewController alloc] init];
});

pending(@"conforms to the LadderManagerDelegate protocol");

describe(@"setManager", ^{
  
  pending(@"can accept nil as an argument");
  
  pending(@"sets the manager property");
  
  pending(@"sets the manager delegate to self");
  
});

after(^{
  viewController = nil;
});

SpecEnd
