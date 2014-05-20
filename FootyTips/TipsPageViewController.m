//
//  TipsPageViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 5/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsPageViewController.h"
#import "TipsFootyRoundViewController.h"
#import "FootyFixture.h"
#import "TipsObjectConfiguration.h"

@interface TipsPageViewController ()

@end

@implementation TipsPageViewController

// Designated initializer
- (id)init
{
  self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                options:nil];
  return self;
}

// Previous designated initializer defers to init.
- (id)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
{
  return [self init];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

# pragma mark pageViewContollerDataSource protocol methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
  TipsFootyRoundViewController *footyRoundViewController = (TipsFootyRoundViewController *)viewController;
  FootyRound *previousFootyRound = [self.footyFixture footyRoundBefore:footyRoundViewController.footyRound];
  
  if (previousFootyRound) {
    return [TipsObjectConfiguration tipsFootyRoundViewControllerForFootyRound:previousFootyRound];
  } else {
    return nil;
  }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
  TipsFootyRoundViewController *footyRoundViewController = (TipsFootyRoundViewController *)viewController;
  FootyRound *nextFootyRound = [self.footyFixture footyRoundAfter:footyRoundViewController.footyRound];
  
  if (nextFootyRound) {
    return [TipsObjectConfiguration tipsFootyRoundViewControllerForFootyRound:nextFootyRound];
  } else {
    return nil;
  }
}

@end
