//
//  DAUtils.m
//
//  Created by Daria Kopaliani on 1/18/13.
//  Copyright (c) Daria Kopaliani. All rights reserved.
//

#import "DAUtils.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <MessageUI/MessageUI.h>


typedef struct BEDeviceInfo {
    BOOL retinaDisplay;
    UIUserInterfaceIdiom deviceIdiom;
    BOOL deviceSystemVersionIsPriorToiOS5;
    BOOL deviceSystemVersionIsPriorToiOS6_1;
} BEDeviceInfo;

static NSString *DocumentsDirectoryPath;
static NSURL *DocumentsDirectoryURL;
static BEDeviceInfo DeviceInfo;

@implementation DAUtils

#pragma mark - Initialization

+ (void)initialize
{
	if (self == [DAUtils class]) {
        DeviceInfo.deviceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
        DeviceInfo.retinaDisplay = ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
                                    && [[UIScreen mainScreen] scale] == 2);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        DocumentsDirectoryPath = [paths objectAtIndex:0];
        NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        DocumentsDirectoryURL = [URLs lastObject];
        DeviceInfo.deviceSystemVersionIsPriorToiOS5 = [[UIDevice currentDevice].systemVersion floatValue] < 5.0;
        DeviceInfo.deviceSystemVersionIsPriorToiOS6_1 = [[UIDevice currentDevice].systemVersion floatValue] <= 6.0;
    }
}

+ (instancetype)sharedUtils
{
    static dispatch_once_t predicate;
    static DAUtils *utils = nil;
    
    dispatch_once(&predicate, ^{
        utils = [[self alloc] init];
    });
    return utils;
}

#pragma mark - Public

+ (BOOL)canSendSMS
{
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    return (carrier.allowsVOIP && messageClass != nil && [messageClass canSendText]);
}

+ (BOOL)deviceIdiomIPad
{
    return (DeviceInfo.deviceIdiom == UIUserInterfaceIdiomPad);
}

+ (BOOL)deviceHasRetinaDisplay
{
    return DeviceInfo.retinaDisplay;
}

+ (NSString *)documentsDirectoryPath
{
    return DocumentsDirectoryPath;
}

+ (NSURL *)documentsDirectoryURL
{
    return DocumentsDirectoryURL;
}

+ (BOOL)isDeviceSystemVersionIsPriorToiOS5
{
    return DeviceInfo.deviceSystemVersionIsPriorToiOS5;
}

+ (BOOL)isDeviceSystemVersionIsPriorToiOS6_1
{
    return DeviceInfo.deviceSystemVersionIsPriorToiOS6_1;
}

+ (BOOL)is4InchIPhone
{
	return ([UIScreen mainScreen].bounds.size.height == 568.);
}

+ (BOOL)is3_5InchIPhone
{
    return ([UIScreen mainScreen].bounds.size.height == 480.);
}

+ (BOOL)isIPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isIPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

@end

@implementation DAUtils (Encoding)

static char encodingTable[64] = {
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
	'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
	'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };


+ (NSString *)dataBase64Encoding:(NSData *)data
{
	const unsigned char	*bytes = (unsigned char	*)[data bytes];
	NSMutableString *result = [NSMutableString stringWithCapacity:[data length]];
	unsigned long ixtext = 0;
	unsigned long lentext = [data length];
	long ctremaining = 0;
	unsigned char inbuf[3], outbuf[4];
	short i = 0;
	short charsonline = 0, ctcopy = 0;
	unsigned long ix = 0;
	
	while (YES) {
		ctremaining = lentext - ixtext;
		if (ctremaining <= 0) break;
		
		for (i = 0; i < 3; i++) {
			ix = ixtext + i;
			if (ix < lentext) inbuf[i] = bytes[ix];
			else inbuf [i] = 0;
		}
		
		outbuf [0] = (inbuf [0] & 0xFC) >> 2;
		outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
		outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
		outbuf [3] = inbuf [2] & 0x3F;
		ctcopy = 4;
		
		switch (ctremaining) {
			case 1:
				ctcopy = 2;
				break;
			case 2:
				ctcopy = 3;
				break;
		}
		
		for (i = 0; i < ctcopy; i++)
			[result appendFormat:@"%c", encodingTable[outbuf[i]]];
		
		for (i = ctcopy; i < 4; i++)
			[result appendFormat:@"%c",'='];
		
		ixtext += 3;
		charsonline += 4;
	}
	
	return result;
}

@end
