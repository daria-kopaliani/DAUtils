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
    [self showAlertWithTitleKey:titleKey messageKey:messageKey dismissKey:dismissKey actionKey:nil invertButtons:NO completion:nil];
}

- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey
                   completion:(void (^)(UIAlertView *sender, NSInteger clickedButtonIndex))completion
{
    [self showAlertWithTitleKey:titleKey messageKey:messageKey dismissKey:dismissKey actionKey:nil invertButtons:NO completion:completion];
}

- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey actionKey:(NSString *)actionKey
                invertButtons:(BOOL)shouldInvertButtons
                   completion:(void (^)(UIAlertView *sender, NSInteger clickedButtonIndex))completion
{
    UIAlertView *alertView = nil;
    if (actionKey) {
        NSString *cancelButtonTitle = (shouldInvertButtons) ? NSLocalizedString(actionKey, nil) : NSLocalizedString(dismissKey, nil);
        NSString *actionButtonTitle = (shouldInvertButtons) ? NSLocalizedString(dismissKey, nil) : NSLocalizedString(actionKey, nil);
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil)
                                               message:NSLocalizedString(messageKey, nil)
                                              delegate:self
                                     cancelButtonTitle:cancelButtonTitle
                                     otherButtonTitles:actionButtonTitle, nil];
        objc_setAssociatedObject(alertView, @"invertedButtons", [NSNumber numberWithBool:shouldInvertButtons], OBJC_ASSOCIATION_COPY);
    } else {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil)
                                               message:NSLocalizedString(messageKey, nil)
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(dismissKey, nil)
                                     otherButtonTitles:nil];
    }
    if (completion) {
        objc_setAssociatedObject(alertView, @"completion", completion, OBJC_ASSOCIATION_COPY);
    }
    [alertView show];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^callback)(UIAlertView *sender, NSInteger clickedButtonIndex) = objc_getAssociatedObject(alertView, @"completion");
    if (callback) {
        NSInteger clickedButtonIndex = buttonIndex;
        NSNumber *invertedButtons = objc_getAssociatedObject(alertView, @"invertedButtons");
        if ([invertedButtons boolValue]) {
            clickedButtonIndex = (buttonIndex == 0) ? 1 : 0;
        }
        callback(alertView, clickedButtonIndex);
    }
}

@end