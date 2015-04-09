//
//  ANFacebookManager.m
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANFacebookManager.h"
#import "AppDelegate.h"
#import "FBSDKLoginKit.h"


@implementation ANFacebookManager

@synthesize isAuthorized = _isAuthorized;

+ (instancetype)sharedManager
{
    static ANFacebookManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (BOOL)isAuthorized
{
    return NO;
}

#pragma mark - ANManagerProtocol

- (void)authorizeWithCompletionHandler:(ANAuthorizationHandler)completionHandler
{
    
}

@end
