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


#define kPostsPerRequest 3


@implementation ANVKGroup

- (id<ANGroupProtocol>)initWithType:(ANGroupType)groupType andIdentifier:(NSString *)groupId
{
    return [super initWithType:groupType andIdentifier:groupId];
}

- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler
{
    VKRequest *feedRequest = [VKApi requestWithMethod:@"wall.get"
                                        andParameters:@{@"owner_id" : self.groupId, @"count" : [@(kPostsPerRequest) stringValue], @"filter" : @"all", @"offset" : [@(self.offset) stringValue]}
                                        andHttpMethod:@"GET"];
    [feedRequest executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = response.json[@"items"];
        self.offset += [items count];
        
        NSMutableArray *posts = [NSMutableArray array];
        
        for (NSDictionary *item in items) {
            NSArray *attachments = item[@"attachments"];
            
            BOOL shouldShow = YES;
            
            for (NSDictionary *attachment in attachments) {
                if ([attachment[@"type"] isEqualToString:@"video"] || [attachment[@"type"] isEqualToString:@"link"]) {
                    shouldShow = NO;
                    break;
                }
            }
            
            if (item[@"copy_history"] != nil || !shouldShow) {
                continue;
            }
            
            ANVKPost *post = [[ANVKPost alloc] initWithDictionary:item andSource:ANVK];
            [posts addObject:post];
        }
        
        if (completionHandler) {
            completionHandler(YES, posts);
        }
    } errorBlock:^(NSError *error) {
        if (completionHandler) {
            completionHandler(NO, nil);
        }
    }];
}

@end
