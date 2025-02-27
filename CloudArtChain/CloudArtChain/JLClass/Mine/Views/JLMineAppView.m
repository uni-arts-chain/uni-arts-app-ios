//
//  JLMineAppView.m
//  CloudArtChain
//
//  Created by 朱彬 on 2020/8/26.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "JLMineAppView.h"
#import "UIImage+JLTool.h"
#import "UIButton+AxcButtonContentLayout.h"

@interface JLMineAppView ()
@property (nonatomic, strong) NSArray *appImageArray;
@property (nonatomic, strong) NSArray *appTitleArray;
@end

@implementation JLMineAppView

- (NSArray *)appImageArray {
    if (!_appImageArray) {
        _appImageArray = @[@"icon_mine_app_order_buy", @"icon_mine_app_order_sell", @"icon_mine_app_message", @"icon_mine_app_customer_service", @"icon_mine_app_homepage", @"icon_mine_app_collect", @"icon_mine_app_work_upload", @"icon_mine_app_address", @"icon_mine_app_auction", @"icon_mine_app_feedback", @"icon_mine_app_aboutus", @"", @""];
    }
    return _appImageArray;
}

- (NSArray *)appTitleArray {
    if (!_appTitleArray) {
        _appTitleArray = @[@"买入订单", @"卖出订单", @"消息", @"客服", @"我的主页", @"作品收藏", @"上传作品", @"收货地址", @"发起拍卖", @"意见反馈", @"关于我们", @"", @""];
    }
    return _appTitleArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JL_color_white_ffffff;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    NSInteger row = self.appImageArray.count / 4;
    CGFloat lineSep = 30.0f;
    CGFloat itemWidth = (kScreenWidth - 15.0f * 2) / 4.0f;
    CGFloat itemHeight = (self.frameHeight - (row - 1) *lineSep) / row;
    for (int i = 0; i < self.appImageArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((i % 4) * itemWidth + 15.0f, (i / 4) * (itemHeight + lineSep), itemWidth, itemHeight);
        if (![NSString stringIsEmpty:self.appImageArray[i]]) {
            [button setTitle:self.appTitleArray[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:self.appImageArray[i]] forState:UIControlStateNormal];
            [button setTitleColor:JL_color_gray_101010 forState:UIControlStateNormal];
            button.titleLabel.font = kFontPingFangSCRegular(13.0f);
            button.tag = 2000 + i;
            button.axcUI_buttonContentLayoutType = AxcButtonContentLayoutStyleCenterImageTop;
            button.axcUI_padding = 12.0f;
            [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:button];
    }
}

- (void)itemClick:(UIButton *)sender {
    if (self.appClickBlock) {
        self.appClickBlock(sender.tag - 2000);
    }
}
@end
