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
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>


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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.triggerVerticalOffset = 100.0f;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.bottomRefreshControl = refreshControl;
}

- (void)updateDatasource
{
    [[ANVKManager sharedManager] updateGroupsInformationWithCompletionHandler:^(BOOL isSuccess) {
        [[ANVKManager sharedManager] requestGroupsPostsWithCompletionHandler:^(BOOL isSuccess, NSArray *posts) {
            if (isSuccess) {
                self.datasource = posts;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateView];
                });
            }
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
    ANPost *post = self.datasource[indexPath.row];
    
    [cell configureWithPost:post];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANPost *object = self.datasource[indexPath.row];
    CGFloat height = [ANPostCell heightForPost:object];
    
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), height);
}

#pragma mark - Helpers

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
}

@end
