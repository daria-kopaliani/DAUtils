//
//  DADDValue.h
//  Beat
//
//  Created by Daria Kopaliani on 1/18/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DADDValue : NSObject

+ (CGFloat)CGFloatWithIPadValue:(CGFloat)iPadValue iPhone3_5InchValue:(CGFloat)iPhone3_5InchValue iPhone4InchValue:(CGFloat)iPhone4InchValue;
+ (CGFloat)CGFloatWithIPadValue:(CGFloat)iPadValue iPhoneValue:(CGFloat)iPhoneValue;
+ (CGFloat)CGFloatWithIPhone3_5InchValue:(CGFloat)iPhone3_5InchValue iPhone4InchValue:(CGFloat)iPhone4InchValue;

+ (CGPoint)CGPointWithIPadValue:(CGPoint)iPadValue iPhoneValue:(CGPoint)iPhoneValue;
+ (CGPoint)CGPointWithIPadValue:(CGPoint)iPadValue iPhone3_5InchValue:(CGPoint)iPhoneValue iPhone4InchValue:(CGPoint)iPhone4InchValue;
+ (CGPoint)CGPointWithIPhone3_5InchValue:(CGPoint)iPhone3_5InchValue iPhone4InchValue:(CGPoint)iPhone4InchValue;

+ (CGRect)CGRectWithIPadValue:(CGRect)iPadValue iPhone3_5InchValue:(CGRect)iPhoneValue iPhone4InchValue:(CGRect)iPhone4InchValue;
+ (CGRect)CGRectWithIPadValue:(CGRect)iPadValue iPhoneValue:(CGRect)iPhoneValue;

+ (CGSize)CGSizeWithIPadValue:(CGSize)iPadValue iPhoneValue:(CGSize)iPhoneValue;

+ (NSInteger)NSIntegerWithIPadValue:(NSInteger)iPadValue iPhone3_5InchValue:(NSInteger)iPhone3_5InchValue
                   iPhone4InchValue:(NSInteger)iPhone4InchValue;
+ (NSInteger)NSIntegerWithIPadValue:(NSInteger)iPadValue iPhoneValue:(NSInteger)iPhoneValue;

+ (NSString *)stringWithIPadValue:(NSString *)iPadValue iPhone3_5InchValue:(NSString *)iPhone3_5InchValue
                 iPhone4InchValue:(NSString *)iPhone4InchValue;
+ (NSString *)stringWithIPadValue:(NSString *)iPadValue iPhoneValue:(NSString *)iPhoneValue;

@end
