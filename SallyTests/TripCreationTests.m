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

@end
