// UIFontSerialization.m
// 
// Copyright (c) 2014 Mattt Thompson
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIFontSerialization.h"

#import <CoreText/CoreText.h>

@implementation UIFontSerialization

+ (UIFont *)fontWithData:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGFontRef fontRef = CGFontCreateWithDataProvider(dataProviderRef);
    CGDataProviderRelease(dataProviderRef);

    CFErrorRef errorRef;
    BOOL success = CTFontManagerRegisterGraphicsFont(fontRef, &errorRef);
    NSString *fontName = (__bridge NSString *)CGFontCopyPostScriptName(fontRef);
    CGFontRelease(fontRef);

    if (success) {
        return [UIFont fontWithName:fontName size:[UIFont systemFontSize]];
    } else {
        if (error) {
            *error = (__bridge NSError *)errorRef;
        }

        return nil;
    }
}

#pragma mark -

+ (NSData *)dataWithFont:(UIFont *)font
                   error:(NSError * __autoreleasing *)error
{
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    return (__bridge_transfer NSData *)CTFontCopyTable(fontRef, kCTFontTableCFF, kCTFontTableOptionNoOptions);
}

@end
