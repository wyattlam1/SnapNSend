//
//  SNSEmailGroupViewCell.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/11/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSEmailGroupViewCell.h"

@implementation SNSEmailGroupViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.alpha = 0.3f;
        self.layer.cornerRadius = self.frame.size.width / 2.f;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.alpha = 1.f;
    } else {
        self.alpha = 0.3f;
    }
}

@end
