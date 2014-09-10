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
@end

@implementation SNSPhotoGalleryViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    _photos = [NSMutableArray new];
    
    _assetLibrary = [ALAssetsLibrary new];
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [_photos addObject:result];
                }
            }];
        }
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[SNSPhotoViewCell class] forCellWithReuseIdentifier:PhotoViewCell];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:PhotoViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

@end
