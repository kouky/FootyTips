//
//  TipsRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "TipsRootViewController.h"

SpecBegin(TipsRootViewController)

describe(@"TipsRootViewController", ^{
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsRootViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
});

SpecEnd
