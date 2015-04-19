//
//  ANVKGroup.m
//  AzovNews
//
//  Created by Alexey Voitenko on 17.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANVKGroup.h"
#import "VKSdk.h"
#import "ANVKPost.h"


@implementation ANVKGroup

- (id<ANGroupProtocol>)initWithType:(ANGroupType)groupType andIdentifier:(NSString *)groupId
{
    return [super initWithType:groupType andIdentifier:groupId];
}

- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler
{
    VKRequest *feedRequest = [VKApi requestWithMethod:@"wall.get"
                                        andParameters:@{@"owner_id" : self.groupId, @"count" : @"3", @"filter" : @"all"}
                                        andHttpMethod:@"GET"];
    [feedRequest executeWithResultBlock:^(VKResponse *response) {
        NSMutableArray *posts = [NSMutableArray array];
        
        for (NSDictionary *item in response.json[@"items"]) {
            ANVKPost *post = [[ANVKPost alloc] initWithDictionary:item andSource:ANVK];
            [posts addObject:post];
        }
    } errorBlock:^(NSError *error) {
        if (completionHandler) {
            completionHandler(NO, nil);
        }
    }];
}

@end
