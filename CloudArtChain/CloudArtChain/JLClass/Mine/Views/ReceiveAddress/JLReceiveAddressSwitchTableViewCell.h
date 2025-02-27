//
//  JLReceiveAddressSwitchTableViewCell.h
//  CloudArtChain
//
//  Created by 朱彬 on 2021/1/28.
//  Copyright © 2021 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLReceiveAddressSwitchTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^switchBlock)(BOOL isOn);
- (void)setTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
