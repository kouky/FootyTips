#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "AppDelegate.h"
#import "TipsPageViewController.h"
#import "TipsObjectConfiguration.h"
#import "TipsManager.h"

static AppDelegate *appDelegate;
static BOOL didFinishLaunchingWithOptionsReturn;
static id mockTipsObjectConfiguration;
static id mockTipsManager;
static TipsPageViewController *tipsPageViewController;
static id viewController;

SpecBegin(AppDelegate)

describe(@"AppDelegate", ^{
  
  before(^{
    appDelegate = [[AppDelegate alloc] init];
    didFinishLaunchingWithOptionsReturn = [appDelegate application:nil didFinishLaunchingWithOptions: nil];
  });
  
  it(@"window is key after application launch", ^{
    expect(appDelegate.window.keyWindow).to.equal(@YES);
  });
  
  it(@"didFinishLaunching returns YES", ^{
    expect(didFinishLaunchingWithOptionsReturn).to.equal(@YES);
  });
  
  describe(@"tab bar controller", ^{
    
    it(@"is an instance of UITabBarController", ^{
      expect(appDelegate.tabBarController).to.beInstanceOf(UITabBarController.class);
    });
    
    it(@"is the root view controller", ^{
      expect(appDelegate.window.rootViewController).to.beIdenticalTo(appDelegate.tabBarController);
    });
    
    describe(@"first item", ^{
      
      before(^{
        viewController = appDelegate.tabBarController.viewControllers[0];
      });
      
      it(@"is a navigation controller", ^{
        expect(viewController).to.beKindOf([UINavigationController class]);
      });

      it(@"has it's title set to 'Tips'", ^{
        expect([viewController title]).to.equal(@"Tips");
      });

      it(@"is a navigation controller containing a tips list view controller", ^{
        UINavigationController *navController = viewController;
        expect([navController topViewController]).to.beKindOf([TipsPageViewController class]);
      });
      
      after(^{
        viewController = nil;
      });
      
    });
    
    describe(@"second item", ^{
      
      before(^{
        viewController = appDelegate.tabBarController.viewControllers[1];
      });
      
      it(@"is a navigation controller", ^{
        expect(viewController).to.beKindOf(UINavigationController.class);
      });
      
      it(@"has it's title set to 'Ladder'", ^{
        expect([viewController title]).to.equal(@"Ladder");
      });

      after(^{
          viewController = nil;
      });

    });
  });
  
  after(^{
    appDelegate = nil;
  });

});
  
describe(@"AppDelegate tips page view controller", ^{
  
  before(^{
    appDelegate = [[AppDelegate alloc] init];
    mockTipsObjectConfiguration = [OCMockObject mockForClass:TipsObjectConfiguration.class];
    mockTipsManager = [OCMockObject mockForClass:TipsManager.class];
  });
    
  it(@"has a properly configured manager property", ^{
    [[mockTipsManager stub] setDelegate:[OCMArg any]];
    [[mockTipsManager stub] buildFixture];
    [[[mockTipsObjectConfiguration expect] andReturn:mockTipsManager] tipsManager];
    
    [appDelegate application:nil didFinishLaunchingWithOptions: nil];
    [mockTipsObjectConfiguration verify];
    
    UINavigationController *navController = [appDelegate.tabBarController.viewControllers firstObject];
    tipsPageViewController = (TipsPageViewController *)[navController topViewController];
    expect(tipsPageViewController.manager).to.beIdenticalTo(mockTipsManager);
  });
  
  after(^{
    mockTipsManager = nil;
    mockTipsObjectConfiguration = nil;
    tipsPageViewController = nil;
    appDelegate = nil;
  });
    
});

SpecEnd
