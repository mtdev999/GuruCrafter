//
//  AppDelegate.m
//  GuruCrafter
//
//  Created by Mark Tezza on 29/05/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "AppDelegate.h"

#import "MTDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[MTDataManager sharedManager] saveContext];
}


@end
