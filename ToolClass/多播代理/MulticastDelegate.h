//
//  MulticastDelegate.h
//  ToolClass
//
//  Created by zhuzi-cdd on 2023/11/21.
//

#import <Foundation/Foundation.h>
#import "MyDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MulticastDelegate : NSObject
- (void)addDelegate:(id<MyDelegateProtocol>)delegate;
- (void)removeDelegate:(id<MyDelegateProtocol>)delegate;
- (void)removeDelegateWithClass:(Class)classObj;
- (void)performDelegateMethod;
+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
