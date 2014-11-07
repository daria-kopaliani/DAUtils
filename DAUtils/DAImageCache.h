//
//  DAImageCache.h
//  DAImageCache
//
//  Created by Daria Kopaliani on 7/18/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAImageCache : NSObject

+ (instancetype)sharedImageCache;

- (NSString *)imagesDirectoryPath;
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key;
- (void)loadImageForKey:(NSString *)key completion:(void (^)(UIImage *image, NSString *key))completion;
- (void)purgeMemoryCache;
- (void)saveImage:(UIImage *)image forKey:(NSString *)key saveToDisk:(BOOL)saveToDisk;

@end
