//
//  HelpTool.m
//  open
//
//  Created by OPEN_mbp001 on 2021/11/4.
//

#import "HelpTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"

@implementation HelpTool
//  添加点击手势
+ (void)addTapGesture:(UIView *)view withTarget:(id)target andSEL:(SEL)sel {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}

//添加垂直渐变
+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations layerName:(NSString *)layerName {
    if (view.width == 0 || view.height == 0) {
        [view.superview layoutIfNeeded];
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *colorArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < colors.count; i++) {
        [colorArr addObject:(__bridge id)colors[i].CGColor];
    }
    NSMutableArray *locaArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < locations.count; i++) {
        [locaArr addObject:locations[i]];
    }
    gradientLayer.colors = colorArr.copy;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1.0);
    gradientLayer.frame = view.bounds;
    gradientLayer.name = layerName;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations {
    [self addLayerVertical:view colors:colors locations:locations layerName:nil];
}

+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors {
    [self addLayerVertical:view colors:colors locations:@[@0,@1]];
}

+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors layerName:(NSString *)layerName {
    [self addLayerVertical:view colors:colors locations:@[@0,@1] layerName:layerName];
}

//添加水平渐变
+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations {
    [self addLayerHorizontal:view colors:colors locations:locations layerName:nil];
}

+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors {
    [self addLayerHorizontal:view colors:colors locations:@[@0,@1]];
}

+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors layerName:(NSString *)layerName {
    [self addLayerHorizontal:view colors:colors locations:@[@0,@1] layerName:layerName];
}


+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations layerName:(NSString *)layerName {
    if (view.width == 0 || view.height == 0) {
        [view.superview layoutIfNeeded];
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *colorArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < colors.count; i++) {
        [colorArr addObject:(__bridge id)colors[i].CGColor];
    }
    NSMutableArray *locaArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < locations.count; i++) {
        [locaArr addObject:locations[i]];
    }
    gradientLayer.colors = colorArr.copy;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0,0.0);
    gradientLayer.frame = view.bounds;
    gradientLayer.name = layerName;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}




//添加水平渐变
+ (void)addLayerHorizontal:(UIView *)view frame:(CGRect)frame startColor:(UIColor *)sColor endColor:(UIColor *)eColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)sColor.CGColor, (__bridge id)eColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0,0.0);
    gradientLayer.frame = frame;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}



+ (BOOL)isRirhtData:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        object = [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (object && ![object isEqualToString:@"null"] && ![object isEqualToString:@"(null)"] && ![object isEqualToString:@"<null>"] && ![object isEqualToString:@""]) {
            return YES;
        }
        return NO;
    } else {
        if (object && object != NULL && ![object isKindOfClass:[NSNull class]]) {
            return YES;
        }
        return NO;
    }
}

+ (NSString *)RightDataSafe:(id)object {
    if([self isRirhtData:object]) {
        return object;
    }
    return @"";
}

//获取keywindow
+ (UIWindow *)getKeyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindow *window in UIApplication.sharedApplication.windows) {
            if (window.isKeyWindow) {
                return window;
            }
        }
    }
    return UIApplication.sharedApplication.windows.lastObject;
}

//检查相机权限
+ (void)checkCameraAvailability:(void (^)(BOOL auth))block {
    BOOL status = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        status = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if (block) {
                    block(granted);
                }
            } else {
                if (block) {
                    block(granted);
                }
            }
        }];
        return;
    }
    if (block) {
        block(status);
    }
}

#pragma mark - 画圆角和边框
+ (void)drawRound:(UIView * _Nonnull)view corner:(UIRectCorner)corner radiu:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (view.width == 0 || view.height == 0) {
        [view.superview layoutIfNeeded];
    }
    //画圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    if (borderWidth == 0.0)
        return;
    
    //画边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = view.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = view.backgroundColor.CGColor;
    [view.layer addSublayer:borderLayer];
}

//只要圆角
+ (void)drawRound:(UIView * _Nonnull)view corner:(UIRectCorner)corner radiu:(CGFloat)radius {
    [self drawRound:view corner:corner radiu:radius borderWidth:0.0 borderColor:nil];
}

+ (void)drawRound:(UIView * _Nonnull)view radiu:(CGFloat)radius {
    [self drawRound:view corner:UIRectCornerAllCorners radiu:radius];
}

