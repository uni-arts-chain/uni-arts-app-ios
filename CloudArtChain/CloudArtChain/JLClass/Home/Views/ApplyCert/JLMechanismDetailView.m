//
//  JLMechanismDetailView.m
//  CloudArtChain
//
//  Created by 朱彬 on 2020/9/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "JLMechanismDetailView.h"

@interface JLMechanismDetailView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timesLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JLMechanismDetailView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.timesLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.lineView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0f);
        make.top.mas_equalTo(18.0f);
        make.height.mas_equalTo(17.0f);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.0f);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.height.mas_equalTo(15.0f);
    }];
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(15.0f);
        make.height.mas_equalTo(14.0f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0f);
        make.bottom.equalTo(self);
        make.right.mas_equalTo(-15.0f);
        make.height.mas_equalTo(1.0f);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [JLUIFactory labelInitText:@"南京艺术品鉴定机构" font:kFontPingFangSCMedium(17.0f) textColor:JL_color_gray_212121 textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [JLUIFactory labelInitText:@"签名费用：￥99/次" font:kFontPingFangSCMedium(15.0f) textColor:JL_color_red_D70000 textAlignment:NSTextAlignmentRight];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
        [attr addAttributes:@{NSFontAttributeName: kFontPingFangSCRegular(15.0f), NSForegroundColorAttributeName: JL_color_gray_101010} range:NSMakeRange(0, 5)];
        _priceLabel.attributedText = attr;
    }
    return _priceLabel;
}

- (UILabel *)timesLabel {
    if (!_timesLabel) {
        _timesLabel = [JLUIFactory labelInitText:@"已签名：186次" font:kFontPingFangSCRegular(14.0f) textColor:JL_color_gray_212121 textAlignment:NSTextAlignmentLeft];
    }
    return _timesLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = JL_color_gray_DDDDDD;
    }
    return _lineView;
}
@end
