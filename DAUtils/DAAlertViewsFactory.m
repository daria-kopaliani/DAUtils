//
//  DAAlertViewsFactory.m
//
//
//  Created by Daria Kopaliani on 7/19/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAAlertViewsFactory.h"

#import <objc/runtime.h>


@interface DAAlertViewsFactory () <UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *authenticationErrorAlertView;

@end


@implementation DAAlertViewsFactory

+ (instancetype)sharedFactory
{
    static dispatch_once_t predicate;
    static DAAlertViewsFactory *factory = nil;
    
    dispatch_once(&predicate, ^{
        factory = [[self alloc] init];
    });
    return factory;
}

- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey
{
    [self showAlertWithTitleKey:titleKey messageKey:messageKey dismissKey:dismissKey completion:nil];
}

- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey
                   completion:(void (^)(void))completion
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil)
                                                        message:NSLocalizedString(messageKey, nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString((dismissKey ? dismissKey : @"Generic_btn_dismiss"), nil)
                                              otherButtonTitles:nil];
    objc_setAssociatedObject(alertView, @"cancellation", completion, OBJC_ASSOCIATION_COPY);
    [alertView show];
}

- (void)showAuthenticationErrorAlertViewWithCompletionHandler:(void (^)(void))completionHandler
{
    if (!_authenticationErrorAlertView) {
        _authenticationErrorAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                                   message:NSLocalizedString(@"Generic_alertMessage_authenticationError", nil)
                                                                  delegate:self
                                                         cancelButtonTitle:NSLocalizedString(@"Generic_btn_dismiss", nil)
                                                         otherButtonTitles:nil];
        objc_setAssociatedObject(_authenticationErrorAlertView, @"cancellation", completionHandler, OBJC_ASSOCIATION_COPY);
    }
    [self.authenticationErrorAlertView show];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        void (^nonCancelCallback)(BOOL disableStreamingOnWifiOnly) = objc_getAssociatedObject(alertView, @"completion");
        if (nonCancelCallback) {
            [nonCancelCallback invoke];
        }
    } else {
        void (^cancelCallback)(BOOL disableStreamingOnWifiOnly) = objc_getAssociatedObject(alertView, @"cancellation");
        if (cancelCallback) {
            [cancelCallback invoke];
        }
    }
}

@end