//
//  SNSMasterViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/8/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSMasterViewController.h"
#import "SNSPhotoGalleryViewController.h"

#import "UIColor+SNSAdditions.h"

static const NSInteger SNSBottomKeyboardPadding = 3;

@interface SNSMasterViewController () <UITextFieldDelegate>
@property (nonatomic) SNSPhotoGalleryViewController *photoGalleryViewController;
@property (nonatomic, weak) IBOutlet UITextField *subjectTextField;
@property (nonatomic) CGFloat defaultOrignY;
@end

@implementation SNSMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor sns_darkGray];
    _defaultOrignY = self.view.frame.origin.y;
    
    self.subjectTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"photoGalleryCollectionView_embed"]) {
        _photoGalleryViewController = (SNSPhotoGalleryViewController *)[segue destinationViewController];
        _photoGalleryViewController.delegate = self;
    }
}

#pragma mark - Keyboard

- (void)scrollViewDidScroll:(UIScrollView *)scrollView inDirection:(SNSScrolLViewDirection)direction
{
    if (direction == SNSScrollViewDirectionUp) {
        [self.view endEditing:YES];
    }
}

- (void)keyboardIsShown:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    [self _shouldHideKeyBoard:NO keyboardHeight:keyboardFrame.size.height];
}

- (void)keyboardIsHidden:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    [self _shouldHideKeyBoard:YES keyboardHeight:keyboardFrame.size.height];
}

- (void)_shouldHideKeyBoard:(BOOL)shouldHide keyboardHeight:(CGFloat)height
{
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat newOriginY = _defaultOrignY;
        if (!shouldHide) {
            newOriginY = -(height + SNSBottomKeyboardPadding);
        }
        self.view.frame = (CGRect){0, newOriginY, .size = self.view.frame.size};
    }];
}

#pragma mark - Subject Text Field

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
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
