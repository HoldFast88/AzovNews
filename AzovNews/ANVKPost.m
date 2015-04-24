//
//  ANVKPost.m
//  AzovNews
//
//  Created by Alexey Voitenko on 19.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANVKPost.h"


@implementation ANVKPost

@synthesize text = _text;
@synthesize attachments = _attachments;
@synthesize date = _date;
@synthesize groupId = _groupId;

- (NSString *)text
{
    if (_text == nil) {
        _text = self.dictionary[@"text"];
    }
    
    return _text;
}

- (NSArray *)attachments
{
    return nil;
}

- (NSDate *)date
{
    if (_date == nil) {
        _date = [NSDate dateWithTimeIntervalSince1970:[self.dictionary[@"date"] floatValue]];
    }
    
    return _date;
}

- (NSString *)groupId
{
    if (_groupId == nil) {
        _groupId = [self.dictionary[@"owner_id"] stringValue];
    }
    
    return _groupId;
}

@end
