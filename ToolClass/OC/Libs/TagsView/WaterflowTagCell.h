//
//  WaterflowTagCell.h
//  FMTagsView
//
//  Created by caidongdong on 2021/7/19.
//  Copyright © 2021 Followme. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterTagModel;

NS_ASSUME_NONNULL_BEGIN

@interface WaterflowTagCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *tagLabel;
@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic) WaterTagModel *tagModel;
@end

NS_ASSUME_NONNULL_END
