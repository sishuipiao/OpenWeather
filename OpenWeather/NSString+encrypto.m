//
//  NSString+encrypto.m
//  OpenWeather
//
//  Created by Steven on 14/11/28.
//  Copyright (c) 2014年 DevStore. All rights reserved.
//

#import "NSString+encrypto.h"

@implementation NSString(encrypto)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self, nil, (CFStringRef) @"!$&'()*+,-./:;=?@_~%#[]", kCFStringEncodingUTF8);
    
    return encodedString;
}
@end
