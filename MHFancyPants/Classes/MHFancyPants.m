//
//Copyright (c) 2013 Martin Hartl
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "MHFancyPants.h"

@interface MHFancyPants ()

@property (nonatomic, strong, readwrite) NSDictionary *theme;
@property (nonatomic, strong, readwrite) NSCache *colorCache;

@end

@implementation MHFancyPants

+ (instancetype)sharedInstance {
    static MHFancyPants *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.colorCache = [NSCache new];
    });
    
    return _sharedInstance;
}

+ (void)configWithPlistName:(NSString *)name {
    NSString *themeFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    MHFancyPants *loader = [self sharedInstance];
    [loader.colorCache removeAllObjects];
    loader.theme = [NSDictionary dictionaryWithContentsOfFile:themeFilePath];
}


#pragma mark - For-Key-Methods

+ (BOOL)boolForKey:(NSString *)key {
    
    MHFancyPants *loader = [self sharedInstance];
    
	id obj = [loader objectForKey:key];
	if (obj == nil) {
		return NO;
    }
	return [obj boolValue];
}

+ (NSString *)stringForKey:(NSString *)key {
	
    MHFancyPants *loader = [self sharedInstance];
    
	id obj = [loader objectForKey:key];
	if (obj == nil) {
		return nil;
    }
	if ([obj isKindOfClass:[NSString class]]) {
		return obj;
    }
	if ([obj isKindOfClass:[NSNumber class]]) {
		return [obj stringValue];
    }
	return nil;
}

+ (NSInteger)integerForKey:(NSString *)key {
    
    MHFancyPants *loader = [self sharedInstance];
    
	id obj = [loader objectForKey:key];
	if (obj == nil) {
		return 0;
    }
	return [obj integerValue];
}

+ (CGFloat)floatForKey:(NSString *)key {
    
    MHFancyPants *loader = [self sharedInstance];
	
	id obj = [loader objectForKey:key];
	if (obj == nil) {
		return  0.0f;
    }
	return [obj floatValue];
}

+ (NSTimeInterval)timeIntervalForKey:(NSString *)key {
    
    MHFancyPants *loader = [self sharedInstance];
    
	id obj = [loader objectForKey:key];
	if (obj == nil) {
		return 0.0;
    }
	return [obj doubleValue];
}

+ (UIColor *)colorForKey:(NSString *)key {
    
    MHFancyPants *loader = [self sharedInstance];
    
    UIColor *cachedColor = [loader.colorCache objectForKey:key];
	if (cachedColor != nil) {
		return cachedColor;
    }
    
	NSString *colorString = [loader stringForKey:key];
	UIColor *color = colorWithHexString(colorString);
	if (color == nil) {
		color = [UIColor blackColor];
    }
    
	[loader.colorCache setObject:color forKey:key];
    
	return color;
}

+ (CGPoint)pointForKey:(NSString *)key {
    
	CGFloat pointX = [self floatForKey:[key stringByAppendingString:@".x"]];
	CGFloat pointY = [self floatForKey:[key stringByAppendingString:@".y"]];
    
	CGPoint point = CGPointMake(pointX, pointY);
	return point;
}

+ (CGSize)sizeForKey:(NSString *)key {
    
	CGFloat width = [self floatForKey:[key stringByAppendingString:@".width"]];
	CGFloat height = [self floatForKey:[key stringByAppendingString:@".height"]];
    
	CGSize size = CGSizeMake(width, height);
	return size;
}

+ (CGRect)rectForKey:(NSString *)key {
    
    CGPoint origin = [self pointForKey:key];
    CGSize size = [self sizeForKey:key];
    
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    return rect;
}

+ (UIEdgeInsets)edgeInsetsForKey:(NSString *)key {
    CGFloat top = [self floatForKey:[key stringByAppendingString:@".top"]];
    CGFloat left = [self floatForKey:[key stringByAppendingString:@".left"]];
    CGFloat bottom = [self floatForKey:[key stringByAppendingString:@".bottom"]];
    CGFloat right = [self floatForKey:[key stringByAppendingString:@".right"]];
    
    return UIEdgeInsetsMake(top, left, bottom, right);
}

#pragma mark - Helper-Methods

- (NSString *)stringForKey:(NSString *)key {
    
	id obj = [self objectForKey:key];
	if (obj == nil) {
		return nil;
    }
	if ([obj isKindOfClass:[NSString class]]) {
		return obj;
    }
	if ([obj isKindOfClass:[NSNumber class]]) {
		return [obj stringValue];
    }
	return nil;
}

- (id)objectForKey:(NSString *)key {
    
	id obj = [self.theme valueForKeyPath:key];
	return obj;
}



static UIColor *colorWithHexString(NSString *hexString) {

	if (stringIsEmpty(hexString)) {
		return [UIColor blackColor];
    }
    
	NSMutableString *s = [hexString mutableCopy];
	[s replaceOccurrencesOfString:@"#" withString:@"" options:0 range:NSMakeRange(0, [hexString length])];
	CFStringTrimWhitespace((__bridge CFMutableStringRef)s);
    
	NSString *redString = [s substringToIndex:2];
	NSString *greenString = [s substringWithRange:NSMakeRange(2, 2)];
	NSString *blueString = [s substringWithRange:NSMakeRange(4, 2)];
    
	unsigned int red = 0, green = 0, blue = 0;
	[[NSScanner scannerWithString:redString] scanHexInt:&red];
	[[NSScanner scannerWithString:greenString] scanHexInt:&green];
	[[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
	return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

static BOOL stringIsEmpty(NSString *s) {
	return s == nil || [s length] == 0;
}

@end
