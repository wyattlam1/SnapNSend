//
//  SNSEmailGroupViewCell.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/11/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSEmailGroupViewCell.h"

static const float kThumbnailAlphaValue = 0.3f;

@interface SNSEmailGroupViewCell()
@property (nonatomic) UIImageView *thumbnailView;
@end

@implementation SNSEmailGroupViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width / 2.f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        
        _thumbnailView = [[UIImageView alloc] initWithFrame:(CGRect){ 0,0, .size = frame.size}];
        [self addSubview:_thumbnailView];
    }
    return self;
}

- (void)setThumbnail:(UIImage *)thumbnail
{
    if (_thumbnail != thumbnail) {
        
        CGFloat width = thumbnail.size.width;
        CGFloat height = thumbnail.size.height;
        CGFloat ratio;
        if (width < height) {
            ratio = width / _thumbnailView.frame.size.width;
        } else {
            ratio = height / _thumbnailView.frame.size.height;
        }
        
        _thumbnail = [UIImage imageWithCGImage:thumbnail.CGImage scale:ratio orientation:UIImageOrientationUp];
        _thumbnailView.frame = (CGRect){(_thumbnailView.frame.size.width - _thumbnail.size.width) / 2.f, 0, .size = _thumbnail.size};
        _thumbnailView.frame = (CGRect){0, 0, .size = _thumbnail.size};
        _thumbnailView.image = _thumbnail;
        _thumbnailView.alpha = kThumbnailAlphaValue;
        [_thumbnailView setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _thumbnailView.alpha = 1.f;
    } else {
        _thumbnailView.alpha = kThumbnailAlphaValue;
    }
}

@end
