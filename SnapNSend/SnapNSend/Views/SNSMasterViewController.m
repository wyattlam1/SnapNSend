//
//  SNSMasterViewController.m
//  SnapNSend
//
//  Created by Wyatt Lam on 9/8/14.
//  Copyright (c) 2014 WyattLam. All rights reserved.
//

#import "SNSMasterViewController.h"
#import "SNSPhotoGalleryViewController.h"
#import "SNSEmailGroupViewController.h"
#import "SNSEmailGroup.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "WLGmail/WLGmailMessage.h"
#import "WLGmail/WLGmailAddress.h"
#import "WLGmail/WLGmailService.h"
#import "UIColor+SNSAdditions.h"

static NSString *const kGTLAuthScopeGmailCompose = @"https://mail.google.com/";
static NSString *const kClientID = @"186276393028-h84qv12meolpht4sa003csrlt74sldhj.apps.googleusercontent.com";
static NSString *const kClientSecret = @"KqRG4g83Xtq_-twoLoBFz171";
static NSString *const kKeychainItemName = @"zaizaiwyatt";

static const NSInteger SNSBottomKeyboardPadding = 3;

@interface SNSMasterViewController () <UITextFieldDelegate>
@property (nonatomic) WLGmailService *gmailService;
@property (nonatomic) SNSPhotoGalleryViewController *photoGalleryViewController;
@property (nonatomic) SNSEmailGroupViewController *emailGroupViewController;
@property (nonatomic, weak) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic) CGFloat defaultOrignY;
@end

@implementation SNSMasterViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _setupGmailService];
    
    self.view.backgroundColor = [UIColor sns_darkGray];
    _defaultOrignY = self.view.frame.origin.y;
    
    self.subjectTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_setupGmailService
{
    GTMOAuth2Authentication *auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName clientID:kClientID clientSecret:kClientSecret];
    if (!auth.canAuthorize) {
        GTMOAuth2ViewControllerTouch *authViewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeGmailCompose clientID:kClientID clientSecret:kClientSecret keychainItemName:kKeychainItemName completionHandler:^(GTMOAuth2ViewControllerTouch *viewController, GTMOAuth2Authentication *auth, NSError *error) {
            if (auth && !error) {
                _gmailService = [[WLGmailService alloc] initWithEmailAddress:auth.userEmail authorizer:auth];
            } else {
                NSLog(@"Failed to authenticate to Gmail: %@", error);
            }
        }];
        [self.navigationController pushViewController:authViewController animated:YES];
    } else {
        _gmailService = [[WLGmailService alloc] initWithEmailAddress:auth.userEmail authorizer:auth];
    }
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
    } else if ([segue.identifier isEqualToString:@"emailGroupCollectionView_embed"]) {
        _emailGroupViewController = (SNSEmailGroupViewController *)[segue destinationViewController];
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

- (IBAction)touchDownSendEmail:(id)sender
{
    _sendButton.backgroundColor = [UIColor sns_lightBlue];
}

- (IBAction)sendEmail:(id)sender
{
    _sendButton.backgroundColor = [UIColor whiteColor];
    
    if (!_emailGroupViewController.selectedGroups.count) {
        [self _displayAlertWithTitle:@"Missing users." subtitle:@"Please select at least one user to send to."];
    } else if (self.subjectTextField.text.length == 0) {
        [self _displayAlertWithTitle:@"Missing subject." subtitle:@"Please fill in the subject line."];
    } else {
        NSArray *emailGroups = _emailGroupViewController.selectedGroups;
        WLGmailAddress *fromAddress = [[WLGmailAddress alloc] initWithEmailAddress:_gmailService.emailAddress name:_gmailService.emailAddress];
        for (SNSEmailGroup *group in emailGroups) {
            WLGmailAddress *toAddress = [[WLGmailAddress alloc] initWithEmailAddress:group.email name:group.name];
            WLGmailMessage *message = [[WLGmailMessage alloc] initWithSubject:self.subjectTextField.text body:@"" from:fromAddress to:toAddress];
            [_gmailService sendEmail:message completionBlock:^(NSError *error) {
                if (error) {
                    NSLog(@"Failed to send email: %@", error);
                }
            }];
        }
        [self.view endEditing:YES];
        self.subjectTextField.text = @"";
    }
}

#pragma mark - Private

- (void)_displayAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:subtitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
