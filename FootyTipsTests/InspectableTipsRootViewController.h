//
//  InspectableTipsRootViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipsRootViewController.h"

@interface InspectableTipsRootViewController : TipsRootViewController

- (FootyFixture *)footyFixture;
- (TipsPageViewController *)pageViewController;
- (void)setPageViewController:(TipsPageViewController *)pageViewController;
- (BOOL)wasAskedtoAddChildPageViewController;

@end
