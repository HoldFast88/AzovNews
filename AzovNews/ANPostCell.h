//
//  ANPostCell.h
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPost.h"


@interface ANPostCell : UICollectionViewCell
+ (CGFloat)heightForPost:(ANPost *)post;
- (void)configureWithPost:(ANPost *)post;
@end
