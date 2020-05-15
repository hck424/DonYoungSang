//
//  MainViewController.m
//  BackgroundVideoPlayer
//
//  Created by 김학철 on 2020/05/11.
//  Copyright © 2020 김학철. All rights reserved.
//

#import "MainViewController.h"
#import "VideoCell.h"
#import "TabView.h"
#import "DataBaseManager.h"
#import "AppDelegate.h"
#import "PlayViewController.h"

@interface TabButton ()
@property (nonatomic, strong) CALayer *underlineLayer;

@end
@implementation TabButton
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_underlineLayer) {
        [_underlineLayer removeFromSuperlayer];
    }
    self.underlineLayer = [[CALayer alloc] init];
    _underlineLayer.frame = CGRectMake(0, self.frame.size.height - _underLineWidth, self.frame.size.width, _underLineWidth);
    
    if (self.selected) {
        if (_colorSelect != nil) {
            _underlineLayer.backgroundColor = _colorSelect.CGColor;
        }
    }
    else {
        if (_colorNormal != nil) {
            _underlineLayer.backgroundColor = _colorNormal.CGColor;
        }
    }
    
    [self.layer addSublayer:_underlineLayer];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

@end

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, TabViewDelegate, TabViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet TabView *tabView;

@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrTabs;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrData = [NSMutableArray array];
    self.arrTabs = [NSMutableArray array];
    [_arrTabs addObject:@"영어학습"];
    [_arrTabs addObject:@"노래"];
    
    _tblView.estimatedRowHeight = 130;
    _tblView.rowHeight = UITableViewAutomaticDimension;
    
    [[AppDelegate instance] startIndicator];
    [[DataBaseManager instance] requestAllListCompletion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        [self.arrData setArray:result];
        
        [self.tblView reloadData];
        [[AppDelegate instance] stopIndicator];
    }];
    
    self.tblView.tableFooterView = [[UIView alloc] init];
    [self.tabView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil].firstObject;
    }
    [cell configurationData:[_arrData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NSDictionary *itemDic = [_arrData objectAtIndex:indexPath.row];
//    PlayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayViewController"];
//    vc.itemDic = itemDic;
//    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - TabViewDelegate TabViewDataSource
- (NSInteger)tabViewNumberOfCount {
    return _arrTabs.count;
}

- (UIButton *)tabViewIndexOfButton:(NSInteger)index {
    TabButton *btn = [TabButton buttonWithType:UIButtonTypeCustom];
    btn.colorNormal = nil;
    btn.colorSelect = [UIColor redColor];
    btn.underLineWidth = 2.0;
    
    NSString *title = [_arrTabs objectAtIndex:index];
    
    
    NSAttributedString *attrNor = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    
    NSAttributedString *attrSel = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor redColor]}];
    
    [btn setAttributedTitle:attrNor forState:UIControlStateNormal];
    [btn setAttributedTitle:attrSel forState:UIControlStateSelected];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    
    return btn;
}

- (void)tabViewDidClickedAtIndex:(NSInteger)index {
    NSLog(@"selIndex: %ld", index);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
//    CGPoint targetPoint = *targetContentOffset;
//    CGPoint currentPoint = scrollView.contentOffset;
    
    if (velocity.y > 0) {
        _titleView.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (velocity.y < 0) {
        _titleView.hidden = NO;
        [self.tblView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

@end
