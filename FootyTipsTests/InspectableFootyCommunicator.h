//
//  InspectableFootyCommunicator.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@interface InspectableFootyCommunicator : FootyCommunicator

- (AFHTTPRequestOperationManager *)requestManager;
- (void)setRequestManager:(AFHTTPRequestOperationManager *)requestManager;

@end
