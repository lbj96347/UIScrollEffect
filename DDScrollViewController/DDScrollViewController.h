//
//  DDScrollViewController.h
//  
//
//  Created by CashLee on 13-11-8.
//
//

#import <UIKit/UIKit.h>

@protocol DDScrollViewDataSource;
@protocol DDScrollViewDelegate;

@interface DDScrollViewController : UIViewController

@property (nonatomic, weak) id <DDScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <DDScrollViewDelegate> delegate;

- (void)reloadData;

- (void)setActiveIndex:(NSInteger)activeIndex;

-(void)scrollToPage:(NSInteger)page;

@end


#pragma mark - dataSource
@protocol DDScrollViewDataSource <NSObject>

- (NSUInteger)numberOfViewControllerInDDScrollView:(DDScrollViewController*)DDScrollView;
- (UIViewController *)ddScrollView:(DDScrollViewController*)ddScrollView contentViewControllerAtIndex:(NSUInteger)index;

@end

#pragma mark - delegate
@protocol DDScrollViewDelegate <NSObject>

- (void)DDScrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)DDScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)DDScrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)DDScrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)DDScrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
- (void)DDScrollViewIndex:(NSInteger)index;

@end
