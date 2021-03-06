//
//  TipsManager.h
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipsManagerDelegate.h"
#import "FootyCommunicatorDelegate.h"

@class FootyCommunicator;

@interface TipsManager : NSObject <FootyCommunicatorDelegate>

@property (nonatomic, weak) id <TipsManagerDelegate> delegate;
@property (strong) FootyCommunicator *communicator;

- (void)buildFixture;

@end

extern NSString * const TipsManagerErrorDomain;

enum {
  TipsManagerCommunicatorError,
  TipsManagerMantleError
};