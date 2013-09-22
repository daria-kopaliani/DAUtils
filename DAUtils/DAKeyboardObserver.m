//
//  DAKeyboardObserver.m
//  Pods
//
//  Created by Daria Kopaliani on 9/22/13.
//
//

#import "DAKeyboardObserver.h"


@interface DAKeyboardObserver ()

@property (assign, nonatomic, getter = isKeyboardVisible) BOOL keyboardVisible;

@end


@implementation DAKeyboardObserver

+ (instancetype)sharedObserver
{
    static dispatch_once_t predicate;
    static DAKeyboardObserver *keyboardObserver = nil;
    
    dispatch_once(&predicate, ^{
        keyboardObserver = [[self alloc] init];
    });
    return keyboardObserver;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)keyboardDidHide:(NSNotification *)notification
{
    self.keyboardVisible = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.keyboardVisible = YES;
}

@end