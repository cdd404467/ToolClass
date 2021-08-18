//
//  FMTagsView.m
//  FollowmeiOS
//
//  Created by Subo on 16/5/25.
//  Copyright © 2016年 com.followme. All rights reserved.
//

#import "TagsView.h"
#import "WaterTagModel.h"
#import "WaterTagflowLayout.h"


static NSString * const kTagCellID = @"TagCellID";


@interface TagsView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<NSString *> *tagsMutableArray;
@property (strong, nonatomic) NSMutableArray<WaterTagModel *> *tagModels;
@property (nonatomic, strong)WaterTagflowLayout *flowLayout;
@end

@implementation TagsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _tagInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    _tagBorderWidth = 0;
    _tagBackgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    _tagSelectedBackgroundColor = _tagBackgroundColor;
    _tagFont = [UIFont systemFontOfSize:14];
    _tagSelectedFont = _tagFont;
    _tagTextColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    _tagSelectedTextColor = _tagTextColor;
    
    _tagHeight = 28;
    _mininumTagWidth = 0;
    _maximumTagWidth = CGFLOAT_MAX;
    _lineSpacing = 10;
    _interitemSpacing = 5;
    
    _allowsSelection = NO;
    _allowsMultipleSelection = NO;
    _allowEmptySelection = YES;
    _maximumNumberOfSelection = NSIntegerMax;
    _maxLineNumber = NSIntegerMax;
    [self addSubview:self.collectionView];
    
    UICollectionView *collectionView = self.collectionView;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(collectionView);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                   options:NSLayoutFormatAlignAllTop
                                                                   metrics:nil
                                                                     views:views];
    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
    [self addConstraints:constraints];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize;
    
    return CGSizeMake(UIViewNoIntrinsicMetric, contentSize.height);
}

- (void)setTagsArray:(NSArray<NSString *> *)tagsArray {
    _tagsMutableArray = [tagsArray mutableCopy];
    [self.tagModels removeAllObjects];
    [tagsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WaterTagModel *tagModel = [[WaterTagModel alloc] initWithName:obj font:self.tagFont];
        [self.tagModels addObject:tagModel];
    }];
    [self.collectionView reloadData];
    
    [self invalidateIntrinsicContentSize];
}

