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
#import "ANVKGroup.h"
#import "VKSdk.h"


#define kGroupsIdentifiers @[@"-72444174", @"-80765893", @"-89748806", @"-82780581", @"-86003658", @"-62409206", @"-83476018"]


@interface ANVKManager ()
@property (strong, nonatomic) dispatch_group_t dispatchRequestGroupsPostsGroup;
@property (nonatomic, strong) NSArray *groups;
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

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSMutableArray *groups = [NSMutableArray arrayWithCapacity:kGroupsIdentifiers.count];
        
        for (NSString *groupId in kGroupsIdentifiers) {
            ANVKGroup *group = [[ANVKGroup alloc] initWithType:ANGroupTypeVK andIdentifier:groupId];
            [groups addObject:group];
        }
        
        self.groups = [NSArray arrayWithArray:groups];
    }
    
    return self;
}

- (id<ANGroupProtocol>)groupWithIdentifier:(NSString *)groupId
{
    for (ANVKGroup *group in self.groups) {
        if ([group.groupId isEqualToString:groupId]) {
            return group;
        }
    }
    
    return nil;
}

- (void)updateGroupsInformationWithCompletionHandler:(ANGroupsInformationUpdateHandler)completionHandler
{
    NSMutableArray *groupIdsAbsoluteValues = [NSMutableArray arrayWithCapacity:kGroupsIdentifiers.count];
    
    for (NSString *rawValue in kGroupsIdentifiers) {
        NSString *absoluteValue = [@(ABS(rawValue.longLongValue)) stringValue];
        [groupIdsAbsoluteValues addObject:absoluteValue];
    }
    
    NSString *group_ids = [groupIdsAbsoluteValues componentsJoinedByString:@","];
    
    VKRequest *feedRequest = [VKApi requestWithMethod:@"groups.getById"
                                        andParameters:@{@"group_ids" : group_ids, @"fields" : @"description"}
                                        andHttpMethod:@"GET"];
    [feedRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *dictionaries = response.json;
        
        for (NSDictionary *info in dictionaries) {
            NSNumber *identifier = info[@"id"];
            ANVKGroup *group = [self groupWithIdentifier:[NSString stringWithFormat:@"-%@", [identifier stringValue]]];
            group.groupName = info[@"name"];
            group.groupLogoImage100URLString = info[@"photo_100"];
            group.groupLogoImage200URLString = info[@"photo_200"];
            group.groupLogoImage50URLString = info[@"photo_50"];
        }
        
        if (completionHandler) {
            completionHandler(YES);
        }
    } errorBlock:^(NSError *error) {
        if (completionHandler) {
            completionHandler(NO);
        }
    }];
}

- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler
{
    self.dispatchRequestGroupsPostsGroup = NULL;
    self.dispatchRequestGroupsPostsGroup = dispatch_group_create();
    
    NSMutableArray *posts = [NSMutableArray array];
    
    for (ANVKGroup *group in self.groups) {
        dispatch_group_enter(self.dispatchRequestGroupsPostsGroup);
        
        [group requestGroupsPostsWithCompletionHandler:^(BOOL isSuccess, NSArray *fetchedPosts) {
            if (isSuccess) {
                [posts addObjectsFromArray:fetchedPosts];
            }
            
            dispatch_group_leave(self.dispatchRequestGroupsPostsGroup);
        }];
    }
    
    dispatch_group_notify(self.dispatchRequestGroupsPostsGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (completionHandler) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
            [posts sortUsingDescriptors:@[sortDescriptor]];
            completionHandler(YES, [NSArray arrayWithArray:posts]);
        }
    });
}

@end
