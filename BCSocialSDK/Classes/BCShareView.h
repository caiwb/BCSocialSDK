//
//  BCShareView.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <UIKit/UIKit.h>

#import "BCShareObject.h"
#import "BCShareHandler.h"

@interface BCShareView : UIView

- (instancetype)initWithShareObject:(BCShareObject *)shareObject;

@property (nonatomic, strong) void(^actionBlock) (BCSocialShareType type);
@property (nonatomic, strong) void(^completeBlock) (BOOL suc, NSString *errMsg);

@end

