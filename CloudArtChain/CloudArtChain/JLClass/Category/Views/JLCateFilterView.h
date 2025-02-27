//
//  JLCateFilterView.h
//  CloudArtChain
//
//  Created by 朱彬 on 2020/8/25.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "JLBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLCateFilterView : JLBaseView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title items:(NSArray *)items selectBlock:(void(^)(NSInteger index))selectBlock;
@end

NS_ASSUME_NONNULL_END
