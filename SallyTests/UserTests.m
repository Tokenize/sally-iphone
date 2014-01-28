//
//  UserTests.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 1/27/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"

@interface UserTests : XCTestCase
{
    User *user;
}
@end

@implementation UserTests

- (void)setUp
{
    [super setUp];
    user = [[User alloc] initWithFirstName: @"Joe" lastName: @"Tester" email: @"joe@example.ca"];
}

- (void)tearDown
{
    user = nil;
    [super tearDown];
}

- (void)testThatUserHasValidFirstName
{
    XCTAssertEqualObjects(user.firstName, @"Joe", @"User should have the correct firstname");
}

- (void)testThatUserHasValidLastName
{
    XCTAssertEqualObjects(user.lastName, @"Tester", @"User should have the correct lastname");
}

- (void)testThatUserHasValidEmail
{
    XCTAssertEqualObjects(user.email, @"joe@example.ca", @"User should have the correct email");
}

@end
