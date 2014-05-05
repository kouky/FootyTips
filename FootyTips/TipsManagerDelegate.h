//
//  TipsManagerDelegate.h
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FootyFixture;

@protocol TipsManagerDelegate <NSObject>

- (void)buildingFixtureDidFailWithError:(NSError *)error;
- (void)didReceiveFixtureModel:(FootyFixture *)fixture;

@end
