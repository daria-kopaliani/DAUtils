//
//  DAActionSheetsFactory.h
//
//
//  Created by Daria Kopaliani on 7/31/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAActionSheetsFactory : NSObject

+ (instancetype)sharedFactory;

- (UIActionSheet *)actionSheetWithTitleKey:(NSString *)titleKey cancelButtonTitleKey:(NSString *)cancelButtonTitleKey destructiveButtonTitleKey:(NSString *)destructiveButtonTitleKey otherButtonTitleKeys:(NSArray *)otherButtonTitleKeys completionHandler:(void (^)(NSInteger clickedButtonIndex))completionHandler;

@end
