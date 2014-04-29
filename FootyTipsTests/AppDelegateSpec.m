#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "AppDelegate.h"
#import "TipsListViewController.h"
#import "TipsListObjectConfiguration.h"
#import "TipsListManager.h"

static AppDelegate *appDelegate;
static BOOL didFinishLaunchingWithOptionsReturn;
static id mockTipsListObjectConfiguration;
static id mockTipsListManager;
static TipsListViewController *tipsListViewController;

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
      
      it(@"has it's title set to 'Tips'", ^{
        expect([[appDelegate.tabBarController.viewControllers firstObject] title]).to.equal(@"Tips");
      });
      
      it(@"is a navigation controller", ^{
        expect([appDelegate.tabBarController.viewControllers firstObject]).to.beKindOf([UINavigationController class]);
      });
      
      it(@"is a navigation controller containing a tips list view controller", ^{
        UINavigationController *navController = [appDelegate.tabBarController.viewControllers firstObject];
        expect([navController topViewController]).to.beKindOf([TipsListViewController class]);
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
    mockTipsListManager = [OCMockObject mockForClass:TipsListManager.class];
  });
    
  it(@"has a properly configured manager property", ^{
    [[mockTipsListManager stub] setDelegate:[OCMArg any]];
    [[mockTipsListManager stub] buildFixture];
    [[[mockTipsListObjectConfiguration expect] andReturn:mockTipsListManager] tipsListManager];
    
    [appDelegate application:nil didFinishLaunchingWithOptions: nil];
    [mockTipsListObjectConfiguration verify];
    
    UINavigationController *navController = [appDelegate.tabBarController.viewControllers firstObject];
    tipsListViewController = (TipsListViewController *)[navController topViewController];
    expect(tipsListViewController.manager).to.beIdenticalTo(mockTipsListManager);
  });
  
  after(^{
    mockTipsListManager = nil;
    mockTipsListObjectConfiguration = nil;
    tipsListViewController = nil;
    appDelegate = nil;
  });
    
});

SpecEnd
