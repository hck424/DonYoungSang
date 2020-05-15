//
//  AppDelegate.h
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *loadingView;
+ (AppDelegate *)instance;
- (void)startIndicator;
- (void)stopIndicator;
@end

