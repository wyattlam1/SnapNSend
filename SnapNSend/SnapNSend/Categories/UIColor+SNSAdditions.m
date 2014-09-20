//
//  UIColor+SNSAdditions.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/10/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "UIColor+SNSAdditions.h"

@implementation UIColor (SNSAdditions)

+ (UIColor *)sns_lightGray
{
    return [UIColor colorWithWhite:0.9f alpha:1.0f];
}

+ (UIColor *)sns_mediumGray
{
    return [UIColor colorWithWhite:0.3f alpha:0.8f];
}

+ (UIColor *)sns_darkGray
{
    return [UIColor colorWithWhite:0.1f alpha:1.0f];
}

+ (UIColor *)sns_lightBlue
{
    return [UIColor colorWithRed:124/255.f green:181/255.f blue:222/255.f alpha:1.0f];
}


@end
