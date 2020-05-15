//
//  VideoCell.h
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerView.h"

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet VideoPlayerView *videoPlayerView;
@property (weak, nonatomic) IBOutlet UIImageView *ivThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnUp;

- (void)configurationData:(NSDictionary *)itemDic;
@end

NS_ASSUME_NONNULL_END
