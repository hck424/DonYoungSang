//
//  VideoPlayerView.h
//  DonYoungSang
//
//  Created by 김학철 on 2020/05/14.
//  Copyright © 2020 김학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface VideoPlayerView : UIView
@property (strong, nonatomic) AVPlayer *player;
- (void)initWithVideoUrl:(NSURL *)videoUrl subTitleUrl:(NSURL *)subTitleUrl;
- (void)play;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
