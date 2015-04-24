//
//  ANVKNews.h
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Declarations.h"


@interface ANVKManager : NSObject
+ (instancetype)sharedManager;

- (id <ANGroupProtocol>)groupWithIdentifier:(NSString *)groupId;
- (void)updateGroupsInformationWithCompletionHandler:(ANGroupsInformationUpdateHandler)completionHandler;
- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler;
@end
