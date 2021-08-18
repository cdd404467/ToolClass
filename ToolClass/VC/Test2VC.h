//
//  Test2VC.h
//  ToolClass
//
//  Created by caidongdong on 2021/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test2VC : UIViewController
@property (nonatomic, strong)NSArray *pArr;
@property (nonatomic, copy)void (^clickB)(void);
@end

NS_ASSUME_NONNULL_END
