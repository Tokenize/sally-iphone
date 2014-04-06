//
//  LocationWorkflowSpec.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/17/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyManager.h"
#import "MockSallyManagerDelegate.h"
#import "MockSallyCommunicator.h"
#import "Location.h"
#import "Trip.h"

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(LocationWorkflowSpec)

describe(@"LocationWorkflowSpec", ^{
    __block SallyManager *manager;
    __block MockSallyManagerDelegate *delegate;
    __block NSError *underlyingError;
    __block NSArray *locationsArray;
    __block Trip *trip;

    beforeEach(^{
        manager = [[SallyManager alloc] init];
        delegate = [[MockSallyManagerDelegate alloc] init];
        underlyingError = [NSError errorWithDomain: @"Test Domain" code: 0 userInfo: nil];
        Location *location = [[Location alloc] init];
        locationsArray = [NSArray arrayWithObject: location];
        trip = [[Trip alloc] initWithDictionary: @{@"tripId": @1, @"name": @"Test", @"startAt": [NSDate date]} error: nil];

        manager.delegate = delegate;
    });

    afterEach(^{
        manager = nil;
        delegate = nil;
        underlyingError = nil;
        locationsArray = nil;
        trip = nil;
    });

    describe(@"fetch locations for trip", ^{
        it(@"should ask communicator to fetch data", ^{
            MockSallyCommunicator *communicator = [[MockSallyCommunicator alloc] init];
            manager.communicator = communicator;

            [manager fetchLocationsForTrip: trip.tripId];

            expect(communicator.wasAskedToFetchLocations).to.beTruthy();

            communicator = nil;
        });

        context(@"failure", ^{
            it(@"should return a higher-level error to delegate", ^{
                NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];

                [manager fetchingLocationsForTrip: trip failedWithError: communicatorError];

                expect(communicatorError).toNot.equal([delegate fetchError]);

                communicatorError = nil;
            });

            it(@"should include underlying error", ^{
                NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];

                [manager fetchingLocationsForTrip: trip failedWithError: communicatorError];

                expect([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey]).to.equal(communicatorError);

                communicatorError = nil;
            });
        });
    });
});

SpecEnd