//
//  BCAppDelegate.m
//  BCSocialSDK
//
//  Created by caiwenbo on 07/18/2016.
//  Copyright (c) 2016 caiwenbo. All rights reserved.
//

#import "BCAppDelegate.h"
#import "BCSocialConfig.h"

@implementation BCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupAppKeys];
    
    return YES;
}

- (void)setupAppKeys
{
    [BCSocialConfig setQQAppId:@"QQAppId"];
    [BCSocialConfig setWXAppId:@"WXAppId" appSecret:@"WXAppSecret"];
    [BCSocialConfig setWBAppKey:@"WBAppKey" redirectURI:@"WBRedirectURI"];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [BCSocialConfig socialHandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [BCSocialConfig socialHandleOpenURL:url];
}

@end
