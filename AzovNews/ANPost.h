//
//  ANPost.h
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Declarations.h"


@interface ANPost : NSObject
@property (nonatomic, readonly) ANSource source;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSource:(ANSource)source;
@end
