//
//  TipsListManagerDelegate.h
//  FootyTips
//
//  Created by Michael Koukoullis on 16/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TipsListManagerDelegate <NSObject>

- (void)buildingFixtureDidFailWithError:(NSError *)error;

@end
