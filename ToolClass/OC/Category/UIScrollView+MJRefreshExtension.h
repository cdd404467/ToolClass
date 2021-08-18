//
//  UIScrollView+MJRefreshExtension.h
//  LiveShopBrandProject
//
//  Created by caidongdong on 2021/6/18.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJRefreshExtension)
@property (assign, nonatomic) NSInteger pageCount;
/**页码*/
@property (assign, nonatomic) NSInteger pageIndex;
@property (nonatomic, strong)MJRefreshNormalHeader * mjheader;
@property (nonatomic, strong)MJRefreshAutoNormalFooter *mjfooter;

- (void)addHeaderWithRefresh:(void(^)(NSInteger pageIndex))refreshBlock;
- (void)addFooterWithRefresh:(void(^)(NSInteger pageIndex))loadMoreBlock;
- (void)endRefreshWithDataCount:(NSInteger)count;
- (void)endHeaderRefresh;
@end

NS_ASSUME_NONNULL_END
