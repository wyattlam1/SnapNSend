//
//  SNSPhotoViewCell.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/10/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSPhotoViewCell.h"

static const int SNSCellBorder = 6;

@interface SNSPhotoViewCell()
@property (nonatomic) UIImageView *thumbnailView;
@end

@implementation SNSPhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithRed:124/255.f green:181/255.f blue:222/255.f alpha:1.0f].CGColor;
        
        // thumbnailView
        _thumbnailView = [[UIImageView alloc] initWithFrame:(CGRect){0,0, .size = frame.size}];
        [self addSubview:_thumbnailView];
    }
    return self;
}

#pragma mark - Properties

- (void)setThumbnail:(CGImageRef)thumbnail
{
    if (thumbnail && (_thumbnail != thumbnail)) {
        _thumbnail = thumbnail;
        _thumbnailView.image = [UIImage imageWithCGImage:_thumbnail];
        [_thumbnailView setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self animateBorderFromWidth:@0 to:[NSNumber numberWithInt:SNSCellBorder]];
    } else {
        [self animateBorderFromWidth:[NSNumber numberWithInt:SNSCellBorder] to:@0];
    }
}

#pragma mark - Private

- (void)animateBorderFromWidth:(NSNumber *)fromWidth to:(NSNumber *)toWidth
{
    CABasicAnimation *width = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    width.fromValue = fromWidth;
    width.toValue   = toWidth;
    width.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:width forKey:@"width"];
    self.layer.borderWidth = toWidth.integerValue;
}

@end
