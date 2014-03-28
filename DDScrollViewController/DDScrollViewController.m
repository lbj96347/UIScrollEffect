//
//  DDScrollViewController.m
//  
//
//  Created by CashLee on 13-11-8.
//
//

#import "DDScrollViewController.h"

@interface DDScrollViewController () <UIScrollViewDelegate>
@property UIScrollView *scrollView;
@property NSMutableArray *contents;
@property (nonatomic) CGFloat offsetRadio;
@property (nonatomic) NSInteger activeIndex;
@property (nonatomic) CGRect originalFrame;
@end

@implementation DDScrollViewController

@synthesize delegate;

-(void)viewDidAppear:(BOOL)animated
{
    self.originalFrame = self.tabBarController.tabBar.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initControl];
    
    [self reloadData];
}

- (void)initControl
{
    self.contents = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i ++)
    {
        [self.contents addObject:[NSNull null]];
    }
    
   
    self.scrollView = [[UIScrollView alloc] initWithFrame: self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 3, CGRectGetHeight(self.view.frame));
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
   
    [self.view addSubview: self.scrollView];

}

#pragma mark - 

-(void)scrollToPage:(NSInteger)page
{
    [self.scrollView setContentOffset:CGPointMake(960, 0) animated:YES];
}

#pragma mark -

- (void)reloadData
{
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < 3; i ++)
    {
        NSInteger thisPage = [self validIndexValue: self.activeIndex - 1 + i];
        [self.contents replaceObjectAtIndex: i withObject:[self.dataSource ddScrollView:self contentViewControllerAtIndex:thisPage]];
    }

    for (int i = 0; i < 3; i++)
    {
        UIViewController* viewController = [self.contents objectAtIndex:i];
        UIView* view = viewController.view;
        view.userInteractionEnabled = YES;
        view.frame = self.view.bounds;
        view.frame = CGRectOffset(self.scrollView.frame, view.frame.size.width * i, 0);
        [self.scrollView addSubview:view];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width + self.scrollView.frame.size.width * self.offsetRadio, 0)];
}

- (NSInteger)validIndexValue:(NSInteger)value
{
    if(value == -1)
    {
        value = self.numberOfControllers - 1;
    }
    
    if(value == self.numberOfControllers)
    {
        value = 0;
    }
    
    return value;
}

- (void)setActiveIndex:(NSInteger)activeIndex
{
    [delegate DDScrollViewIndex:activeIndex];
    if (_activeIndex != activeIndex)
    {
        _activeIndex = activeIndex;
        [self reloadData];
    }
}

- (NSInteger)numberOfControllers
{
    return [self.dataSource numberOfViewControllerInDDScrollView:self];
}

- (void)setOffsetRadio:(CGFloat)offsetRadio
{
    if (_offsetRadio != offsetRadio)
    {
        _offsetRadio = offsetRadio;
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width + self.scrollView.frame.size.width * offsetRadio, 0)];
        if (offsetRadio > 0.5)
        {
            _offsetRadio = offsetRadio - 1;
            self.activeIndex = [self validIndexValue: self.activeIndex + 1];
        }
        
        if (offsetRadio < -0.5)
        {
            _offsetRadio = offsetRadio + 1;
            self.activeIndex = [self validIndexValue: self.activeIndex - 1];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.offsetRadio = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame) - 1;
    
    UITabBar *tb = self.tabBarController.tabBar;
    NSInteger yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        tb.frame = CGRectMake(tb.frame.origin.x, self.originalFrame.origin.y + yOffset, tb.frame.size.width, tb.frame.size.height);
    }
    if (yOffset < 1) tb.frame = self.originalFrame;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [delegate DDScrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [delegate DDScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [delegate DDScrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [delegate DDScrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [delegate DDScrollViewDidEndScrollingAnimation:scrollView];
}

@end