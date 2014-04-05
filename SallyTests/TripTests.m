//
//  TripTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Trip.h"
#import "Location.h"

@interface TripTests : XCTestCase
{
    Trip *trip;
}
@end

@implementation TripTests

- (void)setUp
{
    [super setUp];
    trip = [[Trip alloc] initWithDictionary: @{@"name": @"Morning walk", @"description": @"A short morning walk",
                                               @"startAt": [[NSDate distantPast] description], @"endAt": [[NSDate distantFuture] description]} error: nil];
}

- (void)tearDown
{
    trip = nil;
    [super tearDown];
}

- (void)testThatTripHasAnIdOfZeroInitially
{
    XCTAssertEqual(trip.tripId, (NSUInteger)0, @"Trip ID should have a default value of zero");
}

- (void)testThatTripHasCorrectId
{
    trip.tripId = 5;
    
    XCTAssertEqual(trip.tripId, (NSUInteger)5, @"Trip should have the correct ID");
}

- (void)testThatTripHasCorrectName
{
    XCTAssertEqualObjects(trip.name, @"Morning walk", @"Trip should have the correct name");
}

- (void)testThatTripHasCorrectDescription
{
    XCTAssertEqualObjects(trip.description, @"A short morning walk", @"Trip should have the correct description");
}

- (void)testThatTripHasCorrectStartAt
{
    XCTAssertEqualObjects([trip.startAt description], [[NSDate distantPast] description], @"Trip should have the correct startAt");
}

- (void)testThatTripHasCorrectEndAt
{
    XCTAssertEqualObjects([trip.endAt description], [[NSDate distantFuture] description], @"Trip should have the correct endAt");
}

- (void)testThatTripIsInvalidWithNilName
{
    Trip *newTrip = [[Trip alloc] initWithDictionary: @{@"startAt": [[NSDate distantPast] description]} error: nil];

    XCTAssertFalse([newTrip validate: nil], @"Trip requires a non-nil name");
}

- (void)testThatTripIsInvalidWithNilStartAt
{
    Trip *newTrip = [[Trip alloc] initWithDictionary: @{@"name": @"Some trip"} error: nil];

    XCTAssertFalse([newTrip validate: nil], @"Trip requires a non-nil startAt");
}

- (void)testThatTripIsValidWithoutDescription
{
    Trip *newTrip = [[Trip alloc] initWithDictionary: @{@"name": @"Test", @"startAt": [[NSDate distantPast] description], @"endAt": [[NSDate distantFuture] description]} error: nil];
    
    XCTAssertTrue([newTrip validate: nil], @"Trip without a description should be valid");
    XCTAssertEqualObjects(newTrip.name, @"Test", @"Trip should have the correct name");
    XCTAssertEqualObjects(newTrip.description, nil, @"Trip should have a nil description");
    XCTAssertEqualObjects([newTrip.startAt description], [[NSDate distantPast] description], @"Trip should have the correct startAt");
    XCTAssertEqualObjects([newTrip.endAt description], [[NSDate distantFuture] description], @"Trip should have the correct endAt");
    
    newTrip = nil;
}

- (void)testThatTripIsValidWithoutEndAt
{
    Trip *newTrip = [[Trip alloc] initWithDictionary: @{@"name": @"Test", @"startAt": [[NSDate distantPast] description]} error: nil];
    
    XCTAssertTrue([newTrip validate: nil], @"Trip without a description should be valid");
    XCTAssertEqualObjects(newTrip.name, @"Test", @"Trip should have the correct name");
    XCTAssertEqualObjects(newTrip.description, nil, @"Trip should have a nil description");
    XCTAssertEqualObjects([newTrip.startAt description], [[NSDate distantPast] description], @"Trip should have the correct startAt");
    XCTAssertEqualObjects(newTrip.endAt, nil, @"Trip should have a nil endAt");
    
    newTrip = nil;
}

- (void)testThatTripHasNoLocationsInitially
{
    XCTAssertEqual([[trip locations] count], (NSUInteger)0, @"Trip has no locations initially.");
}

- (void)testThatTripCanHaveLocationsAdded
{
    Location *newLocation = [[Location alloc] init];
    
    XCTAssertNoThrow([trip addLocation: newLocation], @"Must be able to add locations to Trip");
}

- (void)testThatTripReturnsLocationsInTheOrderAdded
{
    Location *newLocation1 = [[Location alloc] init];
    Location *newLocation2 = [[Location alloc] init];
    Location *newLocation3 = [[Location alloc] init];
    
    newLocation1.time = [NSDate distantPast];
    newLocation2.time = [NSDate distantFuture];
    newLocation3.direction = @"South";
    
    [trip addLocation: newLocation1];
    [trip addLocation: newLocation2];
    [trip addLocation: newLocation3];
    
    NSArray *locations = trip.locations;
    
    XCTAssertEqual([locations firstObject], newLocation1, @"The first location should be returned first");
    XCTAssertEqual([locations objectAtIndex: 1], newLocation2, @"The second location should be returned second");
    XCTAssertEqual([locations lastObject], newLocation3, @"The third location should be returned last");
    
    newLocation1 = nil;
    newLocation2 = nil;
    newLocation3 = nil;
    
    locations = nil;
}

@end
