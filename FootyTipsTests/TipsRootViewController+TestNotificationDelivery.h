//
//  TipsRootViewController+TestNotificationDelivery.h
//  FootyTips
//
//  Created by Michael Koukoullis on 27/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsRootViewController.h"
#import <objc/runtime.h>

@interface TipsRootViewController (TestNotificationDelivery)

+ (SEL)realFootyRoundDidAppearNotificationSelector;
+ (SEL)testFootyRoundDidAppearNotificationSelector;
- (void)tipsRootViewControllerTests_footyRoundDidAppearNotification:(NSNotification *)note;

@end

extern char * const footyRoundDidAppearNotificationKey;