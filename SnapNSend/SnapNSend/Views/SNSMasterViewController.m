//
//  SNSMasterViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/8/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSMasterViewController.h"
#import "SNSPhotoGalleryViewController.h"

@interface SNSMasterViewController ()
@property (nonatomic, readonly) SNSPhotoGalleryViewController *photoGalleryViewController;
@end

@implementation SNSMasterViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
