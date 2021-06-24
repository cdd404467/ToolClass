//
//  UITextField+Limit.h
//  ToolClass
//
//  Created by caidongdong on 2021/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Limit)
//输入的最大长度
@property (assign,nonatomic) NSUInteger maxLength;
//文本改变监听
@property (copy,nonatomic) void(^valueChangedBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END
