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


@interface ANPostCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *logoImageView;
@property (strong, nonatomic) ANPost *post;
@end


@implementation ANPostCell

+ (CGFloat)heightForPost:(ANPost *)post
{
    UILabel *gettingSizeLabel = [[UILabel alloc] init];
    gettingSizeLabel.font = [UIFont systemFontOfSize:15.0f];
    gettingSizeLabel.text = post.text;
    gettingSizeLabel.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 31.0f, 99999.0f);
    
    CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    
    return 79.0f + expectSize.height + 19.0f;
}

- (void)awakeFromNib
{
    [self.logoImageView setShowActivityIndicator:YES];
}

- (void)configureWithPost:(ANPost *)post
{
    self.post = post;
    
    ANGroup *group = [[ANVKManager sharedManager] groupWithIdentifier:post.groupId];
    [[AsyncImageLoader sharedLoader] loadImageWithURL:[NSURL URLWithString:group.groupLogoImage50URLString] target:self.logoImageView action:@selector(setImage:)];
    
    self.groupNameLabel.text = group.groupName;
    self.textLabel.text = post.text;
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    [calendar setLocale:[NSLocale currentLocale]];
//    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:post.date];
    
    NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:post.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = localizedDateTime;
}

@end
