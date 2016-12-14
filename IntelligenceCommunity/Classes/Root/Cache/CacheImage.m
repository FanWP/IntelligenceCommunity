//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//


#import "CacheImage.h"
#import <SDWebimage/UIImageView+WebCache.h>

@implementation UIImageView (Cache)

-(void)load:(NSString*)urlString {
    [self load:urlString placeholderImage:nil progress:nil completed:nil];
}

-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image {
    [self load:urlString placeholderImage:image progress:nil completed:nil];
}

-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image progress:(ImageCacheDownloader)progress {
    [self load:urlString placeholderImage:image progress:progress completed:nil];
}

-(void)load:(NSString*)urlString placeholderImage:(UIImage*)image progress:(ImageCacheDownloader)progress completed:(ImageCacheDownloaderCompletion)completed {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:image options:SDWebImageRetryFailed progress:progress completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(completed) {
            completed(image,error,imageURL);
        }
    }];
}

@end



@implementation CacheImage

+(SDImageCache*)manager {
    return [SDImageCache sharedImageCache];
}

+(NSUInteger)getSize {
    return [[self manager] getSize];
}

+(void)clearDisk:(void(^)(void))completion {
    [[self manager] clearDiskOnCompletion:completion];
}

+(void)storeImage:(UIImage*)image forKey:(NSString*)key {
    [[self manager] storeImage:image forKey:key];
}

+(UIImage*)imageFromKey:(NSString*)key {
    return [[self manager] imageFromDiskCacheForKey:key];
}

+(void)removeImageForKey:(NSString*)key {
    [[self manager] removeImageForKey:key];
}

+(void)imageExistsWithKey:(NSString*)key {
    [[self manager] diskImageExistsWithKey:key];
}

@end
