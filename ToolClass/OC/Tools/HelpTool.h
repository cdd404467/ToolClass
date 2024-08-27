//
//  HelpTool.h
//  open
//
//  Created by OPEN_mbp001 on 2021/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpTool : NSObject
+ (void)addTapGesture:(UIView *)view withTarget:(id)target andSEL:(SEL)sel;
//添加垂直渐变
+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors;
+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations;
+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors layerName:(NSString *)layerName;
+ (void)addLayerVertical:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations layerName:(nullable NSString *)layerName;
+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors;
+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations;
+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors layerName:(NSString *)layerName;
+ (void)addLayerHorizontal:(UIView *)view colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations layerName:(nullable NSString *)layerName;
+ (BOOL)isRirhtData:(nullable id)object;
+ (NSString *)RightDataSafe:(nullable id)object;
+ (UIWindow *)getKeyWindow;
+ (NSString *)getUniqueString;

+ (void)checkCameraAvailability:(void (^)(BOOL auth))block;

//画uiview绘画圆角
+ (void)drawRound:(UIView * _Nonnull)view;
+ (void)drawRound:(UIView * _Nonnull)view radiu:(CGFloat)radius;
+ (void)drawRound:(UIView * _Nonnull)view corner:(UIRectCorner)corner radiu:(CGFloat)radius;
+ (void)drawRound:(UIView * _Nonnull)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (void)drawRound:(UIView * _Nonnull)view radiu:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (void)drawRound:(UIView * _Nonnull)view corner:(UIRectCorner)corner radiu:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor * _Nullable)borderColor;
+ (void)drawLargeRound:(UIView *)view corners:(UIRectCorner)corners radius:(CGFloat)radius;
//画更大的圆角
+ (void)drawLargeRound:(UIView *)view corners:(UIRectCorner)corners radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (BOOL)isPureInt:(NSString *)string;
+ (UIViewController *)getCurrentVC;

+ (NSData *)compressWidgetImageToData:(UIImage *)image;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
+ (NSData *)compressImageToData:(UIImage *)image toByte:(NSUInteger)maxLength;
+ (NSDictionary *)dictionaryWithObj:(id)obj;

+ (NSString *)getJsonStringWithObj:(id)obj;
+ (id)getObjWithJsonStr:(NSString *)jsonStr;

+ (UIImage *)creatQRCodeFromString:(NSString *)string;  //生成二维码
@end

NS_ASSUME_NONNULL_END
