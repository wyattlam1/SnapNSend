//
//  SNSMasterViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/7/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSPhotoGalleryViewController.h"
#import "SNSPhotoViewCell.h"
#import "SNSMasterViewController.h"
#import "AssetsLibrary/AssetsLibrary.h"

#import "UIColor+SNSAdditions.h"

static NSString *PhotoViewCell = @"PhotoViewCell";

@interface SNSPhotoGalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, readonly) ALAssetsLibrary *assetLibrary;
@property (nonatomic, readonly) NSMutableArray *photos;
@property (nonatomic, readonly) NSMutableArray *selectedPhotos;
@property (nonatomic) CGFloat lastScrollPosition;
@end

@implementation SNSPhotoGalleryViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _photos = [NSMutableArray new];
    _selectedPhotos = [NSMutableArray new];
    
    [self setupCollectionView];

    _assetLibrary = [ALAssetsLibrary new];
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [_photos addObject:result];
                }
            }];
            [self.collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)setupCollectionView
{
    [self.collectionView registerClass:[SNSPhotoViewCell class] forCellWithReuseIdentifier:PhotoViewCell];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.delegate = self;
    
    // transparent background for status bar
    CALayer *statusBarBackground = [CALayer layer];
    statusBarBackground.backgroundColor = [[UIColor sns_darkGray] colorWithAlphaComponent:0.7f].CGColor;
    statusBarBackground.frame = (CGRect){0, 0, CGRectGetWidth(self.view.frame), 20};
    [self.view.layer addSublayer:statusBarBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat newY = scrollView.contentOffset.y;
    if ([self _scrolledWithinContent:scrollView]) {
        if (newY < _lastScrollPosition) {
            [self.delegate scrollViewDidScroll:scrollView inDirection:SNSScrollViewDirectionUp];
        } else {
            [self.delegate scrollViewDidScroll:scrollView inDirection:SNSScrollViewDirectionDown];
        }
        _lastScrollPosition = newY;
    } else if (newY < 0) {
        // special case for scrolling above top
        [self.delegate scrollViewDidScroll:scrollView inDirection:SNSScrollViewDirectionUp];
    }
}

- (BOOL)_scrolledWithinContent:(UIScrollView *)scrollView
{
    CGFloat newY = scrollView.contentOffset.y;
    BOOL scrolledAboveTop = scrollView.contentOffset.y < 0;
    BOOL scrolledBelowBottom = (newY + scrollView.bounds.size.height) > scrollView.contentSize.height;
    return !scrolledAboveTop && !scrolledBelowBottom;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [_photos objectAtIndex:indexPath.row];
    CGImageRef thumbnail = asset.thumbnail;
    
    SNSPhotoViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:PhotoViewCell forIndexPath:indexPath];
    cell.thumbnail = thumbnail;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectedIndex = indexPath.row;
    [_selectedPhotos addObject:[_photos objectAtIndex:selectedIndex]];
    
    SNSPhotoViewCell *cell = (SNSPhotoViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_selectedPhotos removeObject:[_photos objectAtIndex:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = CGRectGetWidth(self.view.frame) / 3.f - 2.f;
    return CGSizeMake(width, width);
}

@end
