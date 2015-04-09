//
//  Declarations.h
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//


typedef void(^ANAuthorizationHandler)(BOOL isSuccess);


@protocol ANManagerProtocol <NSObject>
@required
- (void)authorizeWithCompletionHandler:(ANAuthorizationHandler)completionHandler;
@end