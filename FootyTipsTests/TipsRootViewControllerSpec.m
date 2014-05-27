//
//  TipsRootViewControllerSpec.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockModels.h"
#import "TipsRootViewController.h"
#import "InspectableTipsRootViewController.h"
#import "TipsManager.h"
#import "TipsObjectConfiguration.h"
#import "TipsPageViewController.h"
#import "TipsFootyRoundViewController.h"
#import "Swizzle.h"
#import "UIViewController+TestSuperClassCalled.h"
#import "TipsRootViewController+TestNotificationDelivery.h"

static InspectableTipsRootViewController *viewController;
static id mockTipsManager;
static id mockTipsObjectConfiguration;
static id mockTipsPageViewController;

SpecBegin(TipsRootViewController)

describe(@"TipsRootViewController", ^{
  
  before(^{
    viewController = [[InspectableTipsRootViewController alloc] init];
    mockTipsManager = [OCMockObject niceMockForClass:TipsManager.class];
    mockTipsObjectConfiguration = [OCMockObject mockForClass:TipsObjectConfiguration.class];
    mockTipsPageViewController = [OCMockObject mockForClass:TipsPageViewController.class];
    [MockModels enumerate];
  });
  
  it(@"conforms to the TipsManagerDelegate protocol", ^{
    expect(TipsRootViewController.class).to.conformTo(@protocol(TipsManagerDelegate));
  });
  
  describe(@"setManager", ^{
    
    it(@"can accept nil as an argument", ^{
      viewController.manager = nil;
      expect(viewController.manager).to.beNil();
    });
    
    it(@"sets the manager property", ^{
      viewController.manager = mockTipsManager;
      expect(viewController.manager).to.beIdenticalTo(mockTipsManager);
    });
    
    it(@"sets the manager delegate to self", ^{
      [[mockTipsManager expect] setDelegate:viewController];
      viewController.manager = mockTipsManager;
      [mockTipsManager verify];
    });
    
  });
  
  describe(@"viewDidLoad", ^{

    it(@"requests the building of the footy fixture", ^{
      [[mockTipsManager expect] buildFixture];
      viewController.manager = mockTipsManager;
      [viewController viewDidLoad];
      [mockTipsManager verify];
    });
    
    describe(@"calls super class implementation of", ^{
      
      before(^{
        [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                    selector:[UIViewController realViewDidLoadSelector]
                                 andSelector:[UIViewController testViewDidLoadSelector]];
      });
      
      it(@"viewDidLoad", ^{
        [viewController viewDidLoad];
        expect(objc_getAssociatedObject(viewController, viewDidLoadKey)).notTo.beNil();
      });
      
      after(^{
        [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                    selector:[UIViewController realViewDidLoadSelector]
                                 andSelector:[UIViewController testViewDidLoadSelector]];
      });
      
    });
  });
  
  describe(@"delegate method didReceiveFixtureModel", ^{
    
    it(@"sets the fixture ivar", ^{
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect([viewController footyFixture]).to.beIdenticalTo(mockFootyFixture);
    });
    
    it(@"configures a tips page view controller", ^{
      [[[mockTipsObjectConfiguration expect] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      [mockTipsObjectConfiguration verify];
      expect(viewController.pageViewController).to.beIdenticalTo(mockTipsPageViewController);
    });
    
    it(@"only configures a tips page view controller if it's nil", ^{
      id mock = [OCMockObject mockForClass:TipsPageViewController.class];
      [viewController setPageViewController:mock];
      [[[mockTipsObjectConfiguration stub] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect(viewController.pageViewController).to.beIdenticalTo(mock);
    });
    
    it(@"adds the page view controller as a child view controller", ^{
      [[[mockTipsObjectConfiguration stub] andReturn:mockTipsPageViewController] tipsPageViewControllerForFootyFixture:mockFootyFixture];
      [viewController didReceiveFixtureModel:mockFootyFixture];
      expect(viewController.wasAskedtoAddChildPageViewController).to.beTruthy();
    });
    
  });
  
  it(@"loadView sets a scroll view to fix iOS7 nav bar overlap problem", ^{
    [viewController loadView];
    expect(viewController.view).to.beKindOf(UIScrollView.class);
  });
  
  describe(@"viewDidAppear", ^{

    before(^{
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewDidAppearSelector]
                               andSelector:[UIViewController testViewDidAppearSelector]];
    });
    
    it(@"calls super class implementation of viewDidAppear", ^{
      [viewController viewDidAppear:NO];
      expect(objc_getAssociatedObject(viewController, viewDidAppearKey)).notTo.beNil();
    });
    
    after(^{
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewDidAppearSelector]
                               andSelector:[UIViewController testViewDidAppearSelector]];
    });
  });
  
  describe(@"viewWillDisappear", ^{
    
    before(^{
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewWillDisappearSelector]
                               andSelector:[UIViewController testViewWillDisappearSelector]];
    });
    
    it(@"calls super class implementation of viewWillDisappear", ^{
      [viewController viewWillDisappear:NO];
      expect(objc_getAssociatedObject(viewController, viewWillDisappearKey)).notTo.beNil();
    });
    
    after(^{
      [Swizzle swapInstanceMethodsForClass:UIViewController.class
                                  selector:[UIViewController realViewWillDisappearSelector]
                               andSelector:[UIViewController testViewWillDisappearSelector]];
    });
  });
  
  describe(@"footy round did appear notifications", ^{
    
    before(^{
      [Swizzle swapInstanceMethodsForClass:TipsRootViewController.class
                                  selector:[TipsRootViewController realFootyRoundDidAppearNotificationSelector]
                               andSelector:[TipsRootViewController testFootyRoundDidAppearNotificationSelector]];
      
    });
    
    it(@"are not received by default", ^{
      [[NSNotificationCenter defaultCenter] postNotificationName:TipsFootyRoundDidAppearNotification
                                                          object:nil
                                                        userInfo:nil];
      expect(objc_getAssociatedObject(viewController, footyRoundDidAppearNotificationKey)).to.beNil();
    });
    
    it(@"are received after view did appear", ^{
      [viewController viewDidAppear:NO];
      [[NSNotificationCenter defaultCenter] postNotificationName:TipsFootyRoundDidAppearNotification
                                                          object:nil
                                                        userInfo:nil];
      expect(objc_getAssociatedObject(viewController, footyRoundDidAppearNotificationKey)).notTo.beNil();
    });
    
    it(@"are not received after view will disappear", ^{
      [viewController viewDidAppear:NO];
      [viewController viewWillDisappear:NO];
      [[NSNotificationCenter defaultCenter] postNotificationName:TipsFootyRoundDidAppearNotification
                                                          object:nil
                                                        userInfo:nil];
      expect(objc_getAssociatedObject(viewController, footyRoundDidAppearNotificationKey)).to.beNil();
    });

    after(^{
      [Swizzle swapInstanceMethodsForClass:TipsRootViewController.class
                                  selector:[TipsRootViewController realFootyRoundDidAppearNotificationSelector]
                               andSelector:[TipsRootViewController testFootyRoundDidAppearNotificationSelector]];
    });
    
  });
  
  after(^{
    [MockModels clear];
    mockTipsPageViewController = nil;
    mockTipsObjectConfiguration = nil;
    mockTipsManager = nil;
    viewController = nil;
  });
  
});

SpecEnd
