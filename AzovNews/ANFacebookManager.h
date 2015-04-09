//
//  ANFacebookManager.h
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Declarations.h"


@interface ANFacebookManager : NSObject <ANManagerProtocol>

@property (nonatomic) BOOL isAuthorized;

+ (instancetype)sharedManager;

@end
