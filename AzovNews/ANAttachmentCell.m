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
    NSDictionary *attachmentBody = attachment[type];
    CGFloat height = [attachmentBody[@"height"] floatValue];
    CGFloat width = [attachmentBody[@"width"] floatValue];
    CGFloat cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 32.0f;
    CGFloat cellHeight = height / (width / cellWidth);
    return cellHeight;
}

- (void)awakeFromNib
{
    [self.imageView setCrossfadeDuration:0.0f];
    [self.imageView setShowActivityIndicator:YES];
}

- (void)configureWithAttachment:(NSDictionary *)attachment
{
    NSString *type = attachment[@"type"];
    NSDictionary *attachmentBody = attachment[type];
    NSString *previewImageURLString = attachmentBody[@"photo_604"];
    
    [[AsyncImageLoader sharedLoader] loadImageWithURL:[NSURL URLWithString:previewImageURLString] target:self.imageView action:@selector(setImage:)];
}

@end
