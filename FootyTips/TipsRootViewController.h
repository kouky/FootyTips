//
//  TipsRootViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 8/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsManagerDelegate.h"

@class TipsManager;

@interface TipsRootViewController : UIViewController <TipsManagerDelegate> {

@protected
  FootyFixture *_footyFixture;
}

@property (nonatomic, strong) TipsManager *manager;

@end
