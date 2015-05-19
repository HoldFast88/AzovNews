//
//  ANPostCell.m
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANPostCell.h"
#import "AsyncImageView.h"
#import "ANGroup.h"
#import "ANVKManager.h"
#import "ANAttachmentCell.h"


@interface ANPostCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ANPost *post;
@end


@implementation ANPostCell

+ (CGFloat)heightForPost:(ANPost *)post
{
    UILabel *gettingSizeLabel = [[UILabel alloc] init];
    gettingSizeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    gettingSizeLabel.text = post.text;
    gettingSizeLabel.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 31.0f, 99999.0f);
    
    CGSize expectedSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    
    CGFloat collectionViewHeight = 0.0f;
    
    for (NSDictionary *attachment in post.attachments) {
        collectionViewHeight += [ANAttachmentCell heightForAttachment:attachment];
    }
    
    CGFloat height = 16.0f + 50.0f + 8.0f + expectedSize.height + 8.0f + collectionViewHeight + 18.0f;
    return height;
}

- (void)prepareForReuse
{
    self.post = nil;
    [self updateView];
}

- (void)awakeFromNib
{
    [self.logoImageView setCrossfadeDuration:0.0f];
    [self.logoImageView setShowActivityIndicator:YES];
}

- (void)configureWithPost:(ANPost *)post
{
    self.post = post;
    [self updateView];
}

- (void)updateView
{
    ANGroup *group = [[ANVKManager sharedManager] groupWithIdentifier:self.post.groupId];
    [[AsyncImageLoader sharedLoader] loadImageWithURL:[NSURL URLWithString:group.groupLogoImage100URLString] target:self.logoImageView action:@selector(setImage:)];
    
    self.groupNameLabel.text = group.groupName;
    self.textLabel.text = self.post.text;
    
    NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:self.post.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = localizedDateTime;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.post.attachments count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANAttachmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
    NSDictionary *attachment = self.post.attachments[indexPath.row];
    [cell configureWithAttachment:attachment];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *attachment = self.post.attachments[indexPath.row];
    CGFloat cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 32.0f;
    CGFloat cellHeight = [ANAttachmentCell heightForAttachment:attachment];
    return CGSizeMake(cellWidth, cellHeight);
}

@end
