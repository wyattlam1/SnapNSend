//
//  SNSMasterViewController.h
//  SnapNSend
//
//  Created by Wyatt Lam on 9/7/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SNSScrollViewDirectionDown,
    SNSScrollViewDirectionUp
} SNSScrolLViewDirection;

@protocol SNSPhotoGalleryViewDelegate <NSObject>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView inDirection:(SNSScrolLViewDirection)direction;
@end

@interface SNSPhotoGalleryViewController : UICollectionViewController
@property (nonatomic, weak) id<SNSPhotoGalleryViewDelegate> delegate;
@end
