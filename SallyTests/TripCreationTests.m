//
//  TripCreationTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SallyManager.h"
#import "MockSallyManagerDelegate.h"
#import "MockSallyCommunicator.h"
#import "User.h"

@interface TripCreationTests : XCTestCase
{
    @private
    
    SallyManager *manager;
}
@end

@implementation TripCreationTests

- (void)setUp
{
    [super setUp];
    manager = [[SallyManager alloc] init];
}

- (void)tearDown
{
    manager = nil;
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(manager.delegate = (id<SallyManagerDelegate>)[NSNull null],
                    @"NSNull should not be used as a delegate since it does not conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate
{
    id<SallyManagerDelegate> delegate = [[MockSallyManagerDelegate alloc] init];
    
    XCTAssertNoThrow(manager.delegate = delegate, @"Object conforming to the delegate procotol can be used as delegate");
}

- (void)testManagerAcceptsNilAsDelegate
{
    XCTAssertNoThrow(manager.delegate = nil, @"Nil should be an acceptable delegate");
}

- (void)testAskingForTripsMeansRequestingData
{
    MockSallyCommunicator *communicator = [[MockSallyCommunicator alloc] init];
    User *user = [[User alloc] initWithFirstName: @"John" lastName: @"Doe" email: @"jdoe@tokenize.ca"];
    
    manager.user = user;
    manager.communicator = communicator;
    
    [manager fetchTrips];
    
    XCTAssertTrue(communicator.wasAskedToFetchTrips, @"Communicator was asked to fetch user trips ");
    
    communicator = nil;
    user = nil;
}

- (void)testErrorReturnedToDelegateIsDifferentFromErrorReportedByCommunicator
{
    MockSallyManagerDelegate *delegate = [[MockSallyManagerDelegate alloc] init];
    manager.delegate = delegate;
    
    NSError *underlyingError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    [manager fetchingTripsFailedWithError: underlyingError];
    
    XCTAssertFalse(underlyingError == [delegate fetchError], @"A high-level error should be returned to the delegate");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError
{
    MockSallyManagerDelegate *delegate = [[MockSallyManagerDelegate alloc] init];
    manager.delegate = delegate;
    
    NSError *underlyingError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    [manager fetchingTripsFailedWithError: underlyingError];
    
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey],
                          underlyingError,
                          @"The underlying error should be available in userInfo");
}

@end
