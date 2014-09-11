//
//  SNSMasterViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/7/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSPhotoGalleryViewController.h"
#import "SNSPhotoViewCell.h"
#import "AssetsLibrary/AssetsLibrary.h"

static NSString *PhotoViewCell = @"PhotoViewCell";

@interface SNSPhotoGalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, readonly) ALAssetsLibrary *assetLibrary;
@property (nonatomic, readonly) NSMutableArray *photos;
@property (nonatomic, readonly) NSMutableArray *selectedPhotos;
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
                } else {
                    NSLog(@"NO RESULT: %ld", index);
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
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height, 0, 0, 0);
}

@end
