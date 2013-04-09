//
//  AppDelegate.m
//  iPlayerMovies
//
//  Created by Dan on 09/04/2013.
//  Copyright (c) 2013 Dan. All rights reserved.
//


/* Notes:
 
 I have implemnted the basic version of the app - listing the movie titles in alphabetical order.
 
 In order to add some of the bonus features, only a few minor changes have to be done to the code.
 - In the list of movies there is left an "info" field which can be populated with the one line 
   tesxt of the content tag. The change should be to the query string, which currently only 
   fetches the title tags of each entry. If the whole entry is collected then other tag attributes
   can provide more info about the movie. Another way to do the same is by fetching the content tag
   which contains the html text that is displayed on the feed web page. It contains all the information
   about the movie. All extra info about the movie can be displayed in the details page, which right now 
   only contains a place holder, but can be easily changed to display the image, text, etc.
 
 - The list of the movies is currently ordered alphabetically, but doesn't discard leading words like 
   "the" / "a" which skew the actual ordering of titles. This can be overcommed by doing a bit of string
   manipulation - moving the definite article to the back of the title (e.g. "The Matrix" - "Matrix, The").
 
 I have added comments in the code where I think things can be improved or just for clarification.
  */

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
