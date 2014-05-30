//
//  LadderRootViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LadderManagerDelegate.h"

@class LadderManager;

@interface LadderRootViewController : UIViewController <LadderManagerDelegate>

@property (nonatomic, strong) LadderManager *manager;

@end
