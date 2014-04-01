//
//  InspectableFootyCommunicator.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@interface InspectableFootyCommunicator : FootyCommunicator

- (AFHTTPRequestOperationManager *)manager;
- (void)setManager:(AFHTTPRequestOperationManager *)manager;

@end
