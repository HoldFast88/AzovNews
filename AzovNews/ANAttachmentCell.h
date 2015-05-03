//
//  ANAttachmentCell.h
//  AzovNews
//
//  Created by Alexey Voitenko on 03.05.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANAttachmentCell : UICollectionViewCell
+ (CGFloat)heightForAttachment:(NSDictionary *)attachment;
- (void)configureWithAttachment:(NSDictionary *)attachment;
@end
