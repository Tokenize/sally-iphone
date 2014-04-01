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
    
    describe(@"Create trip", ^{
        context(@"success", ^{
            it(@"should pass the newly created trip to the delegate", ^{
                NSDictionary *tripAttributes = @{@"name": @"Test 1", @"start_at": [[NSDate distantFuture] description]};
                
                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator createTrip: tripAttributes];
                
                expect(communicatorDelegate.trip).willNot.beNil;
                expect(communicatorDelegate.trip[@"name"]).will.equal(@"Test 1");
            });
        });
        
        context(@"failure", ^{
            it(@"should notify delegate of error", ^{
                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator createTrip: @{@"random": @"key"}];

                expect(communicatorDelegate.error).willNot.beNil;
                expect(communicatorDelegate.trip).will.beNil;
            });
        });
    });

    describe(@"Create location", ^{
        context(@"success", ^{
            it(@"should pass the newly created location to the delegate", ^{
                NSDictionary *locationAttributes = @{@"trip_id": @"1", @"time": [[NSDate distantFuture] description], @"latitude": @"123456789", @"longitude": @"987654321"};

                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator createLocationForTrip: locationAttributes];

                expect(communicatorDelegate.location).willNot.beNil;
                expect(communicatorDelegate.error).will.beNil;
            });
        });

        context(@"failure", ^{
            it(@"should notify delegate of error", ^{
                NSDictionary *locationAttributes = @{@"trip_id": @"1", @"latitude": @"123456789", @"longitude": @"987654321"};

                communicator.parameters[@"auth_token"] = @"zYNjCaeguEaJk3HqVX9L";
                [communicator createLocationForTrip: locationAttributes];

                expect(communicatorDelegate.error).willNot.beNil;
                expect(communicatorDelegate.location).will.beNil;
            });
        });
    });
});

SpecEnd
