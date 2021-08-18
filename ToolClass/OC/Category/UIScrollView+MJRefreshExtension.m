//
//  UIScrollView+MJRefreshExtension.m
//  LiveShopBrandProject
//
//  Created by caidongdong on 2021/6/18.
//

#import "UIScrollView+MJRefreshExtension.h"

#import <objc/runtime.h>


typedef void(^RefreshBlock)(NSInteger pageIndex);
typedef void(^LoadMoreBlock)(NSInteger pageIndex);

@interface UIScrollView()


/**下拉时候触发的block*/
@property (nonatomic, copy) RefreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic, copy) LoadMoreBlock loadMoreBlock;

@end

@implementation UIScrollView (MJRefreshExtension)
- (void)addHeaderWithRefresh:(void(^)(NSInteger pageIndex))refreshBlock {
    self.pageIndex = 1;
    __weak typeof(self) weakSelf = self;
    self.refreshBlock = refreshBlock;
    self.mjheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock(weakSelf.pageIndex);
        }
    }];

    self.mj_header = self.mjheader;
}

- (void)addFooterWithRefresh:(void(^)(NSInteger pageIndex))loadMoreBlock {
    self.pageIndex = 1;
    if (self.pageCount == 0)
        self.pageCount = 10;
    __weak typeof(self) weakSelf = self;
    self.loadMoreBlock = loadMoreBlock;
    self.mjfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex += 1;
        if (weakSelf.loadMoreBlock) {
            weakSelf.loadMoreBlock(weakSelf.pageIndex);
        }
    }];
    
//    [self.mjfooter setTitle:@"———         没有更多内容啦        ———" forState:MJRefreshStateNoMoreData];
//    self.mjfooter.stateLabel.font = [UIFont systemFontOfSize:13];
//    self.mjfooter.stateLabel.textColor = HEXColor(@"#999999", 1);
//    self.mjfooter.automaticallyRefresh = YES;
//    self.mjfooter.hidden = YES;
    self.mj_footer = self.mjfooter;
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

- (void)endRefreshWithDataCount:(NSInteger)count {
    if (count < self.pageCount && self.pageIndex == 1) {
        self.mj_footer.hidden = YES;
    } else {
        self.mj_footer.hidden = NO;
    }
    if (count < self.pageCount) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        if (self.mj_header.isRefreshing) {
            [self.mj_header endRefreshing];
            [self.mj_footer resetNoMoreData];
        }
        if (self.mj_footer.isRefreshing) {
            [self.mj_footer endRefreshing];
        }
    }
}

- (void)endHeaderRefresh {
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
}

#pragma mark - 添加属性
//当前是第几页
static void *pagaIndexKey = &pagaIndexKey;
- (NSInteger)pageIndex
{
    return [objc_getAssociatedObject(self, &pagaIndexKey) integerValue];
}
- (void)setPageIndex:(NSInteger)pageIndex{
    [self.mj_footer resetNoMoreData];
    objc_setAssociatedObject(self, &pagaIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}


//每页展示多少条数据
static void *pagaCountKey = &pagaCountKey;
- (NSInteger)pageCount
{
    return [objc_getAssociatedObject(self, &pagaCountKey) integerValue];
}
- (void)setPageCount:(NSInteger)pageCount {
    objc_setAssociatedObject(self, &pagaCountKey, @(pageCount), OBJC_ASSOCIATION_ASSIGN);
}

//MJRefreshAutoNormalFooter *footer
static void *mjfooterKey = &mjfooterKey;
- (MJRefreshAutoNormalFooter *)mjfooter {
    return objc_getAssociatedObject(self, &mjfooterKey);
}
- (void)setMjfooter:(MJRefreshAutoNormalFooter *)mjfooter {
    objc_setAssociatedObject(self, &mjfooterKey, mjfooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//MJRefreshNormalHeader *header
static void *mjheaderKey = &mjheaderKey;
- (MJRefreshNormalHeader *)mjheader {
    return objc_getAssociatedObject(self, &mjheaderKey);
}
- (void)setMjheader:(MJRefreshNormalHeader *)mjheader {
    objc_setAssociatedObject(self, &mjheaderKey, mjheader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//下拉刷新回调
static void *RefreshBlockKey = &RefreshBlockKey;
- (RefreshBlock)refreshBlock {
    return objc_getAssociatedObject(self, &RefreshBlockKey);
}
- (void)setRefreshBlock:(void (^)(void))RefreshBlock {
    objc_setAssociatedObject(self, &RefreshBlockKey, RefreshBlock, OBJC_ASSOCIATION_COPY);
}

//上拉加载更多回调
static void *LoadMoreBlockKey = &LoadMoreBlockKey;
- (LoadMoreBlock)loadMoreBlock {
    return objc_getAssociatedObject(self, &LoadMoreBlockKey);
}
- (void)setLoadMoreBlock:(LoadMoreBlock)loadMoreBlock {
    objc_setAssociatedObject(self, &LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_COPY);
}
@end
