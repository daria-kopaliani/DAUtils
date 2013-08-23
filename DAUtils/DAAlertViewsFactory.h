//
//  DAAlertViewsFactory.h
//
//
//  Created by Daria Kopaliani on 7/19/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAAlertViewsFactory : NSObject

+ (instancetype)sharedFactory;

- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey;
- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey
                   completion:(void (^)(UIAlertView *sender, NSInteger clickedButtonIndex))completion;
- (void)showAlertWithTitleKey:(NSString *)titleKey messageKey:(NSString *)messageKey dismissKey:(NSString *)dismissKey actionKey:(NSString *)actionKey
                invertButtons:(BOOL)shouldInvertButtons
                   completion:(void (^)(UIAlertView *sender, NSInteger clickedButtonIndex))completion;

@end
