//
//  NonNetworkedFootyCommunicator.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "NonNetworkedFootyCommunicator.h"

@implementation NonNetworkedFootyCommunicator

- (void)launchConnectionForURL:(NSString *)url
{
  if (self.fireSuccessHandler) {
    _successHandler(self.receivedData);
  }
}

@end
