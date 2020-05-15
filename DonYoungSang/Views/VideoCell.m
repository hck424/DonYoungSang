//
//  VideoCell.m
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import "VideoCell.h"
#import "Utility.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor clearColor];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundView = view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
}

- (void)configurationData:(NSDictionary *)itemDic {
    NSString *fileName = [itemDic objectForKey:@"fileName"];
    NSURL *url = [itemDic objectForKey:[NSString stringWithFormat:@"%@.mp4", fileName]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [Utility createThumbnailOfVideoFromRemoteUrl:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ivThumbnail.image = img;
        });
    });
    
    NSURL *titleUrl = [itemDic objectForKey:[NSString stringWithFormat:@"%@_en.txt", fileName]];
    if (fileName.length > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *title = [NSString stringWithContentsOfURL:titleUrl encoding:NSUTF8StringEncoding error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lbTitle.text = title;
                [self layoutIfNeeded];
            });
        });
    }
    _ivThumbnail.hidden = YES;
    [_videoPlayerView initWithVideoUrl:url subTitleUrl:titleUrl];
    [_videoPlayerView play];
    [self layoutIfNeeded];
}

- (IBAction)onClickedButtonAction:(UIButton *)sender {
    
}

@end
