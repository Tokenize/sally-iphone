//
//  MockSallyCommunicatorDelegate.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-03-25.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "MockSallyCommunicatorDelegate.h"

@implementation MockSallyCommunicatorDelegate

@synthesize apiToken;

- (void)sallyCommunicator:(SallyCommunicator *)communicator didSignInWithToken:(NSString *)token {
    self.apiToken = token;
}

- (void)sallyCommunicator:(SallyCommunicator *)communicator signInFailedWithError:(NSError *)error {
    self.error = error;
}

@end
