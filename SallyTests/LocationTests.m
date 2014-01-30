//
//  LocationTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/28/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"

@interface LocationTests : XCTestCase
{
    Location *location;
}
@end

@implementation LocationTests

- (void)setUp
{
    [super setUp];
    location = [[Location alloc] init];
}

- (void)tearDown
{
    location = nil;
    [super tearDown];
}

- (void)testThatLocationHasAnIdOfZeroInitially
{
    XCTAssertEqual(location.locationId, (NSUInteger)0, @"Location ID should have a default value of zero");
}

- (void)testThatLocationHasCorrectLocationId
{
    location.locationId = 6;
    
    XCTAssertEqual(location.locationId, (NSUInteger)6, @"Location should have the correct ID");
}

- (void)testThatLocationHasCorrectTime
{
    location.time = [NSDate distantPast];
    XCTAssertEqualObjects(location.time, [NSDate distantPast], @"Location should have the correct time");
}

- (void)testThatLocationHasCorrectLatitude
{
    NSNumber *latitude = [[NSNumber alloc] initWithDouble: 123456789];
    location.latitude = latitude;
    
    XCTAssertEqualObjects(location.latitude, latitude, @"Location should have the correct latitude");
}

- (void)testThatLocationHasCorrectLongitude
{
    NSNumber *longitude = [[NSNumber alloc] initWithDouble: 123456789];
    location.longitude = longitude;
    
    XCTAssertEqualObjects(location.longitude, longitude, @"Location should have the correct longitude");
}

- (void)testThatLocationHasCorrectDirection
{
    location.direction = @"North";
    
    XCTAssertEqualObjects(location.direction, @"North", @"Location should have the correct direction");
}

- (void)testThatLocationHasCorrectSpeed
{
    location.speed = 42;
    
    XCTAssertEqual(location.speed, (NSInteger)42, @"Location should have the correct speed");
}

@end
