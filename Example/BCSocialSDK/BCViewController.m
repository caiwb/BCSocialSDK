//
//  BCViewController.m
//  BCSocialSDK
//
//  Created by caiwenbo on 07/18/2016.
//  Copyright (c) 2016 caiwenbo. All rights reserved.
//

#import "BCViewController.h"
#import "BCSocialSDK.h"

@interface BCViewController ()

@end

@implementation BCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BCShareWebObject *obj = [BCShareWebObject new];
    obj.title = @"title";
    obj.text = @"text";
    obj.thumbImage = [UIImage new];
    obj.webUrl = @"webUrl";
    
    [BCShareHandler shareObjectByBCShareView:obj];
}

@end
