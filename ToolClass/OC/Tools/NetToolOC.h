//
//  NetToolOC.h
//  ToolClass
//
//  Created by caidongdong on 2021/6/22.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@interface NetToolOC : NSObject

+ (void)getRequest:(NSString *)requestUrl Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;
+ (void)getRequest:(NSString *)requestUrl Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;
+ (void)postRequest:(NSString *)requestUrl Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;
+ (void)postRequest:(NSString *)requestUrl Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;
@end

//用来封装 上传文件 的数据模型
@interface FormData : NSObject
@property(nonatomic,strong)NSData * fileData;//文件数据
@property(nonatomic,copy)NSString * fileName;//文件名.jpg
@property(nonatomic,copy)NSString * name;//参数名
@property(nonatomic,copy)NSString * fileType;//文件类型
@end
NS_ASSUME_NONNULL_END
