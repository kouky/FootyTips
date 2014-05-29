//
//  SharedSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 29/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Swizzle.h"
#import <UIKit/UIKit.h>
#import "UIViewController+TestSuperClassCalled.h"
#import <objc/runtime.h>

static UIViewController *shared_viewController;

SharedExamplesBegin(SharedMikeExamples)

sharedExamplesFor(@"viewDidAppear calls super class implementation", ^(NSDictionary *data) {

  describe(@"", ^{
    
    before(^{
      shared_viewController = (UIViewController *)data[@"viewController"];
      
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewDidAppearSelector]
                               andSelector:[UIViewController testViewDidAppearSelector]];
    });
    
    it(@"of viewDidAppear", ^{
      [shared_viewController viewDidAppear:NO];
      expect(objc_getAssociatedObject(shared_viewController, viewDidAppearKey)).notTo.beNil();
    });
    
    after(^{
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewDidAppearSelector]
                               andSelector:[UIViewController testViewDidAppearSelector]];
    });
  });
});

SharedExamplesEnd