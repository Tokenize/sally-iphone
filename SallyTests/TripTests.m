//
//  TripTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Trip.h"

@interface TripTests : XCTestCase
{
    Trip *trip;
}
@end

@implementation TripTests

- (void)setUp
{
    [super setUp];
    trip = [[Trip alloc] initWithName: @"Morning walk" description: @"A short morning walk"
                              startAt:[NSDate distantPast] endDate:[NSDate distantFuture]];
    
}

- (void)tearDown
{
    trip = nil;
    [super tearDown];
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
    XCTAssertEqualObjects(trip.startAt, [NSDate distantPast], @"Trip should have the correct startAt");
}

- (void)testThatTripHasCorrectEndAt
{
    XCTAssertEqualObjects(trip.endAt, [NSDate distantFuture], @"Trip should have the correct endAt");
}

- (void)testThatTripCannotBeCreatedWithNilName
{
    Trip *newTrip = [[Trip alloc] initWithName: nil description: nil startAt:[NSDate distantPast] endDate: nil];
    
    XCTAssertNil(newTrip, @"Trip requires a non-nil name");
}

- (void)testThatTripCannotBeCreatedWithNilStartAt
{
    Trip *newTrip = [[Trip alloc] initWithName: @"Some trip" description: nil startAt: nil endDate: nil];
    
    XCTAssertNil(newTrip, @"Trip requires a non-nil startAt");
}

- (void)testThatTripCanBeCreatedWithoutDescription
{
    Trip *newTrip = [[Trip alloc] initWithName:@"Test" description:nil startAt:[NSDate distantPast] endDate:[NSDate distantFuture]];
    
    XCTAssertNotNil(newTrip, @"Trip without a description should be valid");
    XCTAssertEqualObjects(newTrip.name, @"Test", @"Trip should have the correct name");
    XCTAssertEqualObjects(newTrip.description, nil, @"Trip should have a nil description");
    XCTAssertEqualObjects(newTrip.startAt, [NSDate distantPast], @"Trip should have the correct startAt");
    XCTAssertEqualObjects(newTrip.endAt, [NSDate distantFuture], @"Trip should have the correct endAt");
    
    newTrip = nil;
}

- (void)testThatTripCanBeCreatedWithoutEndAt
{
    Trip *newTrip = [[Trip alloc] initWithName:@"Test" description: nil startAt:[NSDate distantPast] endDate: nil];
    
    XCTAssertNotNil(newTrip, @"Trip without a description should be valid");
    XCTAssertEqualObjects(newTrip.name, @"Test", @"Trip should have the correct name");
    XCTAssertEqualObjects(newTrip.description, nil, @"Trip should have a nil description");
    XCTAssertEqualObjects(newTrip.startAt, [NSDate distantPast], @"Trip should have the correct startAt");
    XCTAssertEqualObjects(newTrip.endAt, nil, @"Trip should have a nil endAt");
    
    newTrip = nil;
}

@end
