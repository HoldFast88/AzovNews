//
//  ANPost.h
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, ANSource) {
    ANVK,
    ANFacebook,
};


@interface ANPost : NSObject

@property (nonatomic, readonly) ANSource source;
@property (strong, nonatomic, readonly) NSString *text;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSource:(ANSource)source;

@end
