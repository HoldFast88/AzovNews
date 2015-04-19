//
//  ANFeedViewController.m
//  AzovNews
//
//  Created by Alexey Voitenko on 09.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANFeedViewController.h"
#import "ANPostCell.h"
#import "ANPost.h"
#import "ANFacebookManager.h"
#import "ANVKManager.h"


@interface ANFeedViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *datasource;
@end


@implementation ANFeedViewController

@synthesize datasource = _datasource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateDatasource];
}

- (void)updateDatasource
{
    [[ANVKManager sharedManager] updateGroupsInformationWithCompletionHandler:^(BOOL isSuccess) {
        [[ANVKManager sharedManager] requestGroupsPostsWithCompletionHandler:^(BOOL isSuccess, NSArray *posts) {
            
        }];
    }];
}

- (void)updateView
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id object = self.datasource[indexPath.row];
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    
    if ([object isKindOfClass:[ANPostCell class]]) {
        height = [ANPostCell heightForPost:object];
    }
    
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), height);
}

@end
