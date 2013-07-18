//
//  BEDDValue.m
//  Beat
//
//  Created by Daria Kopaliani on 1/18/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

#import "DADDValue.h"

#import "DAUtils.h"


@implementation DADDValue

#pragma mark - CGFloat

+ (CGFloat)CGFloatWithIPadValue:(CGFloat)iPadValue iPhone3_5InchValue:(CGFloat)iPhone3_5InchValue iPhone4InchValue:(CGFloat)iPhone4InchValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : [BEUtils is3_5InchIPhone] ? iPhone3_5InchValue : iPhone4InchValue;
}

+ (CGFloat)CGFloatWithIPadValue:(CGFloat)iPadValue iPhoneValue:(CGFloat)iPhoneValue
{
    return [self CGFloatWithIPadValue:iPadValue iPhone3_5InchValue:iPhoneValue iPhone4InchValue:iPhoneValue];
}

+ (CGFloat)CGFloatWithIPhone3_5InchValue:(CGFloat)iPhone3_5InchValue iPhone4InchValue:(CGFloat)iPhone4InchValue
{
    return [BEUtils is4InchIPhone] ? iPhone4InchValue : iPhone3_5InchValue;
}

#pragma mark - CGPoint

+ (CGPoint)CGPointWithIPadValue:(CGPoint)iPadValue iPhoneValue:(CGPoint)iPhoneValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : iPhoneValue;
}

+ (CGPoint)CGPointWithIPadValue:(CGPoint)iPadValue iPhone3_5InchValue:(CGPoint)iPhoneValue iPhone4InchValue:(CGPoint)iPhone4InchValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : [BEUtils is4InchIPhone] ? iPhone4InchValue : iPhoneValue;
}

+ (CGPoint)CGPointWithIPhone3_5InchValue:(CGPoint)iPhone3_5InchValue iPhone4InchValue:(CGPoint)iPhone4InchValue
{
    return [BEUtils is4InchIPhone] ? iPhone4InchValue : iPhone3_5InchValue;
}

#pragma mark - CGRect

+ (CGRect)CGRectWithIPadValue:(CGRect)iPadValue iPhone3_5InchValue:(CGRect)iPhoneValue iPhone4InchValue:(CGRect)iPhone4InchValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : [BEUtils is4InchIPhone] ? iPhone4InchValue : iPhoneValue;
}

+ (CGRect)CGRectWithIPadValue:(CGRect)iPadValue iPhoneValue:(CGRect)iPhoneValue
{
    return [self CGRectWithIPadValue:iPadValue iPhone3_5InchValue:iPhoneValue iPhone4InchValue:iPhoneValue];
}

#pragma mark - CGSize

+ (CGSize)CGSizeWithIPadValue:(CGSize)iPadValue iPhoneValue:(CGSize)iPhoneValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : iPhoneValue;
}

#pragma mark - NSInteger

+ (NSInteger)NSIntegerWithIPadValue:(NSInteger)iPadValue iPhone3_5InchValue:(NSInteger)iPhone3_5InchValue iPhone4InchValue:(NSInteger)iPhone4InchValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : [BEUtils is3_5InchIPhone] ? iPhone3_5InchValue : iPhone4InchValue;
}

+ (NSInteger)NSIntegerWithIPadValue:(NSInteger)iPadValue iPhoneValue:(NSInteger)iPhoneValue
{
    return [self CGFloatWithIPadValue:iPadValue iPhone3_5InchValue:iPhoneValue iPhone4InchValue:iPhoneValue];
}


#pragma mark - NSString

+ (NSString *)stringWithIPadValue:(NSString *)iPadValue iPhone3_5InchValue:(NSString *)iPhone3_5InchValue
                 iPhone4InchValue:(NSString *)iPhone4InchValue
{
    return [BEUtils deviceIdiomIPad] ? iPadValue : [BEUtils is4InchIPhone] ? iPhone4InchValue : iPhone3_5InchValue;
}

+ (NSString *)stringWithIPadValue:(NSString *)iPadValue iPhoneValue:(NSString *)iPhoneValue
{
    return [self stringWithIPadValue:iPadValue iPhone3_5InchValue:iPhoneValue iPhone4InchValue:iPhoneValue];
}

@end