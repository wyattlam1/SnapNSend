//
//  SNSEmailGroupViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/10/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSEmailGroupViewController.h"
#import "SNSEmailGroupViewCell.h"
#import "SNSEmailGroup.h"
#import "UIColor+SNSAdditions.h"

static const NSInteger EmailGroupViewCellWidth = 50;
static NSString *EmailGroupViewCell = @"EmailGroupCell";

@interface SNSEmailGroupViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) NSMutableArray *groups;
@property (nonatomic) NSMutableArray *mSelectedGroups;
@end

@implementation SNSEmailGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _groups = [NSMutableArray new];
    _mSelectedGroups = [NSMutableArray new];
    
    [self setupCollectionView];
    
    [_groups addObject:[[SNSEmailGroup alloc] initWithEmail:@"wyatt.lam1@gmail.com" name:@"wyatt1" thumbnail:[self imageFromURL:[NSURL URLWithString:@"https://farm6.staticflickr.com/5592/14710378279_d9074a1d76_m_d.jpg"]]]];
    [_groups addObject:[[SNSEmailGroup alloc] initWithEmail:@"wyatt.lam90@gmail.com" name:@"wyatt90 Lam" thumbnail:[self imageFromURL:[NSURL URLWithString:@"https://farm4.staticflickr.com/3902/14674914914_df3fd400e3_m_d.jpg"]]]];
//    [_groups addObject:[[SNSEmailGroup alloc] initWithEmail:@"wilson.j.lam@gmail.com" thumbnail:[self imageFromURL:[NSURL URLWithString:@"https://farm8.staticflickr.com/7283/9457052576_ea62c41e07_m_d.jpg"]]]];
//    [_groups addObject:[[SNSEmailGroup alloc] initWithEmail:@"wilson.j.lam@gmail.com" thumbnail:[self imageFromURL:[NSURL URLWithString:@"https://farm8.staticflickr.com/7416/9252420074_073f15d95f_m_d.jpg"]]]];
}

- (void)setupCollectionView
{
    [self.collectionView registerClass:[SNSEmailGroupViewCell class] forCellWithReuseIdentifier:EmailGroupViewCell];
    self.collectionView.allowsMultipleSelection = YES;
    
    CALayer *topBorder = [CALayer layer];
    topBorder.backgroundColor = [UIColor sns_mediumGray].CGColor;
    topBorder.frame = (CGRect){0, 0, CGRectGetWidth(self.view.frame), 1};
    [self.view.layer addSublayer:topBorder];
}

- (UIImage *)imageFromURL:(NSURL *)imageURL
{
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (NSArray *)selectedGroups
{
    return [NSArray arrayWithArray:_mSelectedGroups];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNSEmailGroup *group = [_groups objectAtIndex:indexPath.row];
    SNSEmailGroupViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:EmailGroupViewCell forIndexPath:indexPath];
    cell.thumbnail = group.thumbnail;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id emailGroup = [_groups objectAtIndex:indexPath.row];
    [self.collectionView cellForItemAtIndexPath:indexPath].selected = YES;
    [_mSelectedGroups addObject:emailGroup];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_mSelectedGroups removeObject:[_groups objectAtIndex:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(EmailGroupViewCellWidth, EmailGroupViewCellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    return UIEdgeInsetsMake(0, layout.minimumLineSpacing, 0, 0);
}

@end
