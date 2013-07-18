//
//  DAErrorLogger.h
//  Beat
//
//  Created by Daria Kopaliani on 1/30/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAErrorLogger : NSObject

+ (void)logError:(NSError *)error;
+ (void)logCoreDataError:(NSError *)error;
+ (void)logFileError:(NSError *)error;
+ (void)logNetworkError:(NSError *)error;
+ (void)logErrorMessage:(NSString *)errorMessage;
+ (void)logSavingContextErrorMessage;

@end
