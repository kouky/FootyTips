//
//  UIViewController+TestSuperClassCalled.m
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "UIViewController+TestSuperClassCalled.h"

@implementation UIViewController (TestSuperClassCalled)

# pragma mark viewWillAppear test methods

- (void)UIViewControllerTests_viewWillAppear:(BOOL)animated
{
  NSNumber *parameter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewWillAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

+ (SEL)realViewWillAppearSelector
{
  return @selector(viewWillAppear:);
}

+ (SEL)testViewWillAppearSelector
{
  return @selector(UIViewControllerTests_viewWillAppear:);
}

#pragma mark viewDidAppear test methods

- (void)UIViewControllerTests_viewDidAppear:(BOOL)animated
{
  NSNumber *parameter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewDidAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

+ (SEL)realViewDidAppearSelector
{
  return @selector(viewDidAppear:);
}

+ (SEL)testViewDidAppearSelector
{
  return @selector(UIViewControllerTests_viewDidAppear:);
}

#pragma mark viewWillDisappear test methods

- (void)UIViewControllerTests_viewWillDisappear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewWillDisappearKey, paramter, OBJC_ASSOCIATION_RETAIN);
}

+ (SEL)realViewWillDisappearSelector
{
  return @selector(viewWillDisappear:);
}

+ (SEL)testViewWillDisappearSelector
{
  return @selector(UIViewControllerTests_viewWillDisappear:);
}

@end

char * const viewDidLoadKey = "UIViewControllerTestsViewDidLoadKey";
char * const viewWillAppearKey = "UIViewControllerTestsViewWillAppearKey";
char * const viewDidAppearKey = "UIViewControllerTestsViewDidAppearKey";
char * const viewWillDisappearKey = "UIViewControllerTestsViewWillDisappearKey";