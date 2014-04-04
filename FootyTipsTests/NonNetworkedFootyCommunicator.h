//
//  NonNetworkedFootyCommunicator.h
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@interface NonNetworkedFootyCommunicator : FootyCommunicator

@property (strong) id receivedData;
@property (assign) BOOL fireSuccessHandler;

@end
