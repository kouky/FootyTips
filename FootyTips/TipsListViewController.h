//
//  TipsListViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsListManagerDelegate.h"

@class TipsManager;
@class FootyFixture;

@interface TipsListViewController : UITableViewController <TipsListManagerDelegate> {

@protected
  FootyFixture *_footyFixture;
}

@property (nonatomic, strong) TipsManager *manager;

@end
