//
//  Footyommunicator.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FootyCommunicatorDelegate.h"

@interface FootyCommunicator : NSObject {

@protected
  AFHTTPRequestOperationManager *_manager;
  void (^_successHandler)(NSString *);
}

@property (weak) id <FootyCommunicatorDelegate> delegate;

- (void)fetchFixture;
- (void)fetchLadder;

@end
