//
//  SallyCommunicator.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyCommunicator.h"
#import "SallyCommunicatorDelegate.h"

@implementation SallyCommunicator

@synthesize delegate;
@synthesize parameters;

+ (SallyCommunicator *)sharedSallyCommunicator {
    static SallyCommunicator *_sharedSallyCommunicator = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedSallyCommunicator = [[SallyCommunicator alloc] initWithBaseURL: [NSURL URLWithString: @"http://sally-api.dev/api"]];
    });
    
    return _sharedSallyCommunicator;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL: url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions: NSJSONReadingAllowFragments];
        self.parameters = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)signInWithEmail:(NSString *)email password:(NSString *)password {
    NSMutableDictionary *temporaryParams = [[NSMutableDictionary alloc] initWithDictionary: @{@"email": [email copy], @"password": [password copy]}];
    
    [temporaryParams addEntriesFromDictionary: parameters];
    
    [self GET: @"users/sign_in" parameters:temporaryParams success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.delegate sallyCommunicator: self didSignInWithToken: responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate sallyCommunicator: self signInFailedWithError: error];
    }];
    
    temporaryParams = nil;
}

- (void)fetchTrips {
    [self GET: @"trips" parameters: self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.delegate sallyCommunicator: self didFetchTrips: responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate sallyCommunicator: self fetchTripsFailedWithError: error];
    }];
}

- (void)fetchLocationsForTrip:(NSUInteger)tripID {
    NSString  *locationsUrl = [NSString stringWithFormat: @"trips/%lu/locations", (unsigned long)tripID];

    [self GET: locationsUrl parameters: parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.delegate sallyCommunicator: self didFetchLocationsForTrip: responseObject];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate sallyCommunicator: self fetchLocationsForTripFailedWithError: error];
    }];
}

- (void)createTrip:(NSDictionary *)tripAttributes {
    NSMutableDictionary *temporaryParams = [[NSMutableDictionary alloc] initWithDictionary: tripAttributes];
    [temporaryParams addEntriesFromDictionary: self.parameters];
    
    [self POST: @"trips" parameters: temporaryParams success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.delegate sallyCommunicator: self didCreateTrip: responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate sallyCommunicator: self createTripFailedWithError: error];
        
    }];
    
    temporaryParams = nil;
}

- (void)createLocationForTrip:(NSDictionary *)locationAttributes {
    NSString  *locationsUrl = [NSString stringWithFormat: @"trips/%@/locations", locationAttributes[@"trip_id"]];

    NSMutableDictionary *temporaryParams = [[NSMutableDictionary alloc] initWithDictionary: locationAttributes];
    [temporaryParams addEntriesFromDictionary: self.parameters];

    [self POST: locationsUrl parameters: temporaryParams success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.delegate sallyCommunicator: self didCreateLocation: responseObject];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate sallyCommunicator: self createLocationFailedWithError: error];
    }];

    temporaryParams = nil;
}

@end
