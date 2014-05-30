//
//  LadderManager.h
//  FootyTips
//
//  Created by Michael Koukoullis on 30/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FootyCommunicatorDelegate.h"
#import "LadderManagerDelegate.h"

@interface LadderManager : NSObject <FootyCommunicatorDelegate>

@property (nonatomic, weak) id <LadderManagerDelegate> delegate;

@end