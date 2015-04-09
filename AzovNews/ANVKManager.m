//
//  ANVKNews.m
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANVKManager.h"
#import "AppDelegate.h"
#import "ANPost.h"

#define kGroupsIdentifiers @[@"-72444174"]


@interface ANVKManager ()
@property (nonatomic, copy) ANAuthorizationHandler authorizationHandler;
@property (nonatomic) dispatch_group_t groupsGroup;
@end


@implementation ANVKManager

+ (instancetype)sharedManager
{
    static ANVKManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - ANManagerProtocol

- (void)authorizeWithCompletionHandler:(ANAuthorizationHandler)completionHandler
{
    self.authorizationHandler = completionHandler;
    [VKSdk authorize:@[@"groups", @"offline"]];
}

- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler
{
    self.groupsGroup = NULL;
    self.groupsGroup = dispatch_group_create();
    
    NSMutableArray *posts = [NSMutableArray array];
    
    for (NSString *groupId in kGroupsIdentifiers) {
        dispatch_group_enter(self.groupsGroup);
        
        VKRequest *feedRequest = [VKApi requestWithMethod:@"wall.get"
                                            andParameters:@{@"owner_id" : groupId, @"count" : @"3", @"filter" : @"all"}
                                            andHttpMethod:@"GET"];
        [feedRequest executeWithResultBlock:^(VKResponse *response) {
            for (NSDictionary *item in response.json[@"items"]) {
                ANPost *post = [[ANPost alloc] initWithDictionary:item andSource:ANVK];
                [posts addObject:post];
            }
            
            dispatch_group_leave(self.groupsGroup);
        } errorBlock:^(NSError *error) {
            if (completionHandler) {
                completionHandler(NO, nil);
            }
            
            dispatch_group_leave(self.groupsGroup);
        }];
    }
    
    dispatch_group_notify(self.groupsGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (completionHandler) {
            completionHandler(YES, [NSArray arrayWithArray:posts]);
        }
    });
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
