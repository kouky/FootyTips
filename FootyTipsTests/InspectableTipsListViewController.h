//
//  InspectableTipsListViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 25/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipsListViewController.h"

@interface InspectableTipsListViewController : TipsListViewController

- (FootyFixture *)footyFixture;
- (void)setFootyFixture:(FootyFixture *)footyFixture;

@end
