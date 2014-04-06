//
//  LocationCreationTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SallyManager.h"
#import "MockSallyManagerDelegate.h"
#import "MockSallyCommunicator.h"
#import "Location.h"
#import "Trip.h"

@interface LocationCreationTests : XCTestCase
{
    @private
    
    SallyManager *manager;
    MockSallyManagerDelegate *delegate;
    NSError *underlyingError;
    NSArray *locationsArray;
    Trip *trip;
}
@end

@implementation LocationCreationTests

- (void)setUp
{
    [super setUp];
    
    manager = [[SallyManager alloc] init];
    delegate = [[MockSallyManagerDelegate alloc] init];
    underlyingError = [NSError errorWithDomain: @"Test Domain" code: 0 userInfo: nil];
    Location *location = [[Location alloc] init];
    locationsArray = [NSArray arrayWithObject: location];
    trip = [[Trip alloc] initWithName: @"Test" description: nil startAt: [NSDate date] endDate: nil];
    
    manager.delegate = delegate;

}

- (void)tearDown
{
    manager = nil;
    delegate = nil;
    underlyingError = nil;
    locationsArray = nil;
    trip = nil;
    
    [super tearDown];
}

- (void)testAskingForLocationsMeansRequestingData
{
    MockSallyCommunicator *communicator = [[MockSallyCommunicator alloc] init];
    
    manager.communicator = communicator;
    
    [manager fetchLocationsForTrip: trip.tripId];
    
    XCTAssertTrue(communicator.wasAskedToFetchLocations, @"Communicator was asked to fetch Trip locations");
    
    communicator = nil;
}

- (void)testErrorReturnedToDelegateIsDifferentFromErrorReportedByCommunicator
{
    NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    
    [manager fetchingLocationsForTrip: trip failedWithError: communicatorError];
    
    XCTAssertFalse(communicatorError == [delegate fetchError], @"A high-level error should be returned to the delegate");
    
    communicatorError = nil;
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError
{
    NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
    
    [manager fetchingLocationsForTrip: trip failedWithError: communicatorError];
    
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey],
                          communicatorError,
                          @"The underlying error should be available in userInfo");
    
    communicatorError = nil;
}

@end