- (void)selectTagAtIndex:(NSUInteger)index animate:(BOOL)animate {
    if (index >= self.tagModels.count || !self.allowsSelection) {
        return;
    }
    
    if (self.allowsSelection && !self.allowsMultipleSelection) {
        [self deSelectAll];
    }
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                      animated:animate
                                scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)deSelectTagAtIndex:(NSUInteger)index animate:(BOOL)animate {
    if (index >= self.tagModels.count) {
        return;
    }
    [self collectionView:self.collectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)deSelectAll {
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        WaterTagModel *tagModel = self.tagModels[indexPath.row];
        tagModel.selected = NO;
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    [self.collectionView reloadData];
}

- (WaterflowTagCell *)cellForItemAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return (WaterflowTagCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - ......::::::: Edit :::::::......

- (NSUInteger)indexOfTag:(NSString *)tagName {
    __block NSUInteger index = NSNotFound;
    [self.tagsMutableArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:tagName]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    return index;
}

- (void)addTag:(NSString *)tagName {
    [self.tagsMutableArray addObject:tagName];
    WaterTagModel *tagModel = [[WaterTagModel alloc] initWithName:tagName font:self.tagFont];
    [self.tagModels addObject:tagModel];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

- (void)insertTag:(NSString *)tagName AtIndex:(NSUInteger)index {
    if (index >= self.tagsMutableArray.count) {
        return;
    }
    
    [self.tagsMutableArray insertObject:tagName atIndex:index];
    WaterTagModel *tagModel = [[WaterTagModel alloc] initWithName:tagName font:self.tagFont];
    [self.tagModels insertObject:tagModel atIndex:index];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

- (void)removeTagWithName:(NSString *)tagName {
    return [self removeTagAtIndex:[self indexOfTag:tagName]];
}

- (void)removeTagAtIndex:(NSUInteger)index {
    if (index >= self.tagsMutableArray.count || index == NSNotFound) {
        return ;
    }
    
    [self.tagsMutableArray removeObjectAtIndex:index];
    [self.tagModels removeObjectAtIndex:index];
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags {
    [self.tagsMutableArray removeAllObjects];
    [self.tagModels removeAllObjects];
    [self.collectionView reloadData];
}

#pragma mark - ......::::::: CollectionView DataSource :::::::......

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterflowTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTagCellID forIndexPath:indexPath];
    
    WaterTagModel *tagModel = self.tagModels[indexPath.row];
    cell.tagModel = tagModel;
    cell.tagLabel.text = tagModel.name;
    cell.contentInsets = self.tagInsets;
    cell.layer.cornerRadius = self.tagcornerRadius;
    cell.layer.borderWidth = self.tagBorderWidth;
    cell.layer.masksToBounds = self.tagcornerRadius > 0;
    [self setCell:cell selected:tagModel.selected];
    
    return cell;
}

- (void)setCell:(WaterflowTagCell *)cell selected:(BOOL)selected {
    
    if (selected) {
        cell.backgroundColor = self.tagSelectedBackgroundColor;
        cell.tagLabel.font = self.tagSelectedFont;
        cell.tagLabel.textColor = self.tagSelectedTextColor;
        cell.layer.borderColor = self.tagSelectedBorderColor.CGColor;
    }else {
        cell.backgroundColor = self.tagBackgroundColor;
        cell.tagLabel.font = self.tagFont;
        cell.tagLabel.textColor = self.tagTextColor;
        cell.layer.borderColor = self.tagBorderColor.CGColor;
    }
    [cell setSelected:selected];
}

#pragma mark - ......::::::: UICollectionViewDelegate :::::::......

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterflowTagCell *tagCell = (WaterflowTagCell *)cell;
    if ([self.delegate respondsToSelector:@selector(tagsView:willDispayCell:atIndex:)]) {
        [self.delegate tagsView:self willDispayCell:tagCell atIndex:indexPath.row];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagsView:shouldSelectTagAtIndex:)]) {
        return [self.delegate tagsView:self shouldSelectTagAtIndex:indexPath.row];
    }
    
    return _allowsSelection;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagsView:didDeSelectTagAtIndex:)]) {
        return [self.delegate tagsView:self shouldDeselectItemAtIndex:indexPath.row];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterTagModel *tagModel = self.tagModels[indexPath.row];
    WaterflowTagCell *cell = (WaterflowTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.allowsMultipleSelection) {
        
        if (self.collectionView.indexPathsForSelectedItems.count > self.maximumNumberOfSelection) {
            tagModel.selected = NO;
            [self setCell:cell selected:NO];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            if ([self.delegate respondsToSelector:@selector(tagsViewDidBeyondMaximumNumberOfSelection:)]) {
                [self.delegate tagsViewDidBeyondMaximumNumberOfSelection:self];
            }
            return;
        }
        
        tagModel.selected = YES;
        [self setCell:cell selected:YES];
        return;
    }
    
    //修复单选情况下，无法取消选中的问题
    if (tagModel.selected) {
        //不允许空选，直接返回
        if (!self.allowEmptySelection && self.collectionView.indexPathsForSelectedItems.count == 1) {
            return;
        }
        
        cell.selected = NO;
        collectionView.allowsMultipleSelection = YES;
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
        collectionView.allowsMultipleSelection = NO;
        return;
    }
    
    tagModel.selected = YES;
    [self setCell:cell selected:YES];
    
    if ([self.delegate respondsToSelector:@selector(tagsView:didSelectTagAtIndex:)]) {
        [self.delegate tagsView:self didSelectTagAtIndex:indexPath.row];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterTagModel *tagModel = self.tagModels[indexPath.row];
    WaterflowTagCell *cell = (WaterflowTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    tagModel.selected = NO;
    [self setCell:cell selected:NO];
    
    if ([self.delegate respondsToSelector:@selector(tagsView:didDeSelectTagAtIndex:)]) {
        [self.delegate tagsView:self didDeSelectTagAtIndex:indexPath.row];
    }
}

#pragma mark - ......::::::: UICollectionViewDelegateFlowLayout :::::::......

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterTagModel *tagModel = self.tagModels[indexPath.row];
    
    CGFloat width = tagModel.contentSize.width + self.tagInsets.left + self.tagInsets.right;
    if (width < self.mininumTagWidth) {
        width = self.mininumTagWidth;
    }
    if (width > self.maximumTagWidth) {
        width = self.maximumTagWidth;
    }
    
    return CGSizeMake(width, self.tagHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.lineSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.contentInsets;
}

#pragma mark - ......::::::: Getter and Setter :::::::......

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterTagflowLayout *flowLayout = [[WaterTagflowLayout alloc] init];
        flowLayout.delegate = self;
        _flowLayout = flowLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[WaterflowTagCell class] forCellWithReuseIdentifier:kTagCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    _collectionView.allowsSelection = _allowsSelection;
    _collectionView.allowsMultipleSelection = _allowsMultipleSelection;
    
    return _collectionView;
}

- (void)setMaxLineNumber:(NSInteger)maxLineNumber {
    _maxLineNumber = maxLineNumber;
    self.flowLayout.maxLineNumber = self.maxLineNumber;
}

- (UIFont *)tagSelectedFont {
    if (!_tagSelectedFont) {
        return _tagFont;
    }
    
    return _tagSelectedFont;
}

- (UIColor *)tagSelectedBorderColor {
    if (!_tagSelectedBorderColor) {
        return _tagBorderColor;
    }
    
    return _tagSelectedBorderColor;
}

- (NSUInteger)selectedIndex {
    return self.collectionView.indexPathsForSelectedItems.firstObject.row;
}

- (NSArray<NSString *> *)selecedTags {
//    if (!self.allowsMultipleSelection) {
//        return nil;
//    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [result addObject:self.tagsMutableArray[indexPath.row]];
    }
    
    return result.copy;
}

- (NSArray<NSNumber *> *)selectedIndexes {
//    if (!self.allowsMultipleSelection) {
//        return nil;
//    }
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
        [result addObject:@(indexPath.row)];
    }
    
    return result.copy;
}

- (NSMutableArray<WaterTagModel *> *)tagModels {
    if (!_tagModels) {
        _tagModels = [[NSMutableArray alloc] init];
    }
    return _tagModels;
}

- (NSArray<NSString *> *)tagsArray {
    return [self.tagsMutableArray copy];
}

@end
