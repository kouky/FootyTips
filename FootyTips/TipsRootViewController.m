//
//  TipsRootViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsRootViewController.h"
#import "TipsManager.h"
#import "TipsScrollView.h"
#import "FootyFixture.h"

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

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

# pragma mark TipsManagerDelegate protocol methods

- (void)didReceiveFixtureModel:(FootyFixture *)fixture
{
  _footyFixture = fixture;
  _scrollView = [self buildScrollView];
  _tableViews = [self buildTableViews];

  [self.view addSubview:_scrollView];
  [self addTableViewsToScrollView];
}

# pragma mark Private

- (UIScrollView *)buildScrollView
{
  CGRect scrollFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
  NSInteger footyRoundsCount = [[_footyFixture rounds] count];
  CGSize scrollContentSize = CGSizeMake(self.view.frame.size.width * footyRoundsCount, self.view.frame.size.height);
  
  UIScrollView *scrollView = [[TipsScrollView alloc] initWithFrame:scrollFrame];
  scrollView.contentSize = scrollContentSize;
  scrollView.pagingEnabled = YES;

  return scrollView;
}

- (NSMutableArray *)buildTableViews
{
  NSMutableArray *tableViews = [[NSMutableArray alloc] initWithArray:@[]];
  UITableView *tableView;
  NSUInteger index;
  CGRect frame;
  
  for (index = 0; index < [_footyFixture.rounds count]; index++) {
    frame = CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [tableViews addObject:tableView];
  }

  return tableViews;
}

- (void)addTableViewsToScrollView
{
  UITableView *tableView;
  for (tableView in _tableViews) {
    [_scrollView addSubview:tableView];
  }
}

@end
