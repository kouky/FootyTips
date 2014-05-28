//
//  TipsRootViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsRootViewController.h"
#import "TipsManager.h"
#import "TipsObjectConfiguration.h"
#import "TipsPageViewController.h"
#import "TipsFootyRoundViewController.h"
#import "FootyRound.h"

@interface TipsRootViewController ()

@end

@implementation TipsRootViewController

// Designated initializer
- (id)init
{
  self = [super initWithNibName:nil bundle:nil];
  return self;
}

// Previous designated initializer defers to init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  return [self init];
}

- (void)setManager:(TipsManager *)manager
{
  _manager = manager;
  manager.delegate = self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.manager buildFixture];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(footyRoundDidAppearNotification:)
                                               name:TipsFootyRoundDidAppearNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:TipsFootyRoundDidAppearNotification
                                                object:nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)loadView
{
  self.view = [[UIScrollView alloc] init];
}

# pragma mark TipsManagerDelegate protocol methods

- (void)didReceiveFixtureModel:(FootyFixture *)fixture
{
  _footyFixture = fixture;
  if (!_pageViewController) {
    _pageViewController = [TipsObjectConfiguration tipsPageViewControllerForFootyFixture:_footyFixture];
    [self addChildPageViewControler];
  }
}

# pragma mark NSNotification handlers

- (void)footyRoundDidAppearNotification:(NSNotification *)note
{
  TipsFootyRoundViewController *viewController = (TipsFootyRoundViewController *)note.object;
  [self setTitle:[viewController.footyRound title]];
}

# pragma mark Private

- (void)addChildPageViewControler
{
  // Perform View Controller Containment
  [self addChildViewController:_pageViewController];
  [self.view addSubview:_pageViewController.view];
  [_pageViewController didMoveToParentViewController:self];
}

@end