# MHFancyPants

Simple app styling via Plist inspired by [DB5 - Q Branch](https://github.com/quartermaster/DB5?source=cc "DB5 - Q Branch")

## What it is

Store colors, numbers, booleans, CGRects, CGPoints and CGSizes, timeintervals and strings into a Plist which can be used within the app. This enables to change the look and feel of an App with just one file. 

Just have a look into the example project.

## Load "theme" inside app

Call "configWithPlistName" inside your didFinishLaunchingWithOptions-method contained in the AppDelegate with the name of the Plist as argument.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MHFancyPants configWithPlistName:@"<NameOfPlistFile>"];
    
    return YES;
}
```

## Access the values

```objective-c
+ (BOOL)boolForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (CGFloat)floatForKey:(NSString *)key;
+ (NSTimeInterval)timeIntervalForKey:(NSString *)key;
+ (UIColor *)colorForKey:(NSString *)key;
+ (CGPoint)pointForKey:(NSString *)key;
+ (CGSize)sizeForKey:(NSString *)key;
+ (CGRect)rectForKey:(NSString *)key;
+ (UIEdgeInsets)edgeInsetsForKey:(NSString *)key;
```

## Define the values

Within a Plist file define:

+ bool as Boolean
+ string as String
+ integer as Number
+ float as Number
+ timeInterval as Number
+ color as String (hex-value without the '#')
+ CGPoint as a dictionary containing two values (named x and y) as Number
+ CGSize as a dictionary containing two values (named width and height) as Number
+ CGRecht as a dictionary containing four values (x,y,width and height) as Number
+ UIEdgeInsets as a dictionary containing four values (top, left, bottom and right) as Number


# License MIT


Copyright (c) 2013 Martin Hartl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
