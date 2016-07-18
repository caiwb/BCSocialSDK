//
//  BCShareView.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCShareView.h"
#import "BCColor.h"
#import "BCLoginHandler.h"
#import <BCWeiboShareActivity/BCWBSocialHandler.h>
#import <BCWechatShareActivity/BCWXSocialHandler.h>
#import <BCQQShareActivity/BCQQSocialHandler.h>

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef px
#define px 1.0 / [UIScreen mainScreen].scale
#endif

@interface BCShareButton : UIButton

@property (nonatomic, assign) BCSocialShareType type;

@end

@implementation BCShareButton

- (void)centerImageAndTitle:(float)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

@end

@interface BCShareView ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGFloat btnsHeight;
@property (nonatomic, assign) NSUInteger showBtnsCount;
@property (nonatomic, strong) BCShareObject *shareObject;

@end

@implementation BCShareView
{
    UIControl *coverControl;
    UIView *btnsWrapper;
    UIButton *weiboBtn, *qqSessionBtn, *qqZoneBtn, *wxSessionBtn, *wxTimeLineBtn;
}

- (instancetype)initWithShareObject:(BCShareObject *)shareObject
{
    if (self = [self init])
    {
        _shareObject = shareObject;
        _showBtnsCount = 0;
        _titles = @[@"QQ好友", @"QQ空间", @"新浪微博", @"微信好友", @"微信朋友圈"];
        
        if ([BCLoginHandler sharedInstance].setWXSuc && [BCWXSocialHandler sharedInstance].isWXInstall)
        {
            wxSessionBtn = [self createShareButtonWithType:WECHAT_SESSION];
            wxTimeLineBtn = [self createShareButtonWithType:WECHAT_TIMELINE];
        }
        if ([BCLoginHandler sharedInstance].setQQSuc && [BCQQSocialHandler sharedInstance].isQQInstall)
        {
            qqSessionBtn = [self createShareButtonWithType:QQ_SESSION];
            
            if (![NSStringFromClass([shareObject class]) isEqualToString:@"BCShareObject"] && ![NSStringFromClass([shareObject class]) isEqualToString:@"BCShareImageObject"])
            {
                qqZoneBtn = [self createShareButtonWithType:QQ_ZONE];
            }
        }
        if ([BCLoginHandler sharedInstance].setWBSuc && [BCWBSocialHandler sharedInstance].isWBInstall)
        {
            weiboBtn = [self createShareButtonWithType:WEIBO];
        }
        
        _btnsHeight = (_showBtnsCount / 5 + 1) * (SCREEN_WIDTH / 4 - 20 - px);
        
        btnsWrapper.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _btnsHeight);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = [UIScreen mainScreen].bounds;
        coverControl = [UIControl new];
        coverControl.frame = self.frame;
        [self addSubview:coverControl];
        coverControl.backgroundColor = RGBACOLOR_HEX(0, 0.6);
        coverControl.alpha = 0;
        [coverControl addTarget:self action:@selector(touchBackground) forControlEvents:UIControlEventTouchUpInside];
        
        btnsWrapper = [UIView new];
        [self addSubview:btnsWrapper];
        btnsWrapper.backgroundColor = [UIColor whiteColor];
        btnsWrapper.userInteractionEnabled = YES;
    }
    return self;
}

- (void)didMoveToSuperview
{
    [UIView animateWithDuration:0.4 animations:^{
        coverControl.alpha = 1;
        btnsWrapper.frame = CGRectMake(0, SCREEN_HEIGHT - _btnsHeight, SCREEN_WIDTH, _btnsHeight);
    } completion:^(BOOL finished) {
        [super didMoveToSuperview];
    }];
}

- (void)setHidden:(BOOL)hidden
{
    if (hidden)
    {
        [UIView animateWithDuration:0.4 animations:^{
            coverControl.alpha = 0;
            btnsWrapper.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _btnsHeight);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else
    {
        [super setHidden:hidden];
    }
}

- (void)touchBackground
{
    self.hidden = YES;
}

- (UIButton *)createShareButtonWithType:(BCSocialShareType)type
{
    BCShareButton *shareButton = [BCShareButton buttonWithType:UIButtonTypeCustom];
    NSString *titleString = self.titles[type];
    
    [shareButton setTitleColor:RGBPureColor(102) forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:11];
    shareButton.layer.borderWidth = px;
    shareButton.layer.borderColor = RGBCOLOR_HEX(0xe1e1e1).CGColor;
    
    [shareButton setImage:[UIImage imageNamed:titleString] forState:UIControlStateNormal];
    [shareButton setTitle:titleString forState:UIControlStateNormal];
    
    shareButton.type = type;
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnsWrapper addSubview:shareButton];
    
    shareButton.frame = CGRectMake(_showBtnsCount % 4 * (SCREEN_WIDTH / 4),
                                   _showBtnsCount / 4 * (SCREEN_WIDTH / 4 - 20) - (_showBtnsCount / 4 + 1) * px,
                                   SCREEN_WIDTH / 4 + px,
                                   SCREEN_WIDTH / 4 - 20);
    _showBtnsCount ++;
    [shareButton centerImageAndTitle:2];
    
    return shareButton;
}

- (void)shareAction:(BCShareButton *)button
{
    if (self.actionBlock)
    {
        self.actionBlock(button.type);
    }
    [BCShareHandler shareObject:self.shareObject toPlatform:button.type complete:self.completeBlock];
    
    __weak BCShareView *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.hidden = YES;
    });
}

@end
