//
//  TipsRootViewController.m
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TipsRootViewController.h"
#import "TipsManager.h"

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end