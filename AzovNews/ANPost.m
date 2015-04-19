//
//  ANPost.m
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANPost.h"


@interface ANPost ()

@end


@implementation ANPost

@synthesize text = _text;
@synthesize attachments = _attachments;
@synthesize date = _date;
@synthesize groupId = _groupId;

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
