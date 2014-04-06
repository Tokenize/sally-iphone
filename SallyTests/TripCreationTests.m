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
#import "Trip.h"

@interface TripCreationTests : XCTestCase
{
    @private
    
    SallyManager *manager;
    MockSallyManagerDelegate *delegate;
    NSError *underlyingError;
    NSArray *tripArray;
}
@end

@implementation TripCreationTests

- (void)setUp
{
    [super setUp];
    
    manager = [[SallyManager alloc] init];
    delegate = [[MockSallyManagerDelegate alloc] init];
    underlyingError = [NSError errorWithDomain: @"Test Domain" code: 0 userInfo: nil];
    Trip *trip = [[Trip alloc] init];
    tripArray = [NSArray arrayWithObject: trip];
    
    manager.delegate = delegate;
}

- (void)tearDown
{
    manager = nil;
    delegate = nil;
    underlyingError = nil;
    tripArray = nil;
    
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(manager.delegate = (id<SallyManagerDelegate>)[NSNull null],
                    @"NSNull should not be used as a delegate since it does not conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate
{
    id<SallyManagerDelegate> mockDelegate = [[MockSallyManagerDelegate alloc] init];
    
    XCTAssertNoThrow(manager.delegate = mockDelegate, @"Object conforming to the delegate procotol can be used as delegate");
    
    mockDelegate = nil;
}

- (void)testManagerAcceptsNilAsDelegate
{
    XCTAssertNoThrow(manager.delegate = nil, @"Nil should be an acceptable delegate");
}

- (void)testAskingForTripsMeansRequestingData
{
    MockSallyCommunicator *communicator = [[MockSallyCommunicator alloc] init];
    User *user = [[User alloc] initWithDictionary:@{@"firstName": @"John", @"lastName": @"Doe", @"email": @"jdoe@tokenize.ca"} error: nil];
    
    manager.user = user;
    manager.communicator = communicator;
    
    [manager fetchTrips];
    
    XCTAssertTrue(communicator.wasAskedToFetchTrips, @"Communicator was asked to fetch user trips ");
    
    communicator = nil;
    user = nil;
}

- (void)testErrorReturnedToDelegateIsDifferentFromErrorReportedByCommunicator
{
    NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    [manager fetchingTripsFailedWithError: communicatorError];
    
    XCTAssertFalse(communicatorError == [delegate fetchError], @"A high-level error should be returned to the delegate");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError
{
    NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    [manager fetchingTripsFailedWithError: communicatorError];
    
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey],
                          communicatorError,
                          @"The underlying error should be available in userInfo");
}

@end
