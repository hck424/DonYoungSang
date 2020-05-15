//
//  VideoPlayerView.m
//  DonYoungSang
//
//  Created by 김학철 on 2020/05/14.
//  Copyright © 2020 김학철. All rights reserved.
//

#import "VideoPlayerView.h"


@interface VideoPlayerView ()
@property (weak, nonatomic) IBOutlet UIView *playerView;

@end
@implementation VideoPlayerView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadXib];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self loadXib];
    }
    return self;
}

- (void)loadXib {
    
    UIView *xib = [[UINib nibWithNibName:@"VideoPlayerView" bundle:nil] instantiateWithOwner:self options:nil].firstObject;;
    
    [self addSubview:xib];
    xib.translatesAutoresizingMaskIntoConstraints = NO;
    [xib.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [xib.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [xib.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
    [xib.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
}

- (void)initWithVideoUrl:(NSURL *)videoUrl subTitleUrl:(NSURL *)subTitleUrl {
    
    // 1 - Load video asset
    AVAsset *videoAsset = [AVURLAsset URLAssetWithURL:videoUrl options:nil];
    
    // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    // 3 - Video track
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    
    // 4 - Subtitle track
    AVURLAsset *subtitleAsset = [AVURLAsset URLAssetWithURL:subTitleUrl options:nil];
    
    AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
                                                                           preferredTrackID:kCMPersistentTrackID_Invalid];
    NSArray *arrAsset = [subtitleAsset tracksWithMediaType:AVMediaTypeText];
    [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                           ofTrack:[arrAsset firstObject]
                            atTime:kCMTimeZero error:nil];
    
    // 5 - Set up player
    self.player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:mixComposition]];
    self.player.appliesMediaSelectionCriteriaAutomatically = YES;
    
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    avPlayerLayer.frame = _playerView.bounds;
    [_playerView.layer addSublayer:avPlayerLayer];
    
    avPlayerLayer.borderColor = [UIColor redColor].CGColor;
    avPlayerLayer.borderWidth = 1.0f;
    avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
}

- (void)play {
    [self.player play];
}

- (void)stop {
    [self.player pause];
}

//AVF_EXPORT NSString *const AVPlayerItemTimeJumpedNotification             API_AVAILABLE(macos(10.7), ios(5.0), tvos(9.0), watchos(1.0));    // the item's current time has changed discontinuously
//AVF_EXPORT NSString *const AVPlayerItemDidPlayToEndTimeNotification      API_AVAILABLE(macos(10.7), ios(4.0), tvos(9.0), watchos(1.0));   // item has played to its end time
//AVF_EXPORT NSString *const AVPlayerItemFailedToPlayToEndTimeNotification API_AVAILABLE(macos(10.7), ios(4.3), tvos(9.0), watchos(1.0));   // item has failed to play to its end time
//AVF_EXPORT NSString *const AVPlayerItemPlaybackStalledNotification       API_AVAILABLE(macos(10.9), ios(6.0), tvos(9.0), watchos(1.0));    // media did not arrive in time to continue playback
//AVF_EXPORT NSString *const AVPlayerItemNewAccessLogEntryNotification     API_AVAILABLE(macos(10.9), ios(6.0), tvos(9.0), watchos(1.0));    // a new access log entry has been added
//AVF_EXPORT NSString *const AVPlayerItemNewErrorLogEntryNotification         API_AVAILABLE(macos(10.9), ios(6.0), tvos(9.0), watchos(1.0));    // a new error log entry has been added
//AVF_EXPORT NSNotificationName const AVPlayerItemRecommendedTimeOffsetFromLiveDidChangeNotification         API_AVAILABLE(macos(10.15), ios(13.0), tvos(13.0), watchos(6.0));    // the value of recommendedTimeOffsetFromLive has changed
//AVF_EXPORT NSNotificationName const AVPlayerItemMediaSelectionDidChangeNotification        API_AVAILABLE(macos(10.15), ios(13.0), tvos(13.0), watchos(6.0)); // a media selection group changed its selected option

- (void)notifiactionHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:AVPlayerItemFailedToPlayToEndTimeNotification]) {
        
    }
    
}
@end
