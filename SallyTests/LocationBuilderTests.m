//
//  LocationBuilderTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationBuilder.h"
#import "Location.h"

@interface LocationBuilderTests : XCTestCase
{
    @private
    
    LocationBuilder *builder;
    Location *location;
}
@end

@implementation LocationBuilderTests

static NSString *locationJSON =
@"{"
@"\"locations\": ["
@"{"
@"\"id\": 2,"
@"\"time\": \"2014-02-17T15:27:44.145Z\","
@"\"latitude\": 43.6425662,"
@"\"longitude\": -79.3870568,"
@"\"direction\": \"S\","
@"\"speed\": 10,"
@"\"trip_id\": 1,"
@"\"created_at\": \"2014-02-17T15:27:47.524Z\","
@"\"updated_at\": \"2014-02-17T15:27:47.524Z\""
@"}"
@"]"
@"}";

- (void)setUp
{
    [super setUp];
    
    builder = [[LocationBuilder alloc] init];
    location = [[builder locationsFromJSON: locationJSON error: NULL] objectAtIndex: 0];
}

- (void)tearDown
{
    builder = nil;
    location = nil;
    
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([builder locationsFromJSON: nil error: NULL], @"Lack of data should be handled elsewhere");
}

- (void)testThatNilIsReturnedWhenParsingInvalidJSON
{
    XCTAssertNil([builder locationsFromJSON: @"Invalid JSON" error: NULL], @"Parsing invalid JSON should return nil");
}

- (void)testThatErrorIsSetWhenParsingInvalidJSON
{
    NSError *error = nil;
    
    [builder locationsFromJSON: @"Invalid JSON" error: &error];
    
    XCTAssertNotNil(error, "The Error should be set when parsing invalid JSON");
    XCTAssertEqual([error code], (NSInteger)LocationBuilderInvalidJSONError, @"An InvalidJSONError should be set when parsing Invalid JSON");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([builder locationsFromJSON: @"Invalid JSON" error: NULL], @"NULL error should not cause a crash");
}

- (void)testRealJSONWithoutLocationsArrayReturnsMissingDataError
{
    NSError *error = nil;
    NSString *jsonString = @"{ \"nolocations\": true }";
    
    [builder locationsFromJSON: jsonString error: &error];
    
    XCTAssertEqual([error code], (NSInteger)LocationBuilderMissingDataError, @"A missing data error should be returned");
}

- (void)testJSONWithOneLocationReturnsOneLocationObject
{
    NSError *error = nil;
    NSArray *locations = [builder locationsFromJSON: locationJSON error: &error];
    
    XCTAssertEqual([locations count], (NSUInteger)1, @"The builder should have created 1 Location");
}

- (void)testLocationCreatedFromJSONHasPropertiesPresentInJSON
{
    XCTAssertEqual(location.locationId, (NSUInteger)2, @"Location ID should match the data we received");
    XCTAssertEqualObjects(location.time, [NSDate dateWithTimeIntervalSince1970: 1392650864.145], @"Location time should match the data we received");
    XCTAssertEqualObjects(location.direction, @"S", @"Location direction should match the data we received");
    XCTAssertEqual(location.speed, (NSInteger)10, @"Location speed should match the data we received");
    XCTAssertEqualObjects(location.latitude, [NSNumber numberWithDouble: 43.6425662], @"Location latitude should match the data we received");
    XCTAssertEqualObjects(location.longitude, [NSNumber numberWithDouble: -79.3870568], @"Location longitude should match the data we received");
}

- (void)testDoesNotCrashOnNullSpeed
{
    NSString *partialJSON =
    @"{\"locations\": [{"
    @"\"id\": 2,"
    @"\"time\": \"2014-02-17T15:27:44.145Z\","
    @"\"latitude\": 43.6425662,"
    @"\"longitude\": -79.3870568,"
    @"\"direction\": \"S\","
    @"\"speed\": null,"
    @"\"trip_id\": 1,"
    @"}]}";
    
    XCTAssertNoThrow([builder locationsFromJSON: partialJSON error: NULL], @"Should not crash when parsing null speed");
}

- (void)testDoesNotCrashOnNullDirection
{
    NSString *partialJSON =
    @"{\"locations\": [{"
    @"\"id\": 2,"
    @"\"time\": \"2014-02-17T15:27:44.145Z\","
    @"\"latitude\": 43.6425662,"
    @"\"longitude\": -79.3870568,"
    @"\"direction\": null,"
    @"\"speed\": 5,"
    @"\"trip_id\": 1,"
    @"}]}";
    
    XCTAssertNoThrow([builder locationsFromJSON: partialJSON error: NULL], @"Should not crash when parsing null direction");
}

@end