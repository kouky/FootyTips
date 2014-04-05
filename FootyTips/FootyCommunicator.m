//
//  FootyCommunicator.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@implementation FootyCommunicator

- (id)init
{
  self = [super init];
  if (self) {
    _manager = [AFHTTPRequestOperationManager manager];
  }
  return self;
}

- (void)fetchFixture
{
  [self fetchContentAtURL:@"http://footytips.kouky.org/fixture.json" successHandler:^(NSString *objectNotation) {
    [self.delegate didReceiveFixture:objectNotation];
  } errorHandler:^(NSError *error) {
    NSError *localError = [NSError errorWithDomain:FootyCommunicatorErrorDomain
                                              code:FootyCommunicatorFixtureError
                                          userInfo:@{NSUnderlyingErrorKey: error}];
    [self.delegate fetchingFixtureDidFailWithError:localError];
  }];
}

- (void)fetchLadder
{
  [self fetchContentAtURL:@"http://footytips.kouky.org/ladder.json" successHandler:^(NSString *objectNotation) {
    [self.delegate didReceiveLadder:objectNotation];
  } errorHandler:^(NSError *error) {
    NSError *localError = [NSError errorWithDomain:FootyCommunicatorErrorDomain
                                              code:FootyCommunicatorLadderError
                                          userInfo:@{NSUnderlyingErrorKey: error}];
    [self.delegate fetchingLadderDidFailWithError:localError];
  }];
}

# pragma mark Private Methods

- (void)fetchContentAtURL:(NSString *)url successHandler:(void (^)(NSString *))successBlock errorHandler:(void (^)(NSError *))errorBlock
{
  _successHandler = [successBlock copy];
  _errorHandler = [errorBlock copy];
  [self launchConnectionForURL:url];
}
   
- (void)launchConnectionForURL:(NSString *)url
{
  [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    _successHandler(responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    _errorHandler(error);
  }];
}

@end

NSString * const FootyCommunicatorErrorDomain = @"org.kouky.footytips.FootyCommunicatorErrorDomain";