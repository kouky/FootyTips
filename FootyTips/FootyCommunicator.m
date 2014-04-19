//
//  FootyCommunicator.m
//  FootyTips
//
//  Created by Michael Koukoullis on 1/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FootyCommunicator.h"

@implementation FootyCommunicator

# pragma mark Public Methods

- (id)init
{
  self = [super init];
  if (self) {
    _requestManager = [AFHTTPRequestOperationManager manager];
  }
  return self;
}

- (void)setDelegate:(id<FootyCommunicatorDelegate>)delegate
{
  if (delegate && ![delegate conformsToProtocol:@protocol(FootyCommunicatorDelegate)]) {
    [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to protocol" userInfo:nil] raise];
  }
  _delegate = delegate;
}

- (void)fetchFixture
{
  [self fetchContentAtURL:@"http://footytips.kouky.org/fixture.json" successHandler:^(id objectNotation) {
    [self.delegate didReceiveFixtureDictionary:objectNotation];
  } errorHandler:^(NSError *error) {
    NSError *localError = [NSError errorWithDomain:FootyCommunicatorErrorDomain
                                              code:FootyCommunicatorFixtureError
                                          userInfo:@{NSUnderlyingErrorKey: error}];
    [self.delegate fetchingFixtureDidFailWithError:localError];
  }];
}

- (void)fetchLadder
{
  [self fetchContentAtURL:@"http://footytips.kouky.org/ladder.json" successHandler:^(id objectNotation) {
    [self.delegate didReceiveLadderDictionary:objectNotation];
  } errorHandler:^(NSError *error) {
    NSError *localError = [NSError errorWithDomain:FootyCommunicatorErrorDomain
                                              code:FootyCommunicatorLadderError
                                          userInfo:@{NSUnderlyingErrorKey: error}];
    [self.delegate fetchingLadderDidFailWithError:localError];
  }];
}

# pragma mark Private Methods

- (void)fetchContentAtURL:(NSString *)URLString successHandler:(void (^)(id))successBlock errorHandler:(void (^)(NSError *))errorBlock
{
  _successHandler = [successBlock copy];
  _errorHandler = [errorBlock copy];
  [self launchConnectionForURL:URLString];
}
   
- (void)launchConnectionForURL:(NSString *)URLString
{
  [_requestManager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    _successHandler(responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    _errorHandler(error);
  }];
}

@end

NSString * const FootyCommunicatorErrorDomain = @"org.kouky.footytips.FootyCommunicatorErrorDomain";
