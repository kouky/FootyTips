//
//  TipsPageViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 5/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsManagerDelegate.h"

@class TipsManager;
@class FootyFixture;

@interface TipsPageViewController : UIPageViewController <UIPageViewControllerDataSource>

@property (copy) FootyFixture *footyFixture;

@end