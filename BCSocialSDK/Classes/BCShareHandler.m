//
//  BCShareHandler.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <objc/runtime.h>

#import "BCShareHandler.h"
#import "BCShareObject.h"
#import "BCLoginHandler.h"
#import "BCShareView.h"

#import <BCWeiboShareActivity/BCWBShareProvider.h>
#import <BCWechatShareActivity/BCWXShareProvider.h>
#import <BCQQShareActivity/BCQQShareProvider.h>

#import <BCWeiboShareActivity/BCWBActivity.h>
#import <BCWechatShareActivity/BCWXSessionActivity.h>
#import <BCWechatShareActivity/BCWXTimelineActivity.h>
#import <BCQQShareActivity/BCQQSessionActivity.h>
#import <BCQQShareActivity/BCQQZoneActivity.h>

@implementation BCShareHandler

+ (void)shareObject:(BCShareObject *)shareObject toPlatform:(BCSocialShareType)type complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    if ([NSStringFromClass([shareObject class]) isEqualToString:@"BCShareObject"])
    {
        switch (type)
        {
            case WECHAT_SESSION:
            case WECHAT_TIMELINE:
            {
                [BCWXShareProvider shareText:type == WECHAT_SESSION ? BCWX_SESSION : BCWX_TIMELINE text:shareObject.text complete:complete];
            }
                break;
            case QQ_SESSION:
            case QQ_ZONE:
            {
                [BCQQShareProvider shareText:type == QQ_SESSION ? BCQQ_SESSION : BCQQ_ZONE text:shareObject.text complete:complete];
            }
                break;
            case WEIBO:
            {
                [BCWBShareProvider shareText:shareObject.text complete:complete];
            }
                break;
        }
    }
    else if ([NSStringFromClass([shareObject class]) isEqualToString:@"BCShareWebObject"])
    {
        BCShareWebObject *wShareObject = (BCShareWebObject *)shareObject;
        
        switch (type)
        {
            case WECHAT_SESSION:
            case WECHAT_TIMELINE:
            {
                [BCWXShareProvider shareWebPage:type == WECHAT_SESSION ? BCWX_SESSION : BCWX_TIMELINE
                                      withTitle:wShareObject.title
                                           text:wShareObject.text
                                          image:wShareObject.thumbImage
                                         webUrl:wShareObject.webUrl
                                       complete:complete];
            }
                break;
            case QQ_SESSION:
            case QQ_ZONE:
            {
                [BCQQShareProvider shareWebPage:type == QQ_SESSION ? BCQQ_SESSION : BCQQ_ZONE
                                      withTitle:wShareObject.title
                                           text:wShareObject.text
                                     thumbImage:wShareObject.thumbImage
                                         webUrl:wShareObject.webUrl
                                       complete:complete];
            }
                break;
            case WEIBO:
            {
                [BCWBShareProvider shareWebPage:wShareObject.webUrl
                                      withTitle:wShareObject.title
                                           text:wShareObject.text
                                     thumbImage:wShareObject.thumbImage
                                       complete:complete];
            }
                break;
        }
    }
    else if ([NSStringFromClass([shareObject class]) isEqualToString:@"BCShareImageObject"])
    {
        BCShareImageObject *iShareObject = (BCShareImageObject *)shareObject;
        
        switch (type)
        {
            case WECHAT_SESSION:
            case WECHAT_TIMELINE:
            {
                [BCWXShareProvider shareImage:type == WECHAT_SESSION ? BCWX_SESSION : BCWX_TIMELINE
                                    withTitle:iShareObject.title
                                         text:iShareObject.text
                                        image:iShareObject.thumbImage
                                    imageData:iShareObject.imageData
                                     complete:complete];
            }
                break;
            case QQ_SESSION:
            case QQ_ZONE:
            {
                [BCQQShareProvider shareImage:type == QQ_SESSION ? BCQQ_SESSION : BCQQ_ZONE
                                    withTitle:iShareObject.title
                                         text:iShareObject.text
                                   thumbImage:iShareObject.thumbImage
                               shareImageData:iShareObject.imageData
                                     complete:complete];
            }
                break;
            case WEIBO:
            {
                [BCWBShareProvider shareImage:iShareObject.imageData withText:iShareObject.text complete:complete];
            }
                break;
        }
    }
    else if ([NSStringFromClass([shareObject class]) isEqualToString:@"BCShareMusicObject"])
    {
        BCShareMusicObject *mShareObject = (BCShareMusicObject *)shareObject;
        
        switch (type)
        {
            case WECHAT_SESSION:
            case WECHAT_TIMELINE:
            {
                [BCWXShareProvider shareMusic:type == WECHAT_SESSION ? BCWX_SESSION : BCWX_TIMELINE
                                    withTitle:mShareObject.title
                                         text:mShareObject.text
                                        image:mShareObject.thumbImage
                                  musicWebUrl:mShareObject.webUrl
                                     musicUrl:mShareObject.musicUrl
                                     complete:complete];
            }
                break;
            case QQ_SESSION:
            case QQ_ZONE:
            {
                [BCQQShareProvider shareMusic:type == QQ_SESSION ? BCQQ_SESSION : BCQQ_ZONE
                                    withTitle:mShareObject.title
                                         text:mShareObject.text
                                   thumbImage:mShareObject.thumbImage
                                  musicWebUrl:mShareObject.webUrl
                                     musicUrl:mShareObject.musicUrl
                                     complete:complete];
            }
                break;
            case WEIBO:
            {
                [BCWBShareProvider shareMusic:mShareObject.musicUrl
                              withMusicWebUrl:mShareObject.webUrl
                                        title:mShareObject.title
                                         text:mShareObject.text
                                   thumbImage:mShareObject.thumbImage
                                     complete:complete];
            }
                break;
        }
    }
    else if ([NSStringFromClass([shareObject class]) isEqualToString:@"BCShareVideoObject"])
    {
        BCShareVideoObject *vShareObject = (BCShareVideoObject *)shareObject;
        
        switch (type)
        {
            case WECHAT_SESSION:
            case WECHAT_TIMELINE:
            {
                [BCWXShareProvider shareVideo:type == WECHAT_SESSION ? BCWX_SESSION : BCWX_TIMELINE

                                    withTitle:vShareObject.title
                                         text:vShareObject.text
                                        image:vShareObject.thumbImage
                                  videoWebUrl:vShareObject.webUrl
                                     complete:complete];
            }
                break;
            case QQ_SESSION:
            case QQ_ZONE:
            {
                [BCQQShareProvider shareVideo:type == QQ_SESSION ? BCQQ_SESSION : BCQQ_ZONE
                                    withTitle:vShareObject.title
                                         text:vShareObject.text
                                   thumbImage:vShareObject.thumbImage
                                  videoWebUrl:vShareObject.webUrl
                                     videoUrl:vShareObject.videoUrl
                                     complete:complete];
            }
                break;
            case WEIBO:
            {
                [BCWBShareProvider shareVideo:vShareObject.videoUrl
                              withVideoWebUrl:vShareObject.webUrl
                                        title:vShareObject.title
                                         text:vShareObject.text
                                   thumbImage:vShareObject.thumbImage
                                     compelet:complete];
            }
                break;
        }
    }
    else if (complete)
    {
        complete(NO, @"object error");
    }
}

