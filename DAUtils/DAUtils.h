//
//  DAUtils.h
//
//  Created by Daria Kopaliani on 1/18/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

@interface DAUtils : NSObject

+ (instancetype)sharedUtils;

+ (BOOL)canSendSMS;
+ (BOOL)deviceIdiomIPad;
+ (BOOL)deviceHasRetinaDisplay;
+ (NSString *)documentsDirectoryPath;
+ (NSURL *)documentsDirectoryURL;
+ (BOOL)isDeviceSystemVersionIsPriorToiOS5;
+ (BOOL)isDeviceSystemVersionIsPriorToiOS6_1;
+ (BOOL)is4InchIPhone;
+ (BOOL)is3_5InchIPhone;
+ (BOOL)isIPad;
+ (BOOL)isIPhone;

@end

@interface DAUtils (Encoding)

+ (NSString *)dataBase64Encoding:(NSData *)data;

@end