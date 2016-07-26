//
//  BCShareHandler.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

#import "BCShareObject.h"

typedef NS_OPTIONS(NSUInteger, BCSocialShareType)
{
    QQ_SESSION = 0,
    QQ_ZONE = 1,
    WEIBO = 2,
    WECHAT_SESSION = 3,
    WECHAT_TIMELINE = 4
};

@interface BCShareHandler : NSObject

+ (void)shareObject:(BCShareObject *)shareObject toPlatform:(BCSocialShareType)type complete:(void (^)(BOOL suc, NSString *errMsg))complete;

+ (void)shareObjectByActivityViewController:(BCShareObject *)shareObject onViewController:(UIViewController *)viewController complete:(void (^)(BOOL suc, NSString *errMsg))complete;

+ (void)shareObjectByBCShareView:(BCShareObject *)shareObject;

+ (void)shareObjectByBCShareView:(BCShareObject *)shareObject actionBlock:(void (^)(BCSocialShareType type))action complete:(void (^)(BOOL suc, NSString *errMsg))complete;

@end
