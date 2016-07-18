//
//  BCLoginHandler.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, BCSocialLoginType)
{
    BCQQ,
    BCWeibo,
    BCWechat
};

@interface BCUser : NSObject

@end


@interface BCLoginHandler : NSObject

@property (nonatomic, assign) BOOL setWXSuc;
@property (nonatomic, assign) BOOL setWBSuc;
@property (nonatomic, assign) BOOL setQQSuc;

//设置是否每次登录都需要重新授权
@property (nonatomic, assign) BOOL reAuthorize;

+ (instancetype)sharedInstance;

- (void)loginOnType:(BCSocialLoginType)type withCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete;

- (void)getUserInfo:(BCSocialLoginType)type withCompleteBlock:(void(^)(BOOL suc, BCUser *user))complete;

@end
