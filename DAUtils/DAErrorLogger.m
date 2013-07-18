//
//  DAErrorLogger.m
//  Beat
//
//  Created by Daria Kopaliani on 1/30/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

#import "DAErrorLogger.h"

BOOL const BELoggingErrors = 1;
BOOL const BELoggingCoreDataErrors = 1;
BOOL const BELoggingFileErrors = 1;
BOOL const BELoggingNetworkErrors = 1;
BOOL const BELoggingErrorMessages = 1;
BOOL const BELoggingParseErrors = 1;

@interface DAErrorLogger ()

+ (void)logDetailedErrorDescription:(NSError *)error;

@end

@implementation DAErrorLogger

+ (void)logError:(NSError *)error
{
    if (BELoggingErrors && error) {
        [self logDetailedErrorDescription:error];
    }
}

+ (void)logCoreDataError:(NSError *)error
{
    if (BELoggingCoreDataErrors && error) {
        [self logDetailedErrorDescription:error];
    }
}

+ (void)logFileError:(NSError *)error
{
    if (BELoggingFileErrors && error) {
        [self logDetailedErrorDescription:error];
    }
}

+ (void)logNetworkError:(NSError *)error
{
    if (BELoggingNetworkErrors && error) {
        [self logDetailedErrorDescription:error];
    }
}

+ (void)logErrorMessage:(NSString *)errorMessage
{
    if (BELoggingErrorMessages) {
        NSLog(@"%@", errorMessage);
    }
}

+ (void)logSavingContextErrorMessage
{
    if (BELoggingErrorMessages) {
        NSLog(@"could not save context (mainThread - %d)", [[NSThread currentThread] isMainThread]);
    }
}

#pragma mark - Private

+ (void)logDetailedErrorDescription:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

@end