+ (void)drawRound:(UIView * _Nonnull)view {
    [self drawRound:view radiu:view.width / 2];
}


//同时要圆角和border
+ (void)drawRound:(UIView * _Nonnull)view radiu:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    [self drawRound:view corner:UIRectCornerAllCorners radiu:radius borderWidth:borderWidth borderColor:borderColor];
}

+ (void)drawRound:(UIView * _Nonnull)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    [self drawRound:view radiu:view.width / 2 borderWidth:borderWidth borderColor:borderColor];
}

//画大圆角
+ (void)drawLargeRound:(UIView *)view corners:(UIRectCorner)corners radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (view.frame.size.width == 0 || view.frame.size.height == 0) {
        [view.superview layoutIfNeeded];
    }
    
    // 画带有指定圆角角落的路径
    UIBezierPath *maskPath = [self roundedPathForView:view withCorners:corners andRadius:radius];
    
    // 使用mask来裁剪多余部分
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    // 画边框
    if (borderWidth > 0) {
        // 画整个view的圆角路径
        UIBezierPath *borderPath = [self roundedPathForView:view withCorners:(UIRectCornerAllCorners) andRadius:radius];
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.frame = view.bounds;
        borderLayer.path = borderPath.CGPath;
        borderLayer.lineWidth = borderWidth * 2; // 考虑边框宽度
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        [view.layer addSublayer:borderLayer];
    }
}

+ (void)drawLargeRound:(UIView *)view corners:(UIRectCorner)corners radius:(CGFloat)radius {
    [self drawLargeRound:view corners:corners radius:radius borderWidth:0 borderColor:UIColor.clearColor];
}

