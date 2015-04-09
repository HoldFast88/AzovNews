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
@property (nonatomic) dispatch_group_t requestsGroup;
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
    self.requestsGroup = NULL;
    self.requestsGroup = dispatch_group_create();
    
    dispatch_group_enter(self.requestsGroup);
    [[ANVKManager sharedManager] requestGroupsPostsWithCompletionHandler:^(BOOL isSuccess, NSArray *posts) {
        self.datasource = [self.datasource arrayByAddingObjectsFromArray:posts];
        dispatch_group_leave(self.requestsGroup);
    }];
    
//    dispatch_group_enter(self.requestsGroup);
//    [[ANFacebookManager sharedManager] requestGroupsPostsWithCompletionHandler:^(BOOL isSuccess, NSArray *posts) {
//        
//        dispatch_group_leave(self.requestsGroup);
//    }];
    
    dispatch_group_notify(self.requestsGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self updateView];
    });
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
