//
//  SNSEmailGroup.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/11/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSEmailGroup.h"

@implementation SNSEmailGroup

- (instancetype)initWithEmail:(NSString *)email thumbnail:(UIImage *)thumbnail
{
    self = [super init];
    if (self) {
        _email = email;
        _thumbnail = thumbnail;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *descrip = [NSMutableString new];
    [descrip appendString:@"{\n"];
    [descrip appendFormat:@"    email: %@\n", _email];
    [descrip appendFormat:@"    thumbnail: %@\n", _thumbnail];
    [descrip appendString:@"}\n"];
    return descrip;
}

@end
