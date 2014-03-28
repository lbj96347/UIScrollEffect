//
//  SegmentViewController.m
//  test_yiscrollview
//
//  Created by CashLee on 14-3-28.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import "SegmentViewController.h"
#import "TableViewController.h"

@interface SegmentViewController ()

@property (nonatomic, retain) DDScrollViewController * ddScrollViewController;
@property (nonatomic, retain) NSMutableArray * viewControllerArray;

@end

@implementation SegmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ddScrollViewController = [[DDScrollViewController alloc]init];
    
    self.ddScrollViewController.dataSource = self;
    
    TableViewController * listView1 = [[TableViewController alloc]init];
    listView1.type = 0;
    TableViewController * listView2 = [[TableViewController alloc]init];
    listView2.type = 1;
    TableViewController * listView3 = [[TableViewController alloc]init];
    listView3.type = 0;
    
    self.viewControllerArray = [[NSMutableArray alloc]initWithObjects:listView1,listView2,listView3,nil];
    [self.view addSubview:self.ddScrollViewController.view];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DDScrollViewDataSource

- (NSUInteger)numberOfViewControllerInDDScrollView:(DDScrollViewController *)DDScrollView
{
    return [self.viewControllerArray count];
}

- (UIViewController*)ddScrollView:(DDScrollViewController *)ddScrollView contentViewControllerAtIndex:(NSUInteger)index
{
    return [self.viewControllerArray objectAtIndex:index];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
