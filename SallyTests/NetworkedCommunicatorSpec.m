//
//  NetworkedCommunicatorSpec.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-03-25.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyCommunicator.h"
#import "MockSallyCommunicatorDelegate.h"

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(NetworkedCommunicator)

describe(@"NetworkedCommunicator", ^{
    
    __block SallyCommunicator *communicator;
    __block MockSallyCommunicatorDelegate *communicatorDelegate;
    
    beforeAll(^{
        [Expecta setAsynchronousTestTimeout: 5];
    });
    
    beforeEach(^{
        communicator = [SallyCommunicator sharedSallyCommunicator];
        communicatorDelegate = [[MockSallyCommunicatorDelegate alloc] init];
        
        communicator.delegate = communicatorDelegate;
    });
    
    afterEach(^{
        communicator = nil;
        communicatorDelegate = nil;
    });
    
    describe(@"Sign-in", ^{
        context(@"success", ^{
            it(@"should pass the token to the delegate", ^{
                [communicator signInWithEmail: @"zaid@tokenize.ca" password: @"xuXv3ZQXoKM3kALV"];
                
                expect(communicatorDelegate.apiToken).will.equal(@"zYNjCaeguEaJk3HqVX9L");
            });
        });
        
        context(@"failure", ^{
            it(@"should notify delegate of error", ^{
                [communicator signInWithEmail: @"zaid@tokenize.ca" password: @"invalid"];

                expect(communicatorDelegate.error).toNot.beNil;
                expect(communicatorDelegate.apiToken).to.beNil;
                
            });
        });
    });
    
    describe(@"Fetch trips", ^{
        context(@"success", ^{
            it(@"should pass the trips to the delegate", ^{
                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator fetchTrips];
                
                expect([communicatorDelegate.trips count]).will.beGreaterThan(0);
            });
        });
        
        context(@"failure", ^{
            it(@"should notify delegate of error", ^{
                communicator.parameters[@"auth_token"] = @"invalid";
                [communicator fetchTrips];
                
                expect(communicatorDelegate.error).willNot.beNil;
                expect([communicatorDelegate.trips count]).will.equal(0);
            });
        });
    });

    describe(@"Fetch Locations for a Trip",  ^{
        context(@"success", ^{
            it(@"should pass the locations to the delegate", ^{
                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator fetchLocationsForTrip: 1];

                expect([communicatorDelegate.locations count]).will.beGreaterThan(0);
            });
        });

        context(@"failure", ^{
            it(@"should notify delegate of error", ^{
                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator fetchLocationsForTrip: 0];

                expect(communicatorDelegate.error).willNot.beNil;
                expect([communicatorDelegate.locations count]).will.equal(0);
            });
        });
    });
});

SpecEnd
