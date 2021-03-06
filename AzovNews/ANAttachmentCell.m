//
//  ANAttachmentCell.m
//  AzovNews
//
//  Created by Alexey Voitenko on 03.05.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANAttachmentCell.h"
#import "AsyncImageView.h"


@interface ANAttachmentCell ()
@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@end


@implementation ANAttachmentCell

+ (CGFloat)heightForAttachment:(NSDictionary *)attachment
{
    NSString *type = attachment[@"type"];
    
    if ([type isEqualToString:@"photo"]) {
        NSDictionary *attachmentBody = attachment[type];
        CGFloat height = [attachmentBody[@"height"] floatValue];
        CGFloat width = [attachmentBody[@"width"] floatValue];
        CGFloat cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 32.0f;
        CGFloat cellHeight = height / (width / cellWidth);
        return cellHeight;
    } else {
        return 0.0f;
    }
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

- (void)awakeFromNib
{
    [self.imageView setCrossfadeDuration:0.0f];
    [self.imageView setShowActivityIndicator:YES];
    [self.imageView setBackgroundColor:[UIColor darkGrayColor]];
}

- (void)configureWithAttachment:(NSDictionary *)attachment
{
    NSString *type = attachment[@"type"];
    NSDictionary *attachmentBody = attachment[type];
    NSString *previewImageURLString = attachmentBody[@"photo_604"];
    
    [self.imageView setImageURL:[NSURL URLWithString:previewImageURLString]];
}

@end
