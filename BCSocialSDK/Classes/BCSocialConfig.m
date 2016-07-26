//
//  BCSocialConfig.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCSocialConfig.h"
#import "BCLoginHandler.h"
#import <BCWeiboShareActivity/BCWBSocialHandler.h>
#import <BCWechatShareActivity/BCWXSocialHandler.h>
#import <BCQQShareActivity/BCQQSocialHandler.h>

@implementation BCSocialConfig

+ (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret
{
    [BCLoginHandler sharedInstance].setWXSuc = [[BCWXSocialHandler sharedInstance] setWXAppId:appId appSecret:appSecret];
}

+ (void)setQQAppId:(NSString *)appId
{
    [BCLoginHandler sharedInstance].setQQSuc = YES;
    [[BCQQSocialHandler sharedInstance] setQQAppId:appId];
}

+ (void)setWBAppKey:(NSString *)appKey redirectURI:(NSString *)redirectURI
{
    [BCLoginHandler sharedInstance].setWBSuc = [[BCWBSocialHandler sharedInstance] setWBAppKey:appKey redirectURI:redirectURI];
}

+ (BOOL)socialHandleOpenURL:(NSURL *)url
{
    NSString *urlString = url.absoluteString;
    
    if ([urlString hasPrefix:@"wx"])
    {
        return [[BCWXSocialHandler sharedInstance] handleOpenURL:url];
    }
    else if ([urlString hasPrefix:@"sina"] || [urlString hasPrefix:@"wb"])
    {
        return [[BCWBSocialHandler sharedInstance] handleOpenURL:url];
    }
    else if ([urlString hasPrefix:@"tencent"] || [urlString hasPrefix:@"QQ"] || [urlString hasPrefix:@"qq"])
    {
        return [[BCQQSocialHandler sharedInstance] handleOpenURL:url];
    }
    
    return NO;
}

@end
