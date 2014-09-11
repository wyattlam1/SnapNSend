//
//  SNSEmailGroupViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/10/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSEmailGroupViewController.h"
#import "SNSEmailGroupViewCell.h"
#import "UIColor+SNSAdditions.h"

static const NSInteger EmailGroupViewCellWidth = 50;
static NSString *EmailGroupViewCell = @"EmailGroupCell";

@interface SNSEmailGroupViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) NSMutableArray *groups;
@property (nonatomic) NSMutableArray *selectedGroups;
@end

@implementation SNSEmailGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _groups = [NSMutableArray new];
    _selectedGroups = [NSMutableArray new];
    
    [self.collectionView registerClass:[SNSEmailGroupViewCell class] forCellWithReuseIdentifier:EmailGroupViewCell];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.backgroundColor = [UIColor sns_darkGray];
    
#warning remove
    [_groups addObject:@1];
    [_groups addObject:@3];
    [_groups addObject:@2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNSEmailGroupViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:EmailGroupViewCell forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id emailGroup = [_groups objectAtIndex:indexPath.row];
    [self.collectionView cellForItemAtIndexPath:indexPath].selected = YES;
    [_selectedGroups addObject:emailGroup];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_selectedGroups removeObject:[_groups objectAtIndex:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(EmailGroupViewCellWidth, EmailGroupViewCellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 5, 0, 0);
}

@end