+ (void)shareObjectByActivityViewController:(BCShareObject *)shareObject onViewController:(UIViewController *)viewController complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    BCWXSessionActivity *wechat = [BCWXSessionActivity new];
    BCWXTimelineActivity *wechatTimeline = [BCWXTimelineActivity new];
    BCQQSessionActivity *qq = [BCQQSessionActivity new];
    BCQQZoneActivity *qqZone = [BCQQZoneActivity new];
    BCWBActivity *weibo = [BCWBActivity new];
    
    NSArray<NSString *> *propertyNames = [self getAllPropertyNames:[shareObject class]];
    
    NSMutableArray *activityItems = [NSMutableArray new];
    
    for (NSString *propertyName in propertyNames)
    {
        int idx = 0;
        for (NSString *property in stringProperties)
        {
            if ([property isEqualToString:propertyName])
            {
                break;
            }
            idx ++;
        }
        id value = objc_getAssociatedObject(shareObject, constProperties[idx]);
        
        [activityItems addObject:value];
        
        objc_setAssociatedObject(wechat, constProperties[idx], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(wechatTimeline, constProperties[idx], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(qq, constProperties[idx], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(qqZone, constProperties[idx], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(weibo, constProperties[idx], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    wechat.completeBlock = complete;
    wechatTimeline.completeBlock = complete;
    qq.completeBlock = complete;
    qqZone.completeBlock = complete;
    weibo.completeBlock = complete;
    
    NSMutableArray *activties = [NSMutableArray new];
    
    if ([BCLoginHandler sharedInstance].setWXSuc)
    {
        [activties addObjectsFromArray:@[wechat, wechatTimeline]];
    }
    if ([BCLoginHandler sharedInstance].setQQSuc)
    {
        [activties addObject:qq];
        if (![propertyNames containsObject:@"imageData"] && [propertyNames containsObject:@"webUrl"])
        {
            [activties addObject:qqZone];
        }
    }
    if ([BCLoginHandler sharedInstance].setWBSuc)
    {
        [activties addObject:weibo];
    }
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activties];
    activityViewController.excludedActivityTypes = @[ UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
    
    [viewController presentViewController:activityViewController animated:YES completion:nil];
}


+ (void)shareObjectByBCShareView:(BCShareObject *)shareObject
{
    [self shareObjectByBCShareView:shareObject actionBlock:nil complete:nil];
}


+ (void)shareObjectByBCShareView:(BCShareObject *)shareObject actionBlock:(void (^)(BCSocialShareType type))action complete:(void (^)(BOOL suc, NSString *errMsg))complete
{
    BCShareView *shareView = [[BCShareView alloc] initWithShareObject:shareObject];
    shareView.completeBlock = complete;
    shareView.actionBlock = action;
    
    [[self getViewController].view addSubview:shareView];
}

+ (UIViewController *)getViewController
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *win in windows)
        {
            if (win.windowLevel == UIWindowLevelNormal)
            {
                window = win;
                break;
            }
        }
    }
    
    if ([window subviews].count)
    {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return nextResponder;
        }
    }
    
    return window.rootViewController;
}


+ (NSArray *)getAllPropertyNames:(Class)klass
{
    u_int count;
    
    NSMutableArray *propertiesArray = [NSMutableArray new];
    
    while (klass != [NSObject class])
    {
        objc_property_t *properties = class_copyPropertyList(klass, &count);
        
        for (int i = 0; i < count; i ++)
        {
            const char *propertyName = property_getName(properties[i]);
            [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        }
        
        free(properties);
        
        klass = [klass superclass];
    }
    
    return propertiesArray;
}

@end
