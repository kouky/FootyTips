//
//  TipsFootyRoundViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FootyRound;

@interface TipsFootyRoundViewController : UITableViewController

@property (copy) FootyRound *footyRound;

@end

extern NSString * const TipsFootyRoundDidAppearNotification;