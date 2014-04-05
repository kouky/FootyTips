//
//  FootyCommunicatorDelegate.h
//  FootyTips
//
//  Created by Michael Koukoullis on 4/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FootyCommunicatorDelegate <NSObject>

- (void)didReceiveFixture:(NSString *)fixture;
- (void)didReceiveLadder:(NSString *)ladder;
- (void)fetchingFixtureDidFailWithError:(NSError *)error;
- (void)fetchingLadderDidFailWithError:(NSError *)error;

@end
