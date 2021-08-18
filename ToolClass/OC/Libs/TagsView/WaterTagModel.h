//
//  WaterflowTagModel.h
//  FMTagsView
//
//  Created by caidongdong on 2021/7/19.
//  Copyright © 2021 Followme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterTagModel : NSObject
@property (copy, nonnull) NSString *name;
@property (nonatomic) BOOL selected;
//用于计算文字大小
@property (strong, nonatomic) UIFont *font;

@property (nonatomic, readonly) CGSize contentSize;

- (instancetype)initWithName:(NSString *)name font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
