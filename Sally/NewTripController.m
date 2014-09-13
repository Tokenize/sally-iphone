//
//  NewTripController.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-09-11.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "NewTripController.h"
#import "TrackLocationsController.h"
#import "SallyManager.h"
#import "SallyCommunicator.h"
#import "Trip.h"

@interface NewTripController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic) Trip *trip;
@property (nonatomic) SallyManager *manager;
@end

@implementation NewTripController

- (IBAction)startButton:(id)sender {
    _trip = [[Trip alloc] initWithDictionary: @{@"name": self.nameField.text, @"description": self.descriptionField.text, @"startAt": [NSDate date]} error: nil];

    [_manager createTrip: _trip];
}

#pragma mark - SallyManagerDelegate methods

- (void)sallyManager:(SallyManager *)manager didCreateTrip:(Trip *)trip
{
    _trip = trip;

    [self performSegueWithIdentifier: @"trackLocations" sender: self];
}

- (void)sallyManager:(SallyManager *)manager createTripFailedWithError:(NSError *)error
{
    self.errorLabel.text = [error description];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];

    _manager = [[SallyManager alloc] init];
    _manager.communicator = [SallyCommunicator sharedSallyCommunicator];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"trackLocations"]) {
        if ([segue.destinationViewController isKindOfClass: [TrackLocationsController class]]) {
            TrackLocationsController *trackingController = (TrackLocationsController *)segue.destinationViewController;

            trackingController.trip = [_trip copy];
        }
    }
}

@end
