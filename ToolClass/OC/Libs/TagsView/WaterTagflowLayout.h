//
//  WaterTagflowLayout.h
//  FMTagsView
//
//  Created by caidongdong on 2021/7/19.
//  Copyright © 2021 Followme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterTagflowLayout : UICollectionViewFlowLayout
@property (weak, nonatomic) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (assign,nonatomic) CGFloat contentHeight;
@property (nonatomic, assign)NSInteger maxLineNumber;
@end

NS_ASSUME_NONNULL_END
