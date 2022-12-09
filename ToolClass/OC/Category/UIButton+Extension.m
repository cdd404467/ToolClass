//
//  UIButton+Extension.m
//  SH
//
//  Created by i7colors on 2019/9/4.
//  Copyright © 2019 surhoo. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

typedef void(^ButtonEventsBlock)(void);
static const NSString *Key_TouchEdgeInsets = @"touchEdgeInsets";
@interface UIButton()
/** 事件回调的block */
@property (nonatomic, copy) ButtonEventsBlock buttonEventsBlock;
@end

@implementation UIButton (Extension)
- (void)layoutWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    if (!CGSizeEqualToSize(self.titleLabel.frame.size, CGSizeZero)) {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

#pragma mark - button的block
//------- 添加属性 -------//

static void *my_buttonEventsBlockKey = &my_buttonEventsBlockKey;

- (ButtonEventsBlock)buttonEventsBlock {
    return objc_getAssociatedObject(self, &my_buttonEventsBlockKey);
}

- (void)setButtonEventsBlock:(ButtonEventsBlock)buttonEventsBlock {
    objc_setAssociatedObject(self, &my_buttonEventsBlockKey, buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

- (void)addEventHandler:(void (^)(void))block {
    self.buttonEventsBlock = block;
    [self addTarget:self action:@selector(addEventHandler) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮点击
- (void)addEventHandler {
    !self.buttonEventsBlock ?: self.buttonEventsBlock();
}

- (void)setBtnWithTitle:(NSString *)title titleColor:(UIColor *)color font:(CGFloat)font {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:font];
}

#pragma mark - 扩大点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.touchEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden)
    {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.touchEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setTouchEdgeInsets:(UIEdgeInsets)touchEdgeInsets {
    UIEdgeInsets edges = UIEdgeInsetsMake(-touchEdgeInsets.top, -touchEdgeInsets.left, -touchEdgeInsets.bottom, -touchEdgeInsets.right);
    NSValue *value = [NSValue value:&edges withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &Key_TouchEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)touchEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &Key_TouchEdgeInsets);
    if(value){
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

@end
