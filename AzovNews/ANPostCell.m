//
//  ANPostCell.m
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANPostCell.h"


@interface ANPostCell ()
@property (strong, nonatomic) ANPost *post;
@end


@implementation ANPostCell

+ (CGFloat)heightForPost:(ANPost *)post
{
    return 100.0f;
}

- (void)configureWithPost:(ANPost *)post
{
    self.post = post;
}

@end
