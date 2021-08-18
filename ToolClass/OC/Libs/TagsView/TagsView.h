//
//  FMTagsView.h
//  FollowmeiOS
//
//  Created by Subo on 16/5/25.
//  Copyright © 2016年 com.followme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterflowTagCell.h"

@protocol TagsViewDelegate;


@interface TagsView : UIView

@property (nonatomic) UIEdgeInsets contentInsets; //default is (10,10,10,10)

@property (nonatomic) NSArray<NSString *> *tagsArray;   //数据源
@property (weak, nonatomic) id<TagsViewDelegate> delegate;

@property (nonatomic, assign) CGFloat lineSpacing;       //行间距, 默认为10
@property (nonatomic, assign) CGFloat interitemSpacing; //元素之间的间距，默认为5

#pragma mark - ......::::::: 标签定制属性 :::::::......

@property (nonatomic) UIEdgeInsets tagInsets; // default is (5,10,5,10)
@property (nonatomic, assign) CGFloat tagBorderWidth;           //标签边框宽度, default is 0
@property (nonatomic, assign) CGFloat tagcornerRadius;  // default is 0
@property (strong, nonatomic) UIColor *tagBorderColor;
@property (strong, nonatomic) UIColor *tagSelectedBorderColor;
@property (strong, nonatomic) UIColor *tagBackgroundColor;
@property (strong, nonatomic) UIColor *tagSelectedBackgroundColor;
@property (strong, nonatomic) UIFont *tagFont;
@property (strong, nonatomic) UIFont *tagSelectedFont;
@property (strong, nonatomic) UIColor *tagTextColor;
@property (strong, nonatomic) UIColor *tagSelectedTextColor;

@property (nonatomic, assign) CGFloat tagHeight;        //标签高度，默认28
@property (nonatomic, assign) CGFloat mininumTagWidth;  //tag 最小宽度值, 默认是0，即不作最小宽度限制
@property (nonatomic, assign) CGFloat maximumTagWidth;  //tag 最大宽度值, 默认是CGFLOAT_MAX， 即不作最大宽度限制
@property (nonatomic, assign) NSInteger maxLineNumber;  //最多几行tag

#pragma mark - ......::::::: 选中 :::::::......

@property (nonatomic, assign) BOOL allowsSelection;             //是否允许选中, default is NO
@property (nonatomic, assign) BOOL allowsMultipleSelection;     //是否允许多选, default is NO
@property (nonatomic, assign) BOOL allowEmptySelection;         //是否允许空选, default is YES

/**
 *  允许最多的选中个数，默认不作限制；该属性仅在 allowsMultipleSelection 为YES时有效
 */
@property (nonatomic) NSInteger maximumNumberOfSelection;

@property (nonatomic, readonly) NSUInteger selectedIndex;   //选中索引
@property (nonatomic, readonly) NSArray<NSString *> *selecedTags;     //多选状态下，选中的Tags
@property (nonatomic, readonly) NSArray<NSNumber *> *selectedIndexes; //多选状态下，选中的索引

- (void)selectTagAtIndex:(NSUInteger)index animate:(BOOL)animate;
- (void)deSelectTagAtIndex:(NSUInteger)index animate:(BOOL)animate;
- (void)deSelectAll;

- (WaterflowTagCell *)cellForItemAtIndex:(NSInteger)index;

#pragma mark - ......::::::: Edit :::::::......

//if not found, return NSNotFount
- (NSUInteger)indexOfTag:(NSString *)tagName;

- (void)addTag:(NSString *)tagName;
- (void)insertTag:(NSString *)tagName AtIndex:(NSUInteger)index;

- (void)removeTagWithName:(NSString *)tagName;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;

@end


@protocol TagsViewDelegate <NSObject>

@optional
- (BOOL)tagsView:(TagsView *)tagsView shouldSelectTagAtIndex:(NSUInteger)index;
- (void)tagsView:(TagsView *)tagsView didSelectTagAtIndex:(NSUInteger)index;

- (BOOL)tagsView:(TagsView *)tagsView shouldDeselectItemAtIndex:(NSUInteger)index;
- (void)tagsView:(TagsView *)tagsView didDeSelectTagAtIndex:(NSUInteger)index;

//超过最多选中个数，可在这个方法中做自定义提示，如提示用户超过最多选中项
- (void)tagsViewDidBeyondMaximumNumberOfSelection:(TagsView *)tagsView;

//允许对Cell进行自定义操作
- (void)tagsView:(TagsView *)tagsView willDispayCell:(WaterflowTagCell *)tagCell atIndex:(NSUInteger)index;

@end
