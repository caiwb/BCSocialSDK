//
//  BCColor.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCColor.h"

#ifndef RGBCOLOR
UIColor *RGBCOLOR(int r, int g, int b)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];
}
#endif

#ifndef RGBACOLOR
UIColor *RGBACOLOR(int r, int g, int b, CGFloat a)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
                           alpha:(a)];
}
#endif

#ifndef RGBCOLOR_HEX
UIColor *RGBCOLOR_HEX(int h)
{
    return RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF));
}
#endif

#ifndef RGBACOLOR_HEX
UIColor *RGBACOLOR_HEX(int h, CGFloat a)
{
    return RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a));
}
#endif


#ifndef RGBPureColor
UIColor *RGBPureColor(int h)
{
    return RGBCOLOR(h, h, h);
}
#endif
