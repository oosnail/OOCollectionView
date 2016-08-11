//
//  UIColor+DXExtension.m
//  DaoxilaApp
//
//  Created by LCQ on 15/9/6.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "UIColor+DXExtension.h"

@implementation UIColor (DXExtension)

+(UIColor *)colorFromHexString:(NSString *)hexColor {
    hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    int len = (int)[hexColor length];
    if (len == 3) {
        NSString * r = [hexColor substringWithRange:NSMakeRange(0, 1)];
        NSString * g = [hexColor substringWithRange:NSMakeRange(1, 1)];
        NSString * b = [hexColor substringWithRange:NSMakeRange(2, 1)];
        
        hexColor = [NSString stringWithFormat:@"%@%@%@%@%@%@",r,r,g,g,b,b];
    }
    
    if ([hexColor length] == 6) {
        hexColor = [hexColor stringByAppendingString:@"ff"];
    }
    NSScanner * scanner = [NSScanner scannerWithString:hexColor];
    unsigned int hexInt;
    [scanner scanHexInt:&hexInt];
    float red = ((hexInt >> 24) & 0xff) / 255.f;
    float green = ((hexInt >> 16) & 0x00ff) / 255.f;
    float blue = ((hexInt >> 8) & 0x0000ff) / 255.f;
    float alpha = ((hexInt >> 0) & 0x000000ff) / 255.f;
    
    
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
