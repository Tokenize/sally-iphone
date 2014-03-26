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
        _sharedSallyCommunicator = [[SallyCommunicator alloc] initWithBaseURL: [NSURL URLWithString: @"https://sally-api.tokenize.ca/api"]];
    });
    
    return _sharedSallyCommunicator;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL: url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
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

@end
