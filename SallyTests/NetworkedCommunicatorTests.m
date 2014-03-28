//
//  NetworkedCommunicatorTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-03-25.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SallyCommunicator.h"
#import "MockSallyCommunicatorDelegate.h"

#define EXP_SHORTHAND
#import "Expecta.h"

@interface NetworkedCommunicatorTests : XCTestCase
{
    @private
    
    SallyCommunicator *communicator;
    MockSallyCommunicatorDelegate *communicatorDelegate;
}
@end

@implementation NetworkedCommunicatorTests

- (void)setUp
{
    [super setUp];
    
    communicator = [SallyCommunicator sharedSallyCommunicator];
    communicatorDelegate = [[MockSallyCommunicatorDelegate alloc] init];
    
    communicator.delegate = communicatorDelegate;
    
    [Expecta setAsynchronousTestTimeout:5];
}

- (void)tearDown
{
    communicator = nil;
    communicatorDelegate = nil;
    
    [super tearDown];
}

- (void)testSuccessfulSignInPassesTokenToDelegate
{
    [communicator signInWithEmail: @"zaid@tokenize.ca" password: @"xuXv3ZQXoKM3kALV"];
    
    expect(communicatorDelegate.apiToken).will.equal(@"zYNjCaeguEaJk3HqVX9L");
}

- (void)testFailedSignInNotifiesDelegateOfError {
    [communicator signInWithEmail: @"zaid@tokenize.ca" password: @"invalid"];

    expect(communicatorDelegate.error).willNot.beNil;
    expect(communicatorDelegate.apiToken).will.beNil;
}

- (void)testSuccessfulFetchTripsPassesTripsToDelegate
{
    communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
    [communicator fetchTrips];

    expect([communicatorDelegate.trips count]).will.beGreaterThan(0);
}

- (void)testFailedFetchTripsNotifiesDelegateOfError {
    communicator.parameters[@"auth_token"] = @"invalid";
    [communicator fetchTrips];

    expect(communicatorDelegate.error).willNot.beNil;
    expect([communicatorDelegate.trips count]).will.equal(0);
}

@end
