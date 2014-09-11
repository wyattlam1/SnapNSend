//
//  SNSPhotoViewCell.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/10/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSPhotoViewCell.h"

@interface SNSPhotoViewCell()
@property (nonatomic) UIImageView *thumbnailView;
@end

@implementation SNSPhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _thumbnailView = [[UIImageView alloc] initWithFrame:(CGRect){0,0, .size = frame.size}];
        [self addSubview:_thumbnailView];
    }
    return self;
}

- (void)setThumbnail:(CGImageRef)thumbnail
{
    if (thumbnail && (_thumbnail != thumbnail)) {
        _thumbnail = thumbnail;
        _thumbnailView.image = [UIImage imageWithCGImage:_thumbnail];
        [_thumbnailView setNeedsDisplay];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
