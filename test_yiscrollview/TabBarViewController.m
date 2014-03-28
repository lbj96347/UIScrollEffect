//
//  TabBarViewController.m
//  test_yiscrollview
//
//  Created by CashLee on 14-3-28.
//  Copyright (c) 2014年 cashlee. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavViewController.h"
#import "TableViewController.h"
#import "SegmentViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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


    SegmentViewController * sgView = [[SegmentViewController alloc]init];
    
    NavViewController * navView = [[NavViewController alloc]initWithRootViewController:sgView];
    navView.title = @"列表1";
    
    TableViewController * table2 = [[TableViewController alloc]init];
    table2.title = @"列表2";
    table2.type = 1;
    
    NSArray * views = [[NSArray alloc]initWithObjects:navView,table2, nil];
    
    [self setViewControllers:views];
   
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
