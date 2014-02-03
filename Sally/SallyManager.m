//
//  SallyManager.m
//  Sally
//
//  Created by Zaid Al-Jarrah on 2/2/2014.
//  Copyright (c) 2014 Tokenize. All rights reserved.
//

#import "SallyManager.h"

@implementation SallyManager

@synthesize delegate;

- (void)setDelegate:(id<SallyManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol: @protocol(SallyManagerDelegate)]) {
        [[NSException exceptionWithName: NSInvalidArgumentException
                                 reason: @"Delegate does not conform to the SallyManagerDelegate protocol"
                               userInfo: nil] raise];
    }
    
    delegate = newDelegate;
}

@end
