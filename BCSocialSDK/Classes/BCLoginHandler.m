//
//  BCLoginHandler.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCLoginHandler.h"

#import <BCQQShareActivity/BCQQLoginProvider.h>
#import <BCWechatShareActivity/BCWXLoginProvider.h>
#import <BCWeiboShareActivity/BCWBLoginProvider.h>

#import <BCWeiboShareActivity/BCWBSocialHandler.h>
#import <BCWechatShareActivity/BCWXSocialHandler.h>
#import <BCQQShareActivity/BCQQSocialHandler.h>

@implementation BCLoginHandler

+ (instancetype)sharedInstance
{
    static BCLoginHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[BCLoginHandler alloc] init];
    });
    return handler;
}

- (void)loginOnType:(BCSocialLoginType)type withCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete
{
    NSParameterAssert(complete);
    
    switch (type)
    {
        case BCWechat:
        {
            [BCWXLoginProvider loginWithCompleteBlock:complete];
        }
            break;
        case BCWeibo:
        {
            [BCWBLoginProvider loginWithCompleteBlock:complete];
        }
            break;
        case BCQQ:
        {
            [BCQQLoginProvider loginWithCompleteBlock:complete];
        }
            break;
        default:
            break;
    }
}

- (void)getUserInfo:(BCSocialLoginType)type withCompleteBlock:(void (^)(BOOL, BCUser *))complete
{
    NSParameterAssert(complete);
    
    switch (type)
    {
        case BCWechat:
        {
            [BCWXLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, BCWXUserInfo *userInfo) {
                
                if (suc)
                {
                    BCUser *user = [BCUser new];
                    user.name = userInfo.nickname;
                    user.avatar = userInfo.headimgurl;
                    
                    complete(YES, user);
                }
                else
                {
                    complete(NO, nil);
                }
            }];
        }
            break;
        case BCWeibo:
        {
            [BCWBLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, WeiboUser *userInfo) {
                
                if (suc)
                {
                    BCUser *user = [BCUser new];
                    user.name = userInfo.name;
                    user.avatar = userInfo.avatarLargeUrl;
                    
                    complete(YES, user);
                }
                else
                {
                    complete(NO, nil);
                }
            }];
        }
            break;
        case BCQQ:
        {
            [BCQQLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, BCQQUserInfo *userInfo) {
                
                if (suc)
                {
                    BCUser *user = [BCUser new];
                    user.name = userInfo.nickName;
                    user.avatar = userInfo.avatar;
                    
                    complete(YES, user);
                }
                else
                {
                    complete(NO, nil);
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setReAuthorize:(BOOL)reAuthorize
{
    _reAuthorize = reAuthorize;
    
    [BCWXSocialHandler sharedInstance].reAuthorize = reAuthorize;
    [BCWBSocialHandler sharedInstance].reAuthorize = reAuthorize;
    [BCQQSocialHandler sharedInstance].reAuthorize = reAuthorize;
}


@end
