//
//  MyDelegateProtocol.h
//  ToolClass
//
//  Created by zhuzi-cdd on 2023/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyDelegateProtocol <NSObject>
@optional
- (void)didReceiveEvent:(NSString *)event;
@end

NS_ASSUME_NONNULL_END
