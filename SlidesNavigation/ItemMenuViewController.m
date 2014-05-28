//
//  ItemMenuViewController.m
//  SlidesNavigation
//
//  Created by Daniel Alvarez on 5/28/14.
//  Copyright (c) 2014 Daniel Alvarez. All rights reserved.
//

#import "ItemMenuViewController.h"
#import "ItemNewsViewController.h"

@interface ItemMenuViewController () <UIPageViewControllerDataSource> {
    NSArray *items;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ItemMenuViewController

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

    
    items = [[NSArray alloc] initWithObjects:@"Item 1", @"Item 2", @"Item 3", nil];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageItemViewController"];
    self.pageViewController.dataSource = self;
    
    ItemMenuViewController *page1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"itemNewsViewController"];
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


- (ItemNewsViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index >= [items count]) {
        return nil;
    }
    
    //    NSString *identifier = [menus objectAtIndex:index];
    
    ItemNewsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"itemNewsViewController"];
    viewController.pageIndex = index;
    
    return viewController;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((ItemNewsViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ItemNewsViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [items count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [items count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


@end
