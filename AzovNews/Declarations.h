//
//  Declarations.h
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//


typedef void(^ANAuthorizationHandler)(BOOL isSuccess);
typedef void(^ANGroupsPostsHandler)(BOOL isSuccess, NSArray *posts);
typedef void(^ANGroupsInformationUpdateHandler)(BOOL isSuccess);


typedef NS_ENUM(NSUInteger, ANGroupType) {
    ANGroupTypeVK,
    ANGroupTypeFacebook,
};


typedef NS_ENUM(NSUInteger, ANSource) {
    ANVK,
    ANFacebook,
};


#pragma mark - ANManagerProtocol


@protocol ANManagerProtocol <NSObject>
@required
- (void)authorizeWithCompletionHandler:(ANAuthorizationHandler)completionHandler;
@end


#pragma mark - ANGroupProtocol


@protocol ANGroupProtocol <NSObject>
@property (strong, nonatomic, readonly) NSArray *posts;
@property (nonatomic) ANGroupType groupType;
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSString *groupLogoImage50URLString;
@property (strong, nonatomic) NSString *groupLogoImage100URLString;
@property (strong, nonatomic) NSString *groupLogoImage200URLString;
- (id <ANGroupProtocol>)initWithType:(ANGroupType)groupType andIdentifier:(NSString *)groupId;
- (void)requestGroupsPostsWithCompletionHandler:(ANGroupsPostsHandler)completionHandler;
@end


#pragma mark - ANPostProtocol


@protocol ANPostProtocol <NSObject>
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *attachments;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *groupId;
@end