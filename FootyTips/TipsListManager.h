//
//  TipsListManager.h
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipsListManagerDelegate.h"
#import "FootyCommunicatorDelegate.h"

@class FootyCommunicator;

@interface TipsListManager : NSObject <FootyCommunicatorDelegate>

@property (nonatomic, weak) id <TipsListManagerDelegate> delegate;
@property (strong) FootyCommunicator *communicator;

- (void)buildFixture;

@end

extern NSString * const TipsListManagerErrorDomain;

enum {
  TipsListManagerCommunicatorError,
  TipsListManagerMantleError
};