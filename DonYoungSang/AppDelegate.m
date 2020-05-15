//
//  AppDelegate.m
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Utility.h"

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)instance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeMoviePlayback options:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    
    [FIRApp configure];
    
    return YES;
}



#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)startIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.loadingView == nil) {
            self.loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.loadingView.backgroundColor = RGBA(0, 0, 0, 0.2);
        }
        
        [self.window addSubview:self.loadingView];
        [self.loadingView startAnimationWithRaduis:25];
    });
}
- (void)stopIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.loadingView) {
            [self.loadingView stopAnimation];
        }
        [self.loadingView removeFromSuperview];
    });
}
@end
