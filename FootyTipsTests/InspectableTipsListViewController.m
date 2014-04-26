//
//  InspectableTipsListViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 25/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "InspectableTipsListViewController.h"

@implementation InspectableTipsListViewController

- (FootyFixture *)footyFixture
{
  return  _footyFixture;
}

- (void)setFootyFixture:(FootyFixture *)footyFixture
{
  _footyFixture = footyFixture;
}

@end
