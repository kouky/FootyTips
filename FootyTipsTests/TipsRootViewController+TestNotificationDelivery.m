//
//  TipsRootViewController+TestNotificationDelivery.m
//  FootyTips
//
//  Created by Michael Koukoullis on 27/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsRootViewController+TestNotificationDelivery.h"

@implementation TipsRootViewController (TestNotificationDelivery)

#pragma mark footyRoundDidAppearNotification test methods

- (void)tipsRootViewControllerTests_footyRoundDidAppearNotification:(NSNotification *)note
{
  objc_setAssociatedObject(self, footyRoundDidAppearNotificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

+ (SEL)realFootyRoundDidAppearNotificationSelector
{
  return @selector(footyRoundDidAppearNotification:);
}

+ (SEL)testFootyRoundDidAppearNotificationSelector
{
  return @selector(tipsRootViewControllerTests_footyRoundDidAppearNotification:);
}

@end

char * const footyRoundDidAppearNotificationKey = "FootyRoundDidAppearNotificationKey";
