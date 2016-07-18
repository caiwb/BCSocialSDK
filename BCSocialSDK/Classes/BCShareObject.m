//
//  BCShareObject.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <objc/runtime.h>

#import "BCShareObject.h"

char *constProperties[] = {"text", "title", "webUrl", "thumbImage", "imageData", "musicUrl", "videoUrl"};

NSArray *stringProperties = nil;

@implementation BCShareObject

+ (void)initialize
{
    if (!stringProperties)
    {
        stringProperties = @[@"text", @"title", @"webUrl", @"thumbImage", @"imageData", @"musicUrl", @"videoUrl"];
    }
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    objc_setAssociatedObject(self, "text", text, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BCShareWebObject

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    objc_setAssociatedObject(self, "title", title, OBJC_ASSOCIATION_RETAIN);
}

- (void)setWebUrl:(NSString *)webUrl
{
    _webUrl = webUrl;
    
    objc_setAssociatedObject(self, "webUrl", webUrl, OBJC_ASSOCIATION_RETAIN);
}

- (void)setThumbImage:(UIImage *)thumbImage
{
    _thumbImage = thumbImage;
    
    objc_setAssociatedObject(self, "thumbImage", thumbImage, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BCShareImageObject

- (void)setImageData:(NSData *)imageData
{
    _imageData = imageData;
    
    objc_setAssociatedObject(self, "imageData", imageData, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BCShareMusicObject

- (void)setMusicUrl:(NSString *)musicUrl
{
    _musicUrl = musicUrl;
    
    objc_setAssociatedObject(self, "musicUrl", musicUrl, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BCShareVideoObject

- (void)setVideoUrl:(NSString *)videoUrl
{
    _videoUrl = videoUrl;
    
    objc_setAssociatedObject(self, "videoUrl", videoUrl, OBJC_ASSOCIATION_RETAIN);
}

@end