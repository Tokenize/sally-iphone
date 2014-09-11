//
//  SignInController.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2014-08-25.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SignInController.h"
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
