//
//  TipsObjectConfiguration.h
//  FootyTips
//
//  Created by Michael Koukoullis on 19/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TipsManager;
@class TipsPageViewController;
@class TipsFootyRoundViewController;
@class FootyFixture;
@class FootyRound;

@interface TipsObjectConfiguration : NSObject

+ (TipsManager *)tipsManager;
+ (TipsPageViewController *)tipsPageViewControllerForFootyFixture:(FootyFixture *)footyFixture;
+ (TipsFootyRoundViewController *)tipsFootyRoundViewControllerForFootyRound:(FootyRound *)footyRound;

@end
