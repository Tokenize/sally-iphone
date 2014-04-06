//
//  TripWorkflowSpec.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyManager.h"
#import "MockSallyManagerDelegate.h"
#import "MockSallyCommunicator.h"
#import "User.h"
#import "Trip.h"

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(TripWorkflowSpec)

describe(@"TripWorkflowSpec", ^{

    __block SallyManager *manager;
    __block MockSallyManagerDelegate *delegate;
    __block NSError *underlyingError;
    __block NSArray *tripArray;

    beforeEach(^{
        manager = [[SallyManager alloc] init];
        delegate = [[MockSallyManagerDelegate alloc] init];
        underlyingError = [NSError errorWithDomain: @"Test Domain" code: 0 userInfo: nil];
        Trip *trip = [[Trip alloc] init];
        tripArray = [NSArray arrayWithObject: trip];

        manager.delegate = delegate;
    });

    afterEach(^{
        manager = nil;
        delegate = nil;
        underlyingError = nil;
        tripArray = nil;
    });

    describe(@"manager's delegate", ^{
        it(@"should not allow a non-conforming object to be delegate", ^{
            expect(^{ manager.delegate = (id<SallyManagerDelegate>)[NSNull null]; }).to.raiseAny();
        });

        it(@"should allow conforming object to be delegate", ^{
            id<SallyManagerDelegate> mockDelegate = [[MockSallyManagerDelegate alloc] init];

            expect(^{ manager.delegate = mockDelegate; }).toNot.raiseAny();

            mockDelegate = nil;
        });

        it(@"should accept nil as delegate", ^{
            expect(^{ manager.delegate = nil; }).toNot.raiseAny();
        });
    });

    describe(@"fetch trips", ^{
        it(@"should ask communicator to fetch data", ^{
            MockSallyCommunicator *communicator = [[MockSallyCommunicator alloc] init];
            User *user = [[User alloc] initWithDictionary:@{@"firstName": @"John", @"lastName": @"Doe", @"email": @"jdoe@tokenize.ca"} error: nil];

            manager.user = user;
            manager.communicator = communicator;

            [manager fetchTrips];

            expect(communicator.wasAskedToFetchTrips).to.beTruthy();

            communicator = nil;
            user = nil;
        });

        context(@"failure", ^{
            it(@"should return a higher-level error to delegate", ^{
                NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
                [manager fetchingTripsFailedWithError: communicatorError];

                expect(communicatorError).toNot.equal([delegate fetchError]);

                communicatorError = nil;
            });

            it(@"should include underlying error", ^{
                NSError *communicatorError = [NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil];
                [manager fetchingTripsFailedWithError: communicatorError];

                expect([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey]).to.equal(communicatorError);

                communicatorError = nil;
            });
        });
    });
});

SpecEnd
