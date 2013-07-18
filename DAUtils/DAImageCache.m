//
//  DAImageCache.m
//  DAImageCache
//
//  Created by Daria Kopaliani on 7/18/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAImageCache.h"

#import "DAErrorLogger.h"

@interface DAImageCache () {
    dispatch_queue_t _queue;
}

@property (strong, nonatomic) NSMutableDictionary *memoryCache;

@end


@implementation DAImageCache

#pragma mark - Initialization

+ (instancetype)sharedImageCache
{
    static dispatch_once_t predicate;
    static DAImageCache *imageCache = nil;
    
    dispatch_once(&predicate, ^{
        imageCache = [[self alloc] init];
    });
    return imageCache;
}

- (id)init
{
    self = [super init];
    if (self) {
		_queue = dispatch_queue_create("com.dck.DAImageCache", NULL);
        self.memoryCache = [[NSMutableDictionary alloc] init];
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleMemoryWarningNotification:)
													 name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - Public

- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key
{
    @synchronized (self) {
        return [self.memoryCache objectForKey:key];
    }
}

- (void)loadImageForKey:(NSString *)key completion:(void (^)(UIImage *image, NSString *key))completion
{
    UIImage *image;
    @synchronized (self) {
        image = [self imageFromMemoryCacheForKey:key];
    }
    if (image) {
        completion(image, key);
    } else {
        dispatch_async(_queue, ^{
            NSString *imageFilePath = [self filePathWithKey:key];
            UIImage *imageFromDisk = [UIImage imageWithContentsOfFile:imageFilePath];
            UIImage *imageInMemory = nil;
            if (imageFromDisk) {
                imageInMemory = imageFromDisk;
                if (imageInMemory) {
                    @synchronized (self) {
                        [self.memoryCache setObject:imageInMemory forKey:key];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(imageInMemory, key);
            });
        });
    }
}

- (void)purgeMemoryCache
{
	@synchronized (self) {
        [DAErrorLogger logErrorMessage:@"Purging memory cache"];
		[self.memoryCache removeAllObjects];
	}
}

- (void)saveImage:(UIImage *)image forKey:(NSString *)key saveToDisk:(BOOL)saveToDisk
{
    if (image && key) {
        @synchronized (self) {
            [self.memoryCache setObject:image forKey:key];
        }
        if (saveToDisk) {
            dispatch_async(_queue, ^{
                [[NSFileManager defaultManager] createFileAtPath:[self filePathWithKey:key]
                                                        contents:UIImageJPEGRepresentation(image, 0.8)
                                                      attributes:nil];
            });
        }
    }
}

#pragma mark - Private

- (NSString *)filePathWithKey:(NSString *)key
{
//    NSString *fileName = [key stringByReplacingOccurrencesOfString:BEServerURL withString:@""];
	NSString *fileName = [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	return [[self imagesDirectoryPath] stringByAppendingPathComponent:fileName];
}
- (void)handleMemoryWarningNotification:(NSNotification *)notification
{
    [self purgeMemoryCache];
}


- (NSString *)imagesDirectoryPath
{
    static NSString *imagesDirectoryPath = nil;
    if (!imagesDirectoryPath) {
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        imagesDirectoryPath = [documentsPath stringByAppendingPathComponent:@"Images"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:imagesDirectoryPath]) {
            NSError *error = nil;
            [fileManager createDirectoryAtPath:imagesDirectoryPath withIntermediateDirectories:NO attributes:nil error:&error];
            [DAErrorLogger logFileError:error];
        }
    }
    return imagesDirectoryPath;
}

@end