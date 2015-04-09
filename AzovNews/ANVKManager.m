//
//  ANVKNews.m
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANVKManager.h"
#import "AppDelegate.h"


@interface ANVKManager ()
@property (nonatomic, copy) ANAuthorizationHandler authorizationHandler;
@end


@implementation ANVKManager

@synthesize isAuthorized = _isAuthorized;

+ (instancetype)sharedManager
{
    static ANVKManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (BOOL)isAuthorized
{
    return [VKSdk wakeUpSession];
}

#pragma mark - ANManagerProtocol

- (void)authorizeWithCompletionHandler:(ANAuthorizationHandler)completionHandler
{
    self.authorizationHandler = completionHandler;
    [VKSdk authorize:@[@"groups", @"offline"]];
}

#pragma mark - VKSdkDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken
{
    
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError
{
    if (self.authorizationHandler) {
        self.authorizationHandler(NO);
    }
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    [rootViewController presentViewController:controller animated:YES completion:NULL];
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken
{
    if (self.authorizationHandler) {
        self.authorizationHandler(YES);
    }
}

@end
