//
//  BCSocialConfig.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

@interface BCSocialConfig : NSObject

+ (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret;
+ (void)setQQAppId:(NSString *)appId;
+ (void)setSinaAppKey:(NSString *)appKey redirectURL:(NSString *)redirectURI;

+ (BOOL)socialHandleOpenURL:(NSURL *)url;

@end
