//
//  BCColor.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef RGBCOLOR
    extern UIColor *RGBCOLOR(int r, int g, int b);
#endif
    
#ifndef RGBACOLOR
    extern UIColor *RGBACOLOR(int r, int g, int b, CGFloat a);
#endif
    
#ifndef RGBCOLOR_HEX
    extern UIColor *RGBCOLOR_HEX(int h);
#endif
    
#ifndef RGBACOLOR_HEX
    extern UIColor *RGBACOLOR_HEX(int h, CGFloat a);
#endif
    
#ifndef RGBPureColor
    extern UIColor *RGBPureColor(int h);
#endif
    
#ifdef __cplusplus
}
#endif
