#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "AppDelegate.h"

static AppDelegate *appDelegate;
static BOOL didFinishLaunchingWithOptionsReturn;


SpecBegin(AppDelegate)

describe(@"AppDelegate", ^{
  
  before(^{
    appDelegate = [[AppDelegate alloc] init];
    didFinishLaunchingWithOptionsReturn = [appDelegate application: nil didFinishLaunchingWithOptions: nil];
  });
  

  it(@"window is key after application launch", ^{
    expect(appDelegate.window.keyWindow).to.equal(@YES);
  });
  
  it(@"didFinishLaunching returns YES", ^{
    expect(didFinishLaunchingWithOptionsReturn).to.equal(@YES);
  });
  
  describe(@"tab bar controller", ^{
    
    it(@"is an instance of UITabBarController", ^{
      expect(appDelegate.tabBarController).to.beInstanceOf([UITabBarController class]);
    });
    
    it(@"is the root view controller", ^{
      expect(appDelegate.window.rootViewController).to.beIdenticalTo(appDelegate.tabBarController);
    });
    
  });
  
});

SpecEnd
