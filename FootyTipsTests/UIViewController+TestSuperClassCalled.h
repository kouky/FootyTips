//
//  UIViewController+TestSuperClassCalled.h
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TestSuperClassCalled)

- (void)UIViewControllerTests_viewDidAppear:(BOOL)animated;
- (void)UIViewControllerTests_viewWillDisappear:(BOOL)animated;
- (void)UIViewControllerTests_viewWillAppear: (BOOL)animated;

@end

extern char * const viewDidAppearKey;
extern char * const viewWillDisappearKey;
extern char * const viewWillAppearKey;