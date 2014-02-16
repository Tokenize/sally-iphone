//
//  TripBuilderTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/15/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TripBuilder.h"
#import "Trip.h"

@interface TripBuilderTests : XCTestCase
{
    @private

    TripBuilder *builder;
    Trip *trip;
}
@end

@implementation TripBuilderTests

static NSString *tripJSON =
@"{"
@"\"trips\": ["
@"{"
@"\"id\": 1,"
@"\"name\": \"Test trip 1\","
@"\"description\": \"A short trip\","
@"\"start_at\": \"2014-02-16T00:14:35.913Z\","
@"\"end_at\": \"2014-02-16T02:14:35.913Z\","
@"\"user_id\": 1,"
@"\"created_at\": \"2014-02-16T00:14:39.762Z\","
@"\"updated_at\": \"2014-02-16T00:14:39.762Z\""
@"}"
@"]"
@"}";

- (void)setUp
{
    [super setUp];
    
    builder = [[TripBuilder alloc] init];
    trip = [[builder tripsFromJSON: tripJSON error: NULL] objectAtIndex: 0];
}

- (void)tearDown
{
    builder = nil;
    trip = nil;
    
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([builder tripsFromJSON: nil error: NULL], @"Lack of data should be handled elsewhere");
}

- (void)testThatNilIsReturnedWhenParsingInvalidJSON
{
    XCTAssertNil([builder tripsFromJSON: @"Invalid JSON" error: NULL], @"Parsing invalid JSON should return nil");
}

- (void)testThatErrorIsSetWhenParsingInvalidJSON
{
    NSError *error = nil;
    
    [builder tripsFromJSON: @"Invalid JSON" error: &error];
    
    XCTAssertNotNil(error, @"The error should be set when parsing invalid JSON");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([builder tripsFromJSON: @"Invalid JSON" error: NULL], @"NULL error should not cause a crash");
}

- (void)testRealJSONWithoutTripsArrayReturnsMissingDataError
{
    NSError *error = nil;
    NSString *jsonString = @"{ \"notrips\": true }";
    
    [builder tripsFromJSON: jsonString error: &error];
    
    XCTAssertEqual([error code], (NSInteger)TripBuilderMissingDataError, @"A missing data error should be returned");
}

- (void)testJSONWithOneTripReturnsOneTripObject
{
    NSError *error = nil;
    NSArray *trips = [builder tripsFromJSON: tripJSON error: &error];
    
    XCTAssertEqual([trips count], (NSUInteger)1, @"The builder should have created 1 Trip");
}

- (void)testTripCreatedFromJSONHasPropertiesPresentedInJSON
{
    XCTAssertEqual(trip.tripId, (NSUInteger)1, @"Trip ID should match the data we received");
    XCTAssertEqualObjects(trip.name, @"Test trip 1", @"Trip name should match the data we received");
    XCTAssertEqualObjects(trip.description, @"A short trip", @"Trip description should match the data we received");
    XCTAssertEqualObjects(trip.startAt, [NSDate dateWithTimeIntervalSince1970: 1392509675.913], @"Trip startAt should match the data we received");
    XCTAssertEqualObjects(trip.endAt, [NSDate dateWithTimeIntervalSince1970: 1392516875.913], @"Trip endAt should match the data we received");
}

- (void)testDoesNotCrashOnNullEndAtDate
{
    NSString *partialJSON =
    @"{\"trips\": [{"
    @"\"id\": 1,"
    @"\"name\": \"Test trip 1\","
    @"\"description\": \"A short trip\","
    @"\"start_at\": \"2014-02-16T00:14:35.913Z\","
    @"\"end_at\": null,"
    @"\"user_id\": 1,"
    @"}]}";
    
    XCTAssertNoThrow([builder tripsFromJSON: partialJSON error: NULL], @"Should not crash when parsing Null end_at date");
}

- (void)testDoesNotCrashOnNullDescription
{
    NSString *partialJSON =
    @"{\"trips\": [{"
    @"\"id\": 1,"
    @"\"name\": \"Test trip 1\","
    @"\"description\": null,"
    @"\"start_at\": \"2014-02-16T00:14:35.913Z\","
    @"\"end_at\": null,"
    @"\"user_id\": 1,"
    @"}]}";

    XCTAssertNoThrow([builder tripsFromJSON: partialJSON error: NULL], @"Should not crash when parsing Null description");
}

@end
