//
//  DAKeyboardObserver.h
//  Pods
//
//  Created by Daria Kopaliani on 9/22/13.
//
//

#import <Foundation/Foundation.h>

@interface DAKeyboardObserver : NSObject

@property (readonly, assign, nonatomic, getter = isKeyboardVisible) BOOL keyboardVisible;

+ (instancetype)sharedObserver;

@end
