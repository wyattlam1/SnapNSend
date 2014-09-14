//
//  SNSEmailGroup.h
//  SnapNSend
//
//  Created by Wyatt Lam on 9/11/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSEmailGroup : NSObject
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) UIImage *thumbnail;

- (instancetype)initWithEmail:(NSString *)email name:(NSString *)name thumbnail:(UIImage *)thumbnail;

@end
