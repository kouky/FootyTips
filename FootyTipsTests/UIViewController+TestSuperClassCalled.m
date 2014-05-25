//
//  UIViewController+TestSuperClassCalled.m
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "UIViewController+TestSuperClassCalled.h"
#import <objc/runtime.h>

@implementation UIViewController (TestSuperClassCalled)

- (void)UIViewControllerTests_viewDidAppear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewDidAppearKey, paramter, OBJC_ASSOCIATION_RETAIN);
}

- (void)UIViewControllerTests_viewWillDisappear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewWillDisappearKey, paramter, OBJC_ASSOCIATION_RETAIN);
}

- (void)UIViewControllerTests_viewWillAppear: (BOOL)animated
{
  NSNumber *parameter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewWillAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

@end

char * const viewDidAppearKey = "UIViewControllerTestsViewDidAppearKey";
char * const viewWillDisappearKey = "UIViewControllerTestsViewWillDisappearKey";
char * const viewWillAppearKey = "UIViewControllerTestsViewWillAppearKey";