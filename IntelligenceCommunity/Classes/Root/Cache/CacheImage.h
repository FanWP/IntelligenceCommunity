//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^ImageCacheDownloader)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^ImageCacheDownloaderCompletion)(UIImage *image, NSError *error, NSURL *imageURL);

@interface UIImageView (Cache)

-(void)load:(NSString*)urlString;
-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image;
-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image progress:(ImageCacheDownloader)progress;
-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image progress:(ImageCacheDownloader)progress completed:(ImageCacheDownloaderCompletion)completed;


@end




@interface CacheImage : NSObject

+(NSUInteger)getSize;
+(void)clearDisk:(void(^)(void))completion;
+(void)storeImage:(UIImage*)image forKey:(NSString*)key;
+(UIImage*)imageFromKey:(NSString*)key;
+(void)removeImageForKey:(NSString*)key;
+(void)imageExistsWithKey:(NSString*)key;

@end
