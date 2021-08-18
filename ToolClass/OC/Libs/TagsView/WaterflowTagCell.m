//
//  WaterflowTagCell.m
//  FMTagsView
//
//  Created by caidongdong on 2021/7/19.
//  Copyright © 2021 Followme. All rights reserved.
//

#import "WaterflowTagCell.h"
#import "WaterTagModel.h"

@interface WaterflowTagCell()

@end

@implementation WaterflowTagCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:_tagLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.contentView.bounds;
    CGFloat width = bounds.size.width - self.contentInsets.left - self.contentInsets.right;
    CGRect frame = CGRectMake(0, 0, width, [self.tagModel contentSize].height);
    self.tagLabel.frame = frame;
    self.tagLabel.center = self.contentView.center;
}
@end
