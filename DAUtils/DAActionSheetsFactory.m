//
//  DAActionSheetsFactory.m
//
//
//  Created by Daria Kopaliani on 7/31/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAActionSheetsFactory.h"

#import <objc/runtime.h>


@interface DAActionSheetsFactory () <UIActionSheetDelegate>

@end

@implementation DAActionSheetsFactory

+ (instancetype)sharedFactory
{
    static dispatch_once_t predicate;
    static DAActionSheetsFactory *factory = nil;
    
    dispatch_once(&predicate, ^{
        factory = [[self alloc] init];
    });
    return factory;
}

- (UIActionSheet *)actionSheetWithTitleKey:(NSString *)titleKey cancelButtonTitleKey:(NSString *)cancelButtonTitleKey destructiveButtonTitleKey:(NSString *)destructiveButtonTitleKey otherButtonTitleKeys:(NSArray *)otherButtonTitleKeys completionHandler:(void (^)(NSInteger clickedButtonIndex))completionHandler
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:(titleKey) ? NSLocalizedString(titleKey, nil) : nil
                                                            delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:(destructiveButtonTitleKey) ? NSLocalizedString(destructiveButtonTitleKey, nil) : nil
                                                   otherButtonTitles:nil];
    for (NSInteger i = 0; i < otherButtonTitleKeys.count; i++) {
        NSString *key = SAFE_CAST(otherButtonTitleKeys[i], NSString);
        if (key) {
            [actionSheet addButtonWithTitle:NSLocalizedString(key, nil)];
        }
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:NSLocalizedString(cancelButtonTitleKey, nil)];
    objc_setAssociatedObject(actionSheet, @"completionHandler", completionHandler, OBJC_ASSOCIATION_COPY);
    return actionSheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^completionHandler)(NSInteger clickedButtonIndex) = objc_getAssociatedObject(actionSheet, @"completionHandler");
    if (completionHandler) {
        completionHandler(buttonIndex);
    }
}

@end