+ (UIBezierPath *)roundedPathForView:(UIView *)view withCorners:(UIRectCorner)corners andRadius:(CGFloat)radius {
    UIBezierPath *roundedPath = [UIBezierPath bezierPath];
    CGFloat viewWidth = CGRectGetWidth(view.bounds);
    CGFloat viewHeight = CGRectGetHeight(view.bounds);
    
    CGFloat max_radius = fminf(viewWidth, viewHeight);
    if (radius > max_radius) {
        radius = max_radius;
    }
    
    CGFloat topLeftRadius = (corners & UIRectCornerTopLeft) ? radius : 0;
    CGFloat topRightRadius = (corners & UIRectCornerTopRight) ? radius : 0;
    CGFloat bottomLeftRadius = (corners & UIRectCornerBottomLeft) ? radius : 0;
    CGFloat bottomRightRadius = (corners & UIRectCornerBottomRight) ? radius : 0;
    
    [roundedPath moveToPoint:CGPointMake(0, topLeftRadius)];
    [roundedPath addArcWithCenter:CGPointMake(topLeftRadius, topLeftRadius) radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
    
    [roundedPath addLineToPoint:CGPointMake(viewWidth - topRightRadius, 0)];
    [roundedPath addArcWithCenter:CGPointMake(viewWidth - topRightRadius, topRightRadius) radius:topRightRadius startAngle:M_PI * 1.5 endAngle:M_PI * 2 clockwise:YES];
    
    [roundedPath addLineToPoint:CGPointMake(viewWidth, viewHeight - bottomRightRadius)];
    [roundedPath addArcWithCenter:CGPointMake(viewWidth - bottomRightRadius, viewHeight - bottomRightRadius) radius:bottomRightRadius startAngle:0 endAngle:M_PI * 0.5 clockwise:YES];
    
    [roundedPath addLineToPoint:CGPointMake(bottomLeftRadius, viewHeight)];
    [roundedPath addArcWithCenter:CGPointMake(bottomLeftRadius, viewHeight - bottomLeftRadius) radius:bottomLeftRadius startAngle:M_PI * 0.5 endAngle:M_PI clockwise:YES];
    
    [roundedPath closePath];
    
    return roundedPath;
}

//字符串是否能转成数字
+ (BOOL)isPureInt:(NSString *)string {
    if (!string) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//生成唯一字符串
+ (NSString *)getUniqueString
{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uniqueString = (__bridge NSString *)uuidStringRef;
    return uniqueString;
}


//获取当前显示的控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *resultVC;
    resultVC = [self _topViewController:[HelpTool.getKeyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
    
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (NSData *)compressWidgetImageToData:(UIImage *)image {
    CGFloat maxLength = 1024 * 800;
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    UIImage *resultImage = [UIImage imageWithData:data];
    CGFloat maxWidth = 1000;
    if (resultImage.size.width <= maxWidth) {
        data = UIImageJPEGRepresentation(resultImage, compression);
        return data;
    }
    CGFloat scale = maxWidth / resultImage.size.width;
    CGSize size = CGSizeMake(maxWidth, resultImage.size.height * scale);
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(resultImage, compression);
//    NSLog(@"cddd11111 data --- %ld w-- %lf  h== %lf",data.length / 1024,image.size.width,image.size.height);
//    if (data.length < maxLength) return data;
    // Compress by size
//    NSUInteger lastDataLength = 0;
//    while (data.length > maxLength && data.length != lastDataLength) {
//        lastDataLength = data.length;
//        CGFloat ratio = (CGFloat)maxLength / data.length;
//        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
//        UIGraphicsBeginImageContext(size);
//        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        resultImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        data = UIImageJPEGRepresentation(resultImage, compression);
//    }
    return data;
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    return [UIImage imageWithData:[self compressImageToData:image toByte:maxLength]];
}

+ (NSData *)compressImageToData:(UIImage *)image toByte:(NSUInteger)maxLength {
    //先压质量
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    UIImage *resultImage = [UIImage imageWithData:data];
//    NSLog(@"质量压缩后 data --- %ld w-- %lf  h== %lf",data.length,resultImage.size.width,resultImage.size.height);
    if (data.length < maxLength) return data;
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    NSData *data1 = UIImageJPEGRepresentation(resultImage, compression);
//    NSLog(@"最终 data --- %ld w-- %lf  h== %lf",data1.length,resultImage.size.width,resultImage.size.height);
    return data1;
}

//清除所有UserDefault
- (void)clearKeyChain {
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                  (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                  nil];
    NSArray *secItemClasses = [NSArray arrayWithObjects:
                               (__bridge id)kSecClassGenericPassword,
                               (__bridge id)kSecClassInternetPassword,
                               (__bridge id)kSecClassCertificate,
                               (__bridge id)kSecClassKey,
                               (__bridge id)kSecClassIdentity,
                               nil];
    for (id secItemClass in secItemClasses) {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        if (result != NULL) CFRelease(result);
        
        NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
        SecItemDelete((__bridge CFDictionaryRef)spec);
    }
}
//清除所有钥匙串数据
- (void)clearUserDefaults {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"Preferences"];
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString * filename in fileList) {
        NSString *filepath = [path stringByAppendingPathComponent:filename];
        BOOL isDir = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:filepath isDirectory:(&isDir)];
        if (!isDir && [filename hasSuffix:@".plist"] && (![filename isEqualToString:appDomain])) {
            NSString *suitename = [filename stringByDeletingPathExtension];
            NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suitename];
            [userDefaults removePersistentDomainForName:suitename];
            [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
        }
    }
}

+ (NSDictionary *)dictionaryWithObj:(id)obj {
    NSError *error = nil;
    NSData *jsonData = nil;
    if ([obj isKindOfClass:NSData.class]) {
        jsonData = obj;
    } else {
        jsonData = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
    }
    
//    NSString * bodyStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *dict = [NSDictionary alloc] initwithda;
    NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    
    return dict;
}

+ (NSString *)getJsonStringWithObj:(id)obj {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = @"";
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id)getObjWithJsonStr:(NSString *)jsonStr {
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    if (error) {
        NSLog(@"JSON Parsing Error: %@", error.localizedDescription);
    } else {
        return jsonDictionary;
    }
    return @"";
}

+ (UIImage *)creatQRCodeFromString:(NSString *)string {
//    NSData *stringData = [string dataUsingEncoding: NSUTF8StringEncoding];
//
//    // 创建一个二维码滤镜
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:stringData forKey:@"inputMessage"];
//    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
//
//    CIImage *image = qrFilter.outputImage;
//    CGAffineTransform transform = CGAffineTransformMakeScale(10.0, 10.0); // 放大，因为生成的图像可能会很小
//    image = [image imageByApplyingTransform: transform];
//
//    return [UIImage imageWithCIImage:image];
    
    NSData *urlData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:urlData forKey:@"inputMessage"];
    CIImage *qrImage = [qrFilter outputImage];

    CGFloat scaleX = qrImage.extent.size.width;
    CGFloat scaleY = qrImage.extent.size.height;
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:qrImage fromRect:qrImage.extent];

    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

@end
