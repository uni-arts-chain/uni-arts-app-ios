//
//  JLActionTimeView.h
//  CloudArtChain
//
//  Created by 朱彬 on 2021/2/18.
//  Copyright © 2021 朱彬. All rights reserved.
//

#import "JLBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JLActionTimeType) {
    JLActionTimeTypeWaiting, /** 未开始 */
    JLActionTimeTypeRuning, /** 拍卖中 */
    JLActionTimeTypeFinished, /** 拍卖结束 */
};

@interface JLActionTimeView : JLBaseView
- (instancetype)initWithFrame:(CGRect)frame timeType:(JLActionTimeType)timeType;
@property (nonatomic, copy) void(^actionDescBlock)(void);
@end

NS_ASSUME_NONNULL_END
