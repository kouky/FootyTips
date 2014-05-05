#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "AppDelegate.h"
#import "TipsListViewController.h"
#import "TipsListObjectConfiguration.h"
#import "TipsManager.h"

static AppDelegate *appDelegate;
static BOOL didFinishLaunchingWithOptionsReturn;
static id mockTipsListObjectConfiguration;
static id mockTipsManager;
static TipsListViewController *tipsListViewController;
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
        expect([navController topViewController]).to.beKindOf([TipsListViewController class]);
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
  
describe(@"AppDelegate tips list view controller", ^{
  
  before(^{
    appDelegate = [[AppDelegate alloc] init];
    mockTipsListObjectConfiguration = [OCMockObject mockForClass:TipsListObjectConfiguration.class];
    mockTipsManager = [OCMockObject mockForClass:TipsManager.class];
  });
    
  it(@"has a properly configured manager property", ^{
    [[mockTipsManager stub] setDelegate:[OCMArg any]];
    [[mockTipsManager stub] buildFixture];
    [[[mockTipsListObjectConfiguration expect] andReturn:mockTipsManager] tipsManager];
    
    [appDelegate application:nil didFinishLaunchingWithOptions: nil];
    [mockTipsListObjectConfiguration verify];
    
    UINavigationController *navController = [appDelegate.tabBarController.viewControllers firstObject];
    tipsListViewController = (TipsListViewController *)[navController topViewController];
    expect(tipsListViewController.manager).to.beIdenticalTo(mockTipsManager);
  });
  
  after(^{
    mockTipsManager = nil;
    mockTipsListObjectConfiguration = nil;
    tipsListViewController = nil;
    appDelegate = nil;
  });
    
});

SpecEnd
