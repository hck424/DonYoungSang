//
//  MainViewController.h
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TabButton : UIButton
@property (nonatomic, assign) CGFloat underLineWidth;
@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorSelect;
@end
@interface MainViewController : BaseViewController


@end

