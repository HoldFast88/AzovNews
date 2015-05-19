//
//  ANGroup.m
//  AzovNews
//
//  Created by Alexey Voitenko on 11.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANGroup.h"
#import "ANPost.h"


@interface ANGroup ()

@end


@implementation ANGroup

@synthesize posts = _posts;
@synthesize groupName = _groupName;
@synthesize groupType = _groupType;
@synthesize groupId = _groupId;
@synthesize groupLogoImage100URLString = _groupLogoImage100URLString;
@synthesize groupLogoImage200URLString = _groupLogoImage200URLString;
@synthesize groupLogoImage50URLString = _groupLogoImage50URLString;
@synthesize offset;

- (id <ANGroupProtocol>)initWithType:(ANGroupType)groupType andIdentifier:(NSString *)groupId
{
    self = [super init];
    
    if (self) {
        self.groupId = groupId;
        self.groupType = groupType;
        self.offset = 0;
    }
    
    return self;
}

- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler
{
    if (completionHandler) {
        completionHandler(NO, nil);
    }
}

@end
