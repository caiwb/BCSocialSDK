//
//  BCShareObject.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

extern char *constProperties[];

extern NSArray *stringProperties;

@interface BCShareObject : NSObject

@property (nonatomic, strong) NSString *text;

@end

@interface BCShareWebObject : BCShareObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) UIImage *thumbImage;

@end

@interface BCShareImageObject : BCShareWebObject

@property (nonatomic, strong) NSData *imageData;

@end

@interface BCShareMusicObject : BCShareWebObject

@property (nonatomic, strong) NSString *musicUrl;

@end

@interface BCShareVideoObject : BCShareWebObject

@property (nonatomic, strong) NSString *videoUrl;

@end
