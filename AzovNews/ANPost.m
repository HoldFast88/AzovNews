//
//  ANPost.m
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANPost.h"


@interface ANPost ()
@property (nonatomic, strong) NSDictionary *dictionary;
@end


@implementation ANPost

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSource:(ANSource)source
{
    self = [super init];
    
    if (self) {
        _dictionary = dictionary;
        _source = source;
    }
    
    return self;
}

@end
