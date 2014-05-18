//
//  InspectableTipsFootyRoundViewController.h
//  FootyTips
//
//  Created by Michael Koukoullis on 7/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipsFootyRoundViewController.h"

@interface InspectableTipsFootyRoundViewController : TipsFootyRoundViewController {
  id _navigationController;
}

- (id)navigationController;
- (void)setNavigationController:(id)navigationController;

@end
