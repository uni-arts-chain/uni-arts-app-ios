//
//  JLSellOrderListTableViewCell.m
//  CloudArtChain
//
//  Created by 朱彬 on 2021/1/20.
//  Copyright © 2021 朱彬. All rights reserved.
//

#import "JLSellOrderListTableViewCell.h"
#import "UIImage+Color.h"

@interface JLSellOrderListTableViewCell()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *cerAddressLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *deliveringButton;
@property (nonatomic, strong) UIButton *logisticsButton;
@end

@implementation JLSellOrderListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.shadowView addShadow:[UIColor colorWithHexString:@"#404040"] cornerRadius:5.0f offsetX:0];
}

- (void)setupSubViews {
    [self.contentView addSubview:self.shadowView];
    
    [self.shadowView addSubview:self.timeLabel];
    [self.shadowView addSubview:self.stateLabel];
    [self.shadowView addSubview:self.productImageView];
    [self.shadowView addSubview:self.authorLabel];
    [self.shadowView addSubview:self.productNameLabel];
    [self.shadowView addSubview:self.cerAddressLabel];
    [self.shadowView addSubview:self.priceLabel];
    [self.shadowView addSubview:self.deliveringButton];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10.0f, 15.0f, 10.0f, 15.0f));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0f);
        make.top.mas_equalTo(15.0f);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.0f);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0f);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(24.0f);
        make.width.mas_equalTo(102.0f);
        make.height.mas_equalTo(76.0f);
    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(17.0f);
        make.top.equalTo(self.productImageView.mas_top);
    }];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel.mas_left);
        make.centerY.equalTo(self.productImageView.mas_centerY);
    }];
    [self.cerAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel.mas_left);
        make.bottom.equalTo(self.productImageView.mas_bottom);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13.0f);
        make.centerY.equalTo(self.authorLabel.mas_centerY);
    }];
    [self.deliveringButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13.0f);
        make.bottom.mas_equalTo(-15.0f);
        make.width.mas_equalTo(76.0f);
        make.height.mas_equalTo(26.0f);
    }];
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = JL_color_white_ffffff;
    }
    return _shadowView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [JLUIFactory labelInitText:@"2020/08/16 12:36:28" font:kFontPingFangSCRegular(13.0f) textColor:JL_color_gray_999999 textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [JLUIFactory labelInitText:@"待发货" font:kFontPingFangSCRegular(13.0f) textColor:JL_color_red_D70000 textAlignment:NSTextAlignmentRight];
    }
    return _stateLabel;
}

- (UIImageView *)productImageView {
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
        ViewBorderRadius(_productImageView, 5.0f, 0, JL_color_clear);
    }
    return _productImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [JLUIFactory labelInitText:@"张小菲" font:kFontPingFangSCRegular(15.0f) textColor:JL_color_gray_212121 textAlignment:NSTextAlignmentLeft];
    }
    return _authorLabel;
}

- (UILabel *)productNameLabel {
    if (!_productNameLabel) {
        _productNameLabel = [JLUIFactory labelInitText:@"金发夫人" font:kFontPingFangSCMedium(15.0f) textColor:JL_color_gray_212121 textAlignment:NSTextAlignmentLeft];
    }
    return _productNameLabel;
}

- (UILabel *)cerAddressLabel {
    if (!_cerAddressLabel) {
        _cerAddressLabel = [JLUIFactory labelInitText:@"证书地址：00000010111..." font:kFontPingFangSCRegular(13.0f) textColor:JL_color_gray_999999 textAlignment:NSTextAlignmentLeft];
    }
    return _cerAddressLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [JLUIFactory labelInitText:@"¥950" font:kFontPingFangSCRegular(15.0f) textColor:JL_color_gray_212121 textAlignment:NSTextAlignmentRight];
    }
    return _priceLabel;
}

- (UIButton *)deliveringButton {
    if (!_deliveringButton) {
        _deliveringButton = [JLUIFactory buttonInitTitle:@"去发货" titleColor:JL_color_red_D70000 backgroundColor:JL_color_clear font:kFontPingFangSCRegular(13.0f) addTarget:self action:@selector(deliveringButtonClick)];
        _deliveringButton.contentEdgeInsets = UIEdgeInsetsZero;
        ViewBorderRadius(_deliveringButton, 13.0f, 0.5f, JL_color_red_D70000);
    }
    return _deliveringButton;
}

- (void)deliveringButtonClick {
    if (self.deliveringBlock) {
        self.deliveringBlock();
    }
}

- (UIButton *)logisticsButton {
    if (!_logisticsButton) {
        _logisticsButton = [JLUIFactory buttonInitTitle:@"查看物流" titleColor:JL_color_gray_212121 backgroundColor:JL_color_white_ffffff font:kFontPingFangSCRegular(13.0f) addTarget:self action:@selector(logisticsButtonClick)];
        _logisticsButton.contentEdgeInsets = UIEdgeInsetsZero;
        ViewBorderRadius(_logisticsButton, 13.0f, 0.5f, JL_color_gray_DDDDDD);
    }
    return _logisticsButton;
}

- (void)logisticsButtonClick {
    if (self.logisticsBlock) {
        self.logisticsBlock();
    }
}

@end
