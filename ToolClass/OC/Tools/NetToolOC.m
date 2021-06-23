//
//  NetToolOC.m
//  ToolClass
//
//  Created by caidongdong on 2021/6/22.
//

#import "NetToolOC.h"
#import <AFNetworking.h>


@implementation NetToolOC
// Get请求
+ (void)getRequest:(NSString *)requestUrl Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
    [self getRequest:requestUrl Params:nil Success:success Failure:failure];
}

+ (void)getRequest:(NSString *)requestUrl Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
    [self getRequest:requestUrl headers:nil Params:params Success:success Failure:failure];
}

+ (void)getRequest:(NSString *)requestUrl headers:(NSDictionary *)headerDict Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
//    NSURL *URL = [NSURL URLWithString:Server_Api(requestUrl)];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    requestUrl = @"";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;
    //json序列化
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (headerDict && headerDict.allKeys.count > 0) {
        for (NSString *key in [headerDict allKeys]) {
            [manager.requestSerializer setValue:headerDict[key] forHTTPHeaderField:key];
        }
    }
    [manager GET:requestUrl parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

// Post请求
+ (void)postRequest:(NSString *)requestUrl Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
    [self postRequest:requestUrl Params:nil Success:success Failure:failure];
}

+ (void)postRequest:(NSString *)requestUrl Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
    [self postRequest:requestUrl headers:nil Params:params Success:success Failure:failure];
}

// Post请求
+ (void)postRequest:(NSString *)requestUrl headers:(NSDictionary *)headerDict Params:(nullable id)params Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure {
//    NSURL *URL = [NSURL URLWithString:Server_Api(requestUrl)];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    requestUrl = requestUrl;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (headerDict && headerDict.allKeys.count > 0) {
        for (NSString *key in [headerDict allKeys]) {
            [manager.requestSerializer setValue:headerDict[key] forHTTPHeaderField:key];
        }
    }
    //发送Post请求
    [manager POST:requestUrl parameters:params headers:headerDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //json如果不是字典,万一是字典如果不包含code这个key的话，就返回json
//        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)uploadFile:(NSString *)requestUrl filesArray:(nullable NSArray *)filesArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl filesArray:filesArray Progress:nil Success:success Failure:failure];
}

+ (void)uploadFile:(NSString *)requestUrl params:(nullable id)params filesArray:(nullable NSArray *)filesArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl params:params filesArray:filesArray Progress:nil Success:success Failure:failure];
}

+ (void)uploadFile:(NSString *)requestUrl headers:(nullable NSDictionary *)headerDict params:(nullable id)params filesArray:(nullable NSArray *)filesArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl headers:headerDict params:params filesArray:filesArray Progress:nil Success:success Failure:failure];
}

+ (void)uploadFile:(NSString *)requestUrl headers:(nullable NSDictionary *)headerDict filesArray:(nullable NSArray *)filesArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl headers:headerDict params:nil filesArray:filesArray Progress:nil Success:success Failure:failure];
}

+ (void)uploadFile:(NSString *)requestUrl filesArray:(nullable NSArray *)filesArray Progress:(nullable void(^)(float percent))percent Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl params:nil filesArray:filesArray Progress:percent Success:success Failure:failure];
}

+ (void)uploadFile:(NSString *)requestUrl params:(nullable id)params filesArray:(nullable NSArray *)filesArray Progress:(nullable void(^)(float percent))percent Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
    [self uploadFile:requestUrl headers:nil params:params filesArray:filesArray Progress:percent Success:success Failure:failure];
}

// 上传多个文件请求
+ (void)uploadFile:(NSString *)requestUrl headers:(nullable NSDictionary *)headerDict params:(nullable id)params filesArray:(nullable NSArray *)filesArray Progress:(nullable void(^)(float percent))percent Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure {
//    NSURL *URL = [NSURL URLWithString:Server_Api(requestUrl)];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    requestUrl = requestUrl;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (headerDict && headerDict.allKeys.count > 0) {
        for (NSString *key in [headerDict allKeys]) {
            [manager.requestSerializer setValue:headerDict[key] forHTTPHeaderField:key];
        }
    }
    [manager POST:requestUrl parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (FormData *data in filesArray) {
            [formData appendPartWithFileData:data.fileData
                                        name:data.name
                                    fileName:data.fileName
                                    mimeType:data.fileType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progress =  1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        percent(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);

        }
    }];
}

@end

@implementation FormData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileType = @"";
        self.name = @"";
    }
    return self;
}
@end
