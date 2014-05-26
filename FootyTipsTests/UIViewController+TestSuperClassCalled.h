//
//  UIViewController+TestSuperClassCalled.h
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIViewController (TestSuperClassCalled)


- (void) UIViewControllerTests_viewWillAppear:(BOOL)animated;
+ (SEL)  realViewWillAppearSelector;
+ (SEL)  testViewWillAppearSelector;

- (void) UIViewControllerTests_viewDidAppear:(BOOL)animated;
+ (SEL)  realViewDidAppearSelector;
+ (SEL)  testViewDidAppearSelector;

- (void) UIViewControllerTests_viewWillDisappear:(BOOL)animated;
+ (SEL)  realViewWillDisappearSelector;
+ (SEL)  testViewWillDisappearSelector;

@end

extern char * const viewWillAppearKey;
extern char * const viewDidAppearKey;
extern char * const viewWillDisappearKey;