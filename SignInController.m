//
//  SignInController.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-08-25.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SignInController.h"
#import "TripsController.h"
#import "SallyManager.h"
#import "SallyCommunicator.h"

@interface SignInController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic) NSString *authenticationToken;
@property (nonatomic) SallyManager *manager;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation SignInController

- (IBAction)signInButton:(id)sender
{
    [_manager signInWithEmail: self.emailField.text password: self.passwordField.text];
}

- (void)sallyManager:(SallyManager *)manager didSignInWithToken:(NSString *)token
{
    [self.statusLabel setText: nil];

    _authenticationToken = token;

    [self performSegueWithIdentifier: @"trips" sender: self];
}

- (void)sallyManager:(SallyManager *)manager signInFailedWithError:(NSError *)error
{
    [self.statusLabel setText: @"Invalid email or password"];
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
    if ([segue.identifier isEqualToString: @"trips"]) {
        if ([segue.destinationViewController isKindOfClass: [TripsController class]]) {
            TripsController *tripsController = (TripsController *)segue.destinationViewController;
            tripsController.authenticationToken = _authenticationToken;
        }
    }
}

@end
