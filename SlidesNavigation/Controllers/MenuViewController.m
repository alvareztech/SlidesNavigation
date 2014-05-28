//
//  MenuViewController.m
//  SlidesNavigation
//
//  Created by Daniel Alvarez on 5/28/14.
//  Copyright (c) 2014 Daniel Alvarez. All rights reserved.
//

#import "MenuViewController.h"
#import "ItemMenuViewController.h"

@interface MenuViewController () <UIPageViewControllerDataSource> {
    NSArray *menus;
}
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menus = [[NSArray alloc] initWithObjects:@"Menu 1", @"Menu 2", @"Menu 3", nil];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageViewController"];
    self.pageViewController.dataSource = self;
    
    ItemMenuViewController *page1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"itemMenuViewController"];
    NSArray *viewControllers = @[page1ViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
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

- (ItemMenuViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index >= [menus count]) {
        return nil;
    }
    
//    NSString *identifier = [menus objectAtIndex:index];
    
    ItemMenuViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"itemMenuViewController"];
    viewController.pageIndex = index;
    
    return viewController;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((ItemMenuViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ItemMenuViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [menus count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [menus count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


@end
