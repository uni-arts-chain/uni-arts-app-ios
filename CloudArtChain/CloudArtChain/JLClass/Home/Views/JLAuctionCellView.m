//
//  JLAuctionCellView.m
//  CloudArtChain
//
//  Created by 朱彬 on 2021/2/19.
//  Copyright © 2021 朱彬. All rights reserved.
//

#import "JLAuctionCellView.h"
#import "JLCountDownTimerView.h"
#import "JLAuctionView.h"

@interface JLAuctionCellView ()
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UIView *auctionView;
@property (nonatomic, strong) JLAuctionView *detailView;
@end

@implementation JLAuctionCellView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.timeTitleLabel];
    [self addSubview:self.timeView];
    [self addSubview:self.auctionView];
    
    [self.timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(2.0f);
        make.height.mas_equalTo(34.0f);
    }];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.timeTitleLabel.mas_bottom);
        make.height.mas_equalTo(20.0f);
    }];
    [self.auctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(200.0f);
    }];
}

- (UILabel *)timeTitleLabel {
    if (!_timeTitleLabel) {
        _timeTitleLabel = [JLUIFactory labelInitText:@"距离开始还有" font:kFontPingFangSCRegular(14.0f) textColor:JL_color_gray_101010 textAlignment:NSTextAlignmentCenter];
    }
    return _timeTitleLabel;
}

- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
        
        JLCountDownTimerView *countDownTimerView = [[JLCountDownTimerView alloc] initWithSeconds:24 * 60 * 60 seperateColor:JL_color_gray_101010 backColor:JL_color_orange_FF8650 timeColor:JL_color_white_ffffff];
        [_timeView addSubview:countDownTimerView];
        
        [countDownTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_timeView);
            make.centerX.equalTo(_timeView);
        }];
    }
    return _timeView;
}

- (UIView *)auctionView {
    if (!_auctionView) {
        _auctionView = [[UIView alloc] init];
        
        self.detailView = [[JLAuctionView alloc] init];
        [_auctionView addSubview:self.detailView];
        
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_auctionView).offset(-10.0f);
            make.left.mas_equalTo(15.0f);
            make.right.mas_equalTo(-15.0f);
            make.height.mas_equalTo(200.0f);
        }];
    }
    return _auctionView;
}

- (void)setEntryBlock:(void (^)(void))entryBlock {
    self.detailView.entryBlock = entryBlock;
}

@